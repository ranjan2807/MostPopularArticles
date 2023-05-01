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
    var data: [ArticleListViewDataProtocol]? { get set }
    func loadData()
    func bindData(_ block: @escaping ([ArticleListViewDataProtocol]) -> Void)
    
    func bindDataError(_ block: @escaping (String) -> Void)
    
    func openArticleDetail(with article: ArticleListViewDataProtocol)
    func filterArticleBasedOn(searchText: String)
}

protocol ArticleDetailViewModelProtocol: ViewModelProtocol {
    var data: ArticleDetailViewDataProtocol? { get set }
    func loadData()
    func bindData(_ block: @escaping (ArticleDetailViewDataProtocol) -> Void)
    
    func closeScreen()
}
