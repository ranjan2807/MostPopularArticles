//
//  MostPopularArticleParser.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 03/05/23.
//

import Foundation

struct MostPopularArticleParser {
    typealias parsedData = [ArticleListViewDataProtocol]
}

extension MostPopularArticleParser: AppParserProtocol {
    func start(with dataRaw: Data) -> (parseData: [ArticleListViewDataProtocol]?, error: AppError?) {
        do {
            let responseDecoded = try JSONDecoder().decode( ArticleAPIResponse.self, from: dataRaw)
            
            if let articleListTemp = responseDecoded.results?
                .map({ ArticleViewData(articleRaw: $0) }),
                !articleListTemp.isEmpty {
                return (articleListTemp, nil)
            } else {
                return (nil, .parseError(AppError.noDataFound.description))
            }
        } catch {
            print(error.localizedDescription)
            return (nil, .parseError(error.localizedDescription))
        }
    }
    
}
