//
//  Environments.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 01/05/23.
//

import Foundation

public struct Environment {
    private enum Keys {
        static let baseURL = "BASE_URL"
        static let mostPopularArticleEndpoint = "MOST_POPULAR_ARTICLES_ENDPOINT"
        static let apiKey = "API_KEY"
        static let networkProtocol = "NETWORK_PROTOCOL"
    }
    
    static let baseURL: String = {
        guard let baseURLProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.baseURL
        ) as? String else {
            fatalError("BASE_URL not found")
        }
        return baseURLProperty
    }()
    
    static let apiKey: String = {
        guard let baseURLProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.apiKey
        ) as? String else {
            fatalError("apiKey not found")
        }
        return baseURLProperty
    }()
    
    static let mostPopularArticleEndpoint: String = {
        guard let baseURLProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.mostPopularArticleEndpoint
        ) as? String else {
            fatalError("mostPopularArticleEndpoint not found")
        }
        return baseURLProperty
    }()
    
    static let networkProtocol: String = {
        guard let baseURLProperty = Bundle.main.object(
            forInfoDictionaryKey: Keys.networkProtocol
        ) as? String else {
            fatalError("mostPopularArticleEndpoint not found")
        }
        return baseURLProperty
    }()
}
