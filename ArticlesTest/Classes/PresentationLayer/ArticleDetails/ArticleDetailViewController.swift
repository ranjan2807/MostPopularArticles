//
//  ArticleDetailViewController.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 29/04/23.
//

import UIKit
import Kingfisher

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var imgArticle: UIImageView!
    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAbstract: UILabel!
    @IBOutlet weak var lblAuthors: UILabel!
    
    var viewModel: (any ArticleDetailViewModelProtocol)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindUI()
        self.viewModel?.loadData()
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.viewModel?.closeScreen()
    }
    
    
    @IBAction func readMoreBtnTapped(_ sender: Any) {
        guard let article = self.viewModel?.data,
              let url = article.htmlURL else { return }
        
        UIApplication.shared.open(url)
    }
}

extension ArticleDetailViewController {
    private func setUpUI() {
        
        guard let article = self.viewModel?.data else { return }
        
        imgArticle.kf.setImage(
            with: article.imageURL,
            placeholder: UIImage(named: "placeholder")
        )
        
        lblCaption.text = article.caption
        lblTitle.text = article.title
        lblAbstract.text = article.abstract
        lblAuthors.text = article.authors
    }
    
    private func bindUI() {
        self.viewModel?.bindData { [weak self] _ in
            guard let self = self else { return }
            
            self.setUpUI()
        }
    }
}

extension ArticleDetailViewController: StoryboardInitializable {
    static func initialize() -> ArticleDetailViewController? {
        guard let viewController = ArticleDetailViewController
            .instantiateViewController() as? ArticleDetailViewController
        else { return nil }
        
        return viewController
    }
}
