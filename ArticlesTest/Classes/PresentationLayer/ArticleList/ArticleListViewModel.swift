//
//  ArticleListViewModel.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

class ArticleListViewModel {
//    typealias T = [ArticleModel]
    var delegate: ArticleListViewModelToCoordinatorProtocol?
    private var articleListRaw: [ArticleListViewDataProtocol]?
    private var dataBindClosure: (([ArticleListViewDataProtocol]) -> Void)?
    private var dataErrorBindClosure: ((String) -> Void)?
    private var apiService: APIClientProtocol
    
    var data: [ArticleListViewDataProtocol]? {
        didSet {
            if let block = self.dataBindClosure {
                block(self.data ?? [])
            }
        }
    }
    
    private var dataError: String? {
        didSet {
            if let block = self.dataErrorBindClosure {
                block(self.dataError ?? AppError.generic.description)
            }
        }
    }
    
    init(with coordinator: ArticleListViewModelToCoordinatorProtocol, apiService: APIClientProtocol) {
        self.delegate = coordinator
        self.apiService = apiService
    }
}

extension ArticleListViewModel: ArticleListViewModelProtocol {
    func loadData() {
        loadMostPopularArticles()
    }
    
    func openArticleDetail(with article: ArticleListViewDataProtocol) {
        if let delegate = self.delegate {
            delegate.openArticleDetail(with: article)
        }
    }
    
    func bindData(_ block: @escaping ([ArticleListViewDataProtocol]) -> Void) {
        self.dataBindClosure = block
    }
    
    func bindDataError(_ block: @escaping (String) -> Void) {
        self.dataErrorBindClosure = block
    }
    
    func filterArticleBasedOn(searchText: String) {
        if searchText == "" {
            self.data = self.articleListRaw
        } else {
            self.data = self.articleListRaw?.filter { $0.contains(searchText: searchText) }
        }
    }
}

extension ArticleListViewModel {
    private func loadMostPopularArticles() {
        self.apiService.getArticles { success, responseData, errorMsg in
            if !success {
                self.data = nil
                self.dataError = errorMsg?.description
            } else {
                self.articleListRaw = responseData?.results?.map { ArticleViewData(articleRaw: $0) }
                self.data = self.articleListRaw
            }
        }
    }
}
