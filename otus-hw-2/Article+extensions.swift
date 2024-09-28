/////
////  Article+extensions.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import NewsAPI
import Foundation

extension NewsAPI.Components.Schemas.Article: @retroactive Identifiable {
    public var id: String { self.uri }
}

extension NewsAPI.Components.Schemas.Article {
    static func mock() -> Self {
        guard
            let fileName = Bundle.main.path(forResource: "article", ofType: "json"),
            let data = try? Data(contentsOf: URL(fileURLWithPath: fileName)),
            let article = try? JSONDecoder().decode(Self.self, from: data)
        else {
            fatalError("Could not load mock data")
        }
        return article
    }
}
