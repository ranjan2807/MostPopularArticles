//
//  ArticleListCoordinator.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

protocol ArticleListViewModelToCoordinatorProtocol: AnyObject {
    func openArticleDetail(with model: ArticleListViewDataProtocol)
}

class ArticleListCoordinator {
    var childCoordinator: [Coordinator]? = []
    
    var viewController: ArticleListViewController
    
    init(with viewController: ArticleListViewController) {
        self.viewController = viewController
    }
}

extension ArticleListCoordinator: Coordinator {
    func start() {
        let url = AppUrl.most_popular_article
        let apiClient = GETAPIClient(urlString: url.value)
        let parser = MostPopularArticleParser()
        let repo = MostPopularArticlesRepository (
            articleApiClient: apiClient,
            parser: parser
        )
        
        let viewModel = ArticleListViewModel (
            with: self,
            repoService: repo
        )
        self.viewController.viewModel = viewModel
    }
}

extension ArticleListCoordinator: ArticleListViewModelToCoordinatorProtocol {
    func openArticleDetail(with model: ArticleListViewDataProtocol) {
        guard let viewController = ArticleDetailViewController.initialize() else { return }
        
        guard let model = model as? ArticleDetailViewDataProtocol else { return }
        
        let coordinator = ArticleDetailCoordinator(
            with: viewController, article: model
        ) { [weak self] _ in
            guard let self = self else { return }
            guard var childCoordinator = self.childCoordinator else { return }
            childCoordinator.removeLast()
        }
        coordinator.start()
        
        childCoordinator = childCoordinator! + [coordinator]
        
        self.viewController.present(viewController, animated: true)
    }
}
