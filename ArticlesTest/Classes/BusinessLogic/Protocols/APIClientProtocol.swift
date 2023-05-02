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

extension APIClientProtocol {
    func initiateConnection(
        _ request: URLRequest,
        _ completionBlock: @escaping (Bool, Data?, AppError?
        ) -> Void) {
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
