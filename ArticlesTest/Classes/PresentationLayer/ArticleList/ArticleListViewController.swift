//
//  ArticleListViewController.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 29/04/23.
//

import UIKit
import Kingfisher
import Toast_Swift

class ArticleListViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var searchBarTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblArticles: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    var viewModel: ArticleListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        bindUI()
        viewModel?.loadData()
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        if searchBarTopConstraint.constant != 13.0 {
            searchBarTopConstraint.constant = 13.0
        } else {
            searchBarTopConstraint.constant = 69.0
        }
    }
    
    private func bindUI() {
        guard let viewModel = viewModel else { return }
        
        /// Update table view whenever there is change in article list
        viewModel.bindData { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.tblArticles.reloadData()
                
                if self.loader.isAnimating {
                    self.loader.stopAnimating()
                }
            }
        }
        
        /// Show error
        viewModel.bindDataError { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.view.makeToast(error)
            }
        }
    }
    
    private func setupUI() {
        lblTitle.text = localizedStringForKey("article_list_header")
        searchBarTopConstraint.constant = 13.0
        
        tblArticles.register(
            UINib(nibName: ArticleTableViewCell.nibName, bundle: nil),
            forCellReuseIdentifier: ArticleTableViewCell.cellIdentifier
        )
    }
}

extension ArticleListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let articleList = self.viewModel?.data else { return 0 }
        return articleList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ArticleTableViewCell.cellIdentifier
        ) as? ArticleTableViewCell else {
            fatalError("unable to load ArticleTableViewCell")
        }

        guard let articleList = self.viewModel?.data else {
            fatalError("unable to load ArticleTableViewCell --> articles not available")
        }

        let articleTemp = articleList[indexPath.row]

        /// Update cell
        cell.lblTitle.text = articleTemp.title
        cell.lblAuthor.text = articleTemp.authors
        cell.lblPublishedDate.text = articleTemp.publishedDate

        cell.imgThumbnail.kf.setImage(
            with: articleTemp.thumbnailURL,
            placeholder: UIImage(named: "placeholder")
        )

        return cell
    }
}

extension ArticleListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let articleList = self.viewModel?.data else {
            fatalError("unable to load ArticleTableViewCell --> articles not available")
        }

        let articleTemp = articleList[indexPath.row]
        self.viewModel?.openArticleDetail(with: articleTemp)
    }
}

extension ArticleListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.filterArticleBasedOn(searchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.filterArticleBasedOn(searchText: "")
        searchBar.resignFirstResponder()
    }
}

extension ArticleListViewController {
    static func initialize() -> ArticleListViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "ArticleListViewController"
        ) as? ArticleListViewController else { return nil }
        
        return viewController
    }
}
