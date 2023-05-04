//
//  AppParserProtocol.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 03/05/23.
//

import Foundation

protocol AppParserProtocol {
    associatedtype ParsedData
    func start(with dataRaw: Data) -> (parseData: ParsedData?, error: AppError?)
}
