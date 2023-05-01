//
//  AppError.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 01/05/23.
//

import Foundation

enum AppError {
    case invalidURL
    case noNetwork
    case error(String?)
    case parseError(String?)
    case generic
}

extension AppError: CustomStringConvertible {
    var description: String {
        let prefixStr = localizedStringForKey("toast_error_prefix") + ", "
        
        switch self {
        case .invalidURL:
            return prefixStr + localizedStringForKey("invalid_url_error")
        case .noNetwork:
            return prefixStr + localizedStringForKey("no_network_error")
        case .error(let errorStr):
            return prefixStr + (errorStr ?? localizedStringForKey("network_generic_error"))
        case .parseError(let errorStr):
            return prefixStr +
            localizedStringForKey("parse_error") + " " +
            (errorStr ?? localizedStringForKey("network_generic_error"))
        case .generic:
            return prefixStr + localizedStringForKey("network_generic_error")
        }
    }
}
