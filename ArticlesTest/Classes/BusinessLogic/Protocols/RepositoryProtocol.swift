//
//  RepositoryProtocol.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 01/05/23.
//

import Foundation

protocol RepositoryProtocol {
    func fetch(completionBlock: @escaping (Bool, [ArticleModel]?, AppError?) -> Void)
}
