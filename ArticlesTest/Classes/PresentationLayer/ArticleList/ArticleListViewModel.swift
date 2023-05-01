//
//  ArticleListViewModel.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

class ArticleListViewModel {
    weak var delegate: ArticleListViewModelToCoordinatorProtocol?
    private var articleListRaw: [ArticleListViewDataProtocol]?
    private var dataBindClosure: (([ArticleListViewDataProtocol]) -> Void)?
    private var dataErrorBindClosure: ((String) -> Void)?
    private var articleRepo: RepositoryProtocol
    
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
    
    init(
        with coordinator: ArticleListViewModelToCoordinatorProtocol,
        repoService: RepositoryProtocol
    ) {
        self.delegate = coordinator
        self.articleRepo = repoService
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
            if let searchedData = self.articleListRaw?
                .filter({ $0.contains(searchText: searchText) }),
            !searchedData.isEmpty {
                self.data = searchedData
            } else {
                self.data = nil
                self.dataError = AppError.noDataFound.description
            }
        }
    }
}

extension ArticleListViewModel {
    private func loadMostPopularArticles() {
        self.articleRepo.fetch { success, responseData, errorMsg in
            if !success {
                self.data = nil
                self.dataError = errorMsg?.description
            } else {
                self.articleListRaw = responseData?.map { ArticleViewData(articleRaw: $0) }
                self.data = self.articleListRaw
            }
        }
    }
}
