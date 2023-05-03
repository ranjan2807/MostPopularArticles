//
//  ArticleAPIClient.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

struct GETAPIClient {
    private var urlString: String
    
    init(urlString: String) {
        self.urlString = urlString
    }
}

extension GETAPIClient: APIClientProtocol {
    func connect(completionBlock: @escaping (Bool, Data?, AppError?) -> Void) {
        guard let url = URL(string: self.urlString) else {
            completionBlock(false, nil, .invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        initiateConnection(request, completionBlock)
    }
}
