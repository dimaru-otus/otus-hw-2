/////
////  MockClient.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation
import NewsAPI

#if DEBUG
final class MockClient: APIProtocol {
    private struct MockError: Error {
        let message: String
        var localizedDescription: String {
            self.message
        }
    }
    
    private func notImplementedError(_ input: any Sendable) -> ClientError {
        ClientError(operationID: "mock",
                    operationInput: input,
                    causeDescription: "Mock client error",
                    underlyingError: MockError(message: "Not implemented"))
    }
    
    func getArticles(_ input: NewsAPI.Operations.getArticles.Input) async throws -> NewsAPI.Operations.getArticles.Output {
        try await Task.sleep(nanoseconds: UInt64(3 * Double(NSEC_PER_SEC)))
        let page = input.query.articlesPage ?? 1
        guard let fileName = Bundle.main.path(forResource: "page\(page)", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        else {
            throw ClientError(operationID: "",
                              operationInput: input,
                              causeDescription: "Mock client error",
                              underlyingError: MockError(message: "Can't found mock content"))
        }
        let decoder = JSONDecoder()
        let payload = try decoder.decode(Operations.getArticles.Output.Ok.Body.jsonPayload.self, from: data)
        return .ok(Operations.getArticles.Output.Ok(body: .json(payload)))
    }
    
    func getEventForText_sol_enqueueRequest(_ input: NewsAPI.Operations.getEventForText_sol_enqueueRequest.Input) async throws -> NewsAPI.Operations.getEventForText_sol_enqueueRequest.Output {
        throw notImplementedError(input)
    }
    
    func suggestLocationsFast(_ input: NewsAPI.Operations.suggestLocationsFast.Input) async throws -> NewsAPI.Operations.suggestLocationsFast.Output {
        throw notImplementedError(input)
    }
    
    func suggestAuthorsFast(_ input: NewsAPI.Operations.suggestAuthorsFast.Input) async throws -> NewsAPI.Operations.suggestAuthorsFast.Output {
        throw notImplementedError(input)
    }
    
    func suggestSourcesFast(_ input: NewsAPI.Operations.suggestSourcesFast.Input) async throws -> NewsAPI.Operations.suggestSourcesFast.Output {
        throw notImplementedError(input)
    }
    
    func suggestCategoriesFast(_ input: NewsAPI.Operations.suggestCategoriesFast.Input) async throws -> NewsAPI.Operations.suggestCategoriesFast.Output {
        throw notImplementedError(input)
    }
    
    func suggestConceptsFast(_ input: NewsAPI.Operations.suggestConceptsFast.Input) async throws -> NewsAPI.Operations.suggestConceptsFast.Output {
        throw notImplementedError(input)
    }
    
    func getBreakingEvents(_ input: NewsAPI.Operations.getBreakingEvents.Input) async throws -> NewsAPI.Operations.getBreakingEvents.Output {
        throw notImplementedError(input)
    }
    
    func minuteStreamEvents(_ input: NewsAPI.Operations.minuteStreamEvents.Input) async throws -> NewsAPI.Operations.minuteStreamEvents.Output {
        throw notImplementedError(input)
    }
    
    func getEvent(_ input: NewsAPI.Operations.getEvent.Input) async throws -> NewsAPI.Operations.getEvent.Output {
        throw notImplementedError(input)
    }
    
    func getEventsForTopicPage(_ input: NewsAPI.Operations.getEventsForTopicPage.Input) async throws -> NewsAPI.Operations.getEventsForTopicPage.Output {
        throw notImplementedError(input)
    }
    
    func getEvents(_ input: NewsAPI.Operations.getEvents.Input) async throws -> NewsAPI.Operations.getEvents.Output {
        throw notImplementedError(input)
    }
    
    func articleMapper(_ input: NewsAPI.Operations.articleMapper.Input) async throws -> NewsAPI.Operations.articleMapper.Output {
        throw notImplementedError(input)
    }
    
    func minuteStreamArticles(_ input: NewsAPI.Operations.minuteStreamArticles.Input) async throws -> NewsAPI.Operations.minuteStreamArticles.Output {
        throw notImplementedError(input)
    }
    
    func getArticle(_ input: NewsAPI.Operations.getArticle.Input) async throws -> NewsAPI.Operations.getArticle.Output {
        throw notImplementedError(input)
    }
    
    func getArticlesForTopicPage(_ input: NewsAPI.Operations.getArticlesForTopicPage.Input) async throws -> NewsAPI.Operations.getArticlesForTopicPage.Output {
        throw notImplementedError(input)
    }
    
    func trainTopic(_ input: NewsAPI.Operations.trainTopic.Input) async throws -> NewsAPI.Operations.trainTopic.Output {
        throw notImplementedError(input)
    }
    
    func trainTopicOnTwitter(_ input: NewsAPI.Operations.trainTopicOnTwitter.Input) async throws -> NewsAPI.Operations.trainTopicOnTwitter.Output {
        throw notImplementedError(input)
    }
    
    func detectLanguage(_ input: NewsAPI.Operations.detectLanguage.Input) async throws -> NewsAPI.Operations.detectLanguage.Output {
        throw notImplementedError(input)
    }
    
    func extractArticleInfo(_ input: NewsAPI.Operations.extractArticleInfo.Input) async throws -> NewsAPI.Operations.extractArticleInfo.Output {
        throw notImplementedError(input)
    }
    
    func sentimentRNN(_ input: NewsAPI.Operations.sentimentRNN.Input) async throws -> NewsAPI.Operations.sentimentRNN.Output {
        throw notImplementedError(input)
    }
    
    func sentiment(_ input: NewsAPI.Operations.sentiment.Input) async throws -> NewsAPI.Operations.sentiment.Output {
        throw notImplementedError(input)
    }
    
    func semanticSimilarity(_ input: NewsAPI.Operations.semanticSimilarity.Input) async throws -> NewsAPI.Operations.semanticSimilarity.Output {
        throw notImplementedError(input)
    }
    
    func categorize(_ input: NewsAPI.Operations.categorize.Input) async throws -> NewsAPI.Operations.categorize.Output {
        throw notImplementedError(input)
    }
    
    func annotate(_ input: NewsAPI.Operations.annotate.Input) async throws -> NewsAPI.Operations.annotate.Output {
        throw notImplementedError(input)
    }
}
#endif
