/////
////  NewsViewModel.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import SwiftUI
import OpenAPIRuntime
import NewsAPI

final class NewsViewModel: ObservableObject {
    enum ListSelection: String, CaseIterable, Equatable {
        case iPhone = "iPhone"
        case iWatch = "iWatch"
        case visionPro = "Vision Pro"
        
        var keywords: [String] {
            return switch self {
            case .iPhone: ["apple", "iPhone"]
            case .iWatch: ["apple", "iWatch"]
            case .visionPro: ["apple", "Vision Pro"]
            }
        }
    }
    enum PaginationState {
        case isLoading
        case idle
        case error(errorMessage: String)
    }
    
    private var container: NetworkService
    private var page: Int = 1
    private var keywords: [String] = []

    @MainActor @Published var articles: [NewsAPI.Components.Schemas.Article] = []
    @MainActor @Published var paginationState: PaginationState = .idle
    @MainActor @Published var isMoreDataAvailable: Bool = true
    
    init(container: NetworkService, selection: ListSelection) {
        self.container = container
        self.keywords = selection.keywords
    }
    
    @MainActor func setKeywords(_ selection: ListSelection) {
        self.keywords = selection.keywords
        self.page = 1
        self.isMoreDataAvailable = true
        self.articles.removeAll()
    }

    @MainActor func fetch() {
        paginationState = .isLoading
        Task {
            do {
                let query = NewsAPI.Operations.getArticles.Input.Query(
                    apiKey: BuildEnvironment.newsApiKey,
                    resultType: .articles,
                    articlesPage: page,
                    articlesCount: Int(BuildEnvironment.fetchArticlesCount)!,
                    articlesSortBy: .date,
                    articlesSortByAsc: false,
                    articleBodyLen: -1,
                    keyword: keywords,
                    lang: [.eng],
                    includeArticleBody: true,
                    includeArticleImage: true,
                    includeArticleLinks: true
                )
                let response = try await container.client.getArticles(query: query)
                
                switch(response) {
                case .ok(let okResponce):
                    
                    let pagination: NewsAPI.Components.Schemas.MultipleItems = try okResponce.body.json.value1.articles.value1
                    print("Pagination:", pagination)
                    let result: [NewsAPI.Components.Schemas.Article] = try okResponce.body.json.value1.articles.value2.results

                        articles.append(contentsOf: result)
                        if page < pagination.pages, !articles.isEmpty {
                            page += 1
                        } else {
                            isMoreDataAvailable = false
                        }
                        paginationState = .idle
                case .undocumented(let statusCode, let payload):
                    let message = try await String(collecting: payload.body!, upTo: 1024)
                    print("Request error:", statusCode, "message:", message)
                    paginationState = .error(errorMessage: message)
                }
            } catch {
                let message: String
                switch error {
                case let decodingError as DecodingError:
                    print("Decoding error:", decodingError.localizedDescription)
                    message = "Ill-formed reply"
                case let clientError as ClientError:
                    print("Underlying:", clientError.underlyingError.localizedDescription)
                    message = clientError.underlyingError.localizedDescription
                default:
                    print("Unknown error:", error)
                    message = "Unknown error"
                }
                paginationState = .error(errorMessage: message)
            }
        }
    }
}
