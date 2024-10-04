/////
////  ArticleDetailView.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import SwiftUI
import NewsAPI

struct ArticleDetailView: View {
    private let article: NewsAPI.Components.Schemas.Article
    init(_ article: NewsAPI.Components.Schemas.Article) {
        self.article = article
    }
    
    var body: some View {
        ScrollView {
            Text(article.title)
                .font(.system(.title2))
                .padding(.horizontal)
            HStack {
                Text(article.date)
                Spacer()
                NavigationLink(value: article) {
                    Text("Suggested links")
                }
            }.padding(.horizontal)
            
            AsyncImage(
                url: URL(string: article.image ?? ""),
                transaction: Transaction(animation: .easeInOut)
            ) { phase in
                switch phase {
                case .empty:
                    if article.image == nil {
                        Image(systemName: "rectangle.slash")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        ProgressView()
                    }
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .transition(.scale(scale: 0.1, anchor: .center))
                case .failure:
                    Image(systemName: "exclamationmark.square")
                        .resizable().scaledToFit().frame(height: 200)
                @unknown default:
                    Image(systemName: "exclamationmark.square")
                        .resizable().scaledToFit()
                }
            }
            .frame(minHeight: 100, maxHeight: 300)
            
            Text(article.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
        }
        .navigationDestination(for: NewsAPI.Components.Schemas.Article.self) {
            ArticleLinksView($0)
        }
    }
}




#Preview {
    NavigationStack {
        ArticleDetailView(.mock())
    }
}
