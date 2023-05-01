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
    private var articleListRaw: [ArticleViewDataProtocol]?
    private var dataBindClosure: (([ArticleViewDataProtocol]) -> Void)?
    private var apiService: APIClientProtocol
    
    var data: [ArticleViewDataProtocol]? {
        didSet {
            if let block = self.dataBindClosure {
                block(self.data ?? [])
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
    
    func openArticleDetail(with article: ArticleViewDataProtocol) {
        if let delegate = self.delegate {
            delegate.openArticleDetail(with: article)
        }
    }
    
    func bindData(_ block: @escaping ([ArticleViewDataProtocol]) -> Void) {
        self.dataBindClosure = block
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
        self.apiService.getMostPopularArticle { success, responseData, _ in
            if !success {
                self.data = nil
            } else {
                self.articleListRaw = responseData?.results?.map { ArticleViewData(articleRaw: $0) }
                self.data = self.articleListRaw
            }
        }
    }
}
