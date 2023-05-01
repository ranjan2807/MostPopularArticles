//
//  ArticleDetailCoordinator.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

protocol ArticleDetailViewModelToCoordinatorProtocol: AnyObject {
    func closeArticleDetail()
}

class ArticleDetailCoordinator {
    var childCoordinator: [Coordinator]?
    
    private var viewController: ArticleDetailViewController
    private var model: ArticleDetailViewDataProtocol
    private var dismissClosure: (Coordinator) -> Void
    
    init(with viewController: ArticleDetailViewController,
         article: ArticleDetailViewDataProtocol,
         _ dismiss: @escaping (Coordinator) -> Void
    ) {
        self.viewController = viewController
        self.model = article
        self.dismissClosure = dismiss
    }
}

extension ArticleDetailCoordinator: Coordinator {
    func start() {
        let viewModel = ArticleDetailViewModel(data: self.model, coordinator: self)
        self.viewController.viewModel = viewModel
    }
}

extension ArticleDetailCoordinator: ArticleDetailViewModelToCoordinatorProtocol {
    func closeArticleDetail() {
        self.viewController.dismiss(animated: true) {
            self.dismissClosure(self)
        }
    }
}
