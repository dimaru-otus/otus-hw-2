/////
////  ContentView.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import SwiftUI
import NewsAPI

struct ContentView: View {
    @State private var listSelection: NewsViewModel.ListSelection = .iPhone
    @ObservedObject var viewModel: NewsViewModel

    init(container: NetworkService) {
        viewModel = NewsViewModel(container: container)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $listSelection) {
                    ForEach(NewsViewModel.ListSelection.allCases, id: \.self) {
                        Text($0.rawValue)
                            .tag($0.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: listSelection) {
                    viewModel.setKeywords(listSelection)
                }
                .onAppear {
                    viewModel.setKeywords(listSelection)
                }
                List {
                    ForEach(viewModel.articles) { article in
                        NavigationLink(value: article.uri) {
                            ArticleCell(image: article.image, title: article.title)
                        }
                    }
                    if viewModel.isMoreDataAvailable {
                        lastRowView
                    }
                }
            }
            .background {
                Image(systemName: "apple.logo")
                    .resizable()
                    .scaledToFit()
                    .opacity(0.2)
            }
            .refreshable {
                viewModel.setKeywords(listSelection)
            }
            .navigationTitle("Apple news")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { uri in
                if let article = viewModel.articles.first(where: { $0.uri == uri}) {
                    ArticleDetailView(article)
                }
            }
        }
    }
    
    var lastRowView: some View {
        ZStack(alignment: .center) {
            switch viewModel.paginationState {
            case .isLoading:
                HStack() {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case .idle:
                EmptyView()
            case .error(let errorMessage):
                ErrorView(errorMessage)
            }
        }
        .onAppear {
            viewModel.fetch()
        }
    }
    
    struct ArticleCell: View {
        let image: String?
        let title: String
        init(image: String?, title: String) {
            self.image = image
            self.title = title
        }

        var body: some View {
            HStack {
                AsyncImage(url: URL(string: image ?? "")) {
                    $0.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 40.0, height: 40.0)
                Text(title)
            }
        }
    }
    
    struct ErrorView: View {
        var errorMessage: String
        
        init(_ errorMessage: String) {
            self.errorMessage = errorMessage
        }
        var body: some View {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 30.0, height: 40.0)
            Text(errorMessage)
        }
    }
}

#Preview {
    ContentView(container: NetworkService(mock: true))
}
