/////
////  ArticleLinksView.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import SwiftUI
import NewsAPI

struct ArticleLinksView: View {
    private let article: NewsAPI.Components.Schemas.Article
    init(_ article: NewsAPI.Components.Schemas.Article) {
        self.article = article
    }

    var body: some View {
        List {
            ForEach(article.links ?? []) { link in
                Link(destination: URL(string: link)!) {
                    Text(link)
                }
            }
        }
        .navigationTitle("Suggested links")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ArticleLinksView(.mock())
    }
}

extension String: @retroactive Identifiable {
    public var id: Self { self }
}
