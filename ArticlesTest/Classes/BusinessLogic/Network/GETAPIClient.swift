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
    func getList(completionBlock: @escaping (Bool, Data?, AppError?) -> Void) {
        guard let url = URL(string: self.urlString) else {
            completionBlock(false, nil, .invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completionBlock(false, nil, .error(error.localizedDescription))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode else {
                print(AppError.generic)
                completionBlock(false, nil, .generic)
                return
            }
            
            completionBlock(true, data, nil)
            
        }.resume()
    }
}
