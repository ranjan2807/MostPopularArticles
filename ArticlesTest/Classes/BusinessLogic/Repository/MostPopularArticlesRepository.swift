//
//  MostPopularArticlesRepository.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 01/05/23.
//

import Foundation

class MostPopularArticlesRepository {
    private var articleApiClient: APIClientProtocol?
}

extension MostPopularArticlesRepository: RepositoryProtocol {
    func fetch(completionBlock: @escaping (Bool, ArticleAPIResponse?, AppError?) -> Void) {
        let url = most_popular_url + api_key
        
        articleApiClient = GETAPIClient(urlString: url)
        articleApiClient?.getList { success, apiData, error in
            guard success else {
                completionBlock(false, nil, error)
                return
            }
            
            guard let data = apiData,
                  let dataStr = String(data: data, encoding: .utf8) else {
                print("Something went wrong")
                completionBlock(false, nil, .generic)
                return
            }
            
            print(dataStr)
            
            do {
                let responseDecoded = try JSONDecoder().decode( ArticleAPIResponse.self, from: data)
                completionBlock(true, responseDecoded, nil)
            } catch {
                completionBlock(false, nil, .parseError(error.localizedDescription))
                print(error.localizedDescription)
            }
        }
    }
}
