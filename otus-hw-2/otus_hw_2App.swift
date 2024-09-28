/////
////  otus_hw_2App.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession
import NewsAPI

@main
struct otus_hw_2App: App {
    let container = NetworkService()
    
    var body: some Scene {
        WindowGroup {
            ContentView(container: NetworkService())
        }
    }
}
