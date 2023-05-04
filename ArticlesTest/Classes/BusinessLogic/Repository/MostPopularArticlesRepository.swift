//
//  MostPopularArticlesRepository.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 01/05/23.
//

import Foundation

class MostPopularArticlesRepository {
    private var articleApiClient: APIClientProtocol
    private var parser: any AppParserProtocol
    
    init(articleApiClient: APIClientProtocol, parser: any AppParserProtocol) {
        self.articleApiClient = articleApiClient
        self.parser = parser
    }
}

extension MostPopularArticlesRepository: RepositoryProtocol {
    func fetch(completionBlock: @escaping (Bool, [ArticleListViewDataProtocol]?, AppError?) -> Void) {
        self.fetchList(completionBlock)
    }
}

extension MostPopularArticlesRepository {
    func fetchList( _ completionBlock: @escaping (Bool, [ArticleListViewDataProtocol]?, AppError?) -> Void) {
        articleApiClient.connect { success, apiData, error in
            guard success else {
                completionBlock(false, nil, error)
                return
            }
            
            guard let data = apiData,
                  let dataStr = String(data: data, encoding: .utf8) else {
                completionBlock(false, nil, .noDataFound)
                return
            }
            
            print(dataStr)
            let parserResponse = self.parser.start(with: data)
            
            if let error = parserResponse.error {
                completionBlock(false, nil, error)
                return
            }
            
            guard let parsedData = parserResponse.parseData as? [ArticleListViewDataProtocol]
            else {
                completionBlock(false, nil, .parseError(AppError.noDataFound.description))
                return
            }
            
            completionBlock(true, parsedData, nil)
        }
    }
}
