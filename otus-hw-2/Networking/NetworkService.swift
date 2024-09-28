/////
////  NetworkService.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import SwiftUI
import OpenAPIRuntime
import OpenAPIURLSession
import Foundation
import NewsAPI

final class NetworkService {
    var client: APIProtocol
    
    init(mock: Bool = false) {
#if DEBUG
        guard !mock else {
            self.client = MockClient()
            return
        }
#endif
        self.client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport(),
            middlewares: [
//                    LoggingMiddleware(loggingPolicy: .brief),
            ]
        )
        
    }
}
