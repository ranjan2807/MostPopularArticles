//
//  APIClientProtocol.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 01/05/23.
//

import Foundation

protocol APIClientProtocol {
    func getList(completionBlock: @escaping (Bool, Data?, AppError?) -> Void)
}
