//
//  RepositoryProtocol.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 01/05/23.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype data
    func fetch(completionBlock: @escaping (Bool, data?, AppError?) -> Void)
}
