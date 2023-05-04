//
//  AppUrl.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 04/05/23.
//

import Foundation

enum AppUrl {
    case most_popular_article
}

extension AppUrl {
    private var baseURL: String {
        Environment.networkProtocol + "://" + Environment.baseURL
    }
    
    private var apiKey: String { Environment.apiKey }
}

extension AppUrl {
    var value: String {
        switch self {
        case .most_popular_article:
            return self.baseURL +
            Environment.mostPopularArticleEndpoint +
            "?api-key=" +
            self.apiKey
        }
    }
}
