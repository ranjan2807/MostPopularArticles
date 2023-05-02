//
//  POSTAPIClient.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 02/05/23.
//

import Foundation

struct POSTAPIClient {
    private var urlString: String
    private var body: [String: Any]
    
    init(urlString: String, body: [String : Any]) {
        self.urlString = urlString
        self.body = body
    }
}

extension POSTAPIClient: APIClientProtocol {
    func getList(completionBlock: @escaping (Bool, Data?, AppError?) -> Void) {
        guard let url = URL(string: self.urlString) else {
            completionBlock(false, nil, .invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: self.body, options: [.prettyPrinted])
        
        initiateConnection(request, completionBlock)
    }
}
