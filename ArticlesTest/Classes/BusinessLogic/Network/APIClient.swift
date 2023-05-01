//
//  APIClient.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

protocol APIClientProtocol {
    func getArticles(completionBlock: @escaping (Bool, ArticleAPIResponse?, String?) -> Void)
}

struct MostPopularAPIClient {
    private let url = URL(string: most_popular_url + api_key)
}

extension MostPopularAPIClient: APIClientProtocol {
    func getArticles(completionBlock: @escaping (Bool, ArticleAPIResponse?, String?) -> Void) {
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completionBlock(false, nil, error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode else {
                print("Something went wrong")
                completionBlock(false, nil, localizedStringForKey("network_generic_error"))
                return
            }
            
            guard let data = data,
                  let dataStr = String(data: data, encoding: .utf8) else {
                print("Something went wrong")
                completionBlock(false, nil, localizedStringForKey("network_generic_error"))
                return
            }
            
            print(dataStr)
            
            do {
                let responseDecoded = try JSONDecoder().decode( ArticleAPIResponse.self, from: data)
                completionBlock(true, responseDecoded, nil)
            } catch {
                completionBlock(false, nil, error.localizedDescription)
                print(error.localizedDescription)
            }
        }.resume()
    }
}
