//
//  ArticleDetailViewModel.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

class ArticleDetailViewModel {
//    typealias T = ArticleModel
    
    var data: ArticleDetailViewDataProtocol?
    private var bindDataClosure: ((ArticleDetailViewDataProtocol) -> Void)?
    var delegate: ArticleDetailViewModelToCoordinatorProtocol?
    
    init(
        data: ArticleDetailViewDataProtocol,
        coordinator: ArticleDetailViewModelToCoordinatorProtocol
    ) {
        self.data = data
        self.delegate = coordinator
    }
}

extension ArticleDetailViewModel: ArticleDetailViewModelProtocol {
    func bindData(_ block: @escaping (ArticleDetailViewDataProtocol) -> Void) {
        self.bindDataClosure = block
    }
    
    func loadData() {
        guard let article = data else { return }
        
        if let block = self.bindDataClosure {
            block(article)
        }
    }
    
    func closeScreen() {
        if let delegate = self.delegate {
            delegate.closeArticleDetail()
        }
    }
}
