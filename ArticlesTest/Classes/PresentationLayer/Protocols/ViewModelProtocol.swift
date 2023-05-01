//
//  ViewModelProtocol.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation
/*
protocol ViewModelProtocol {
    associatedtype T
    var data: T? { get set }
    func bindData(_ block: @escaping (T) -> ())
    func loadData()
}
 */

protocol ViewModelProtocol {
}

protocol ArticleListViewModelProtocol: ViewModelProtocol {
    var data: [ArticleViewDataProtocol]? { get set }
    func openArticleDetail(with article: ArticleViewDataProtocol)
    func filterArticleBasedOn(searchText: String)
    func bindData(_ block: @escaping ([ArticleViewDataProtocol]) -> Void)
    func loadData()
}

protocol ArticleDetailViewModelProtocol: ViewModelProtocol {
    func closeScreen()
    var data: ArticleViewDataProtocol? { get set }
    func bindData(_ block: @escaping (ArticleViewDataProtocol) -> Void)
    func loadData()
}
