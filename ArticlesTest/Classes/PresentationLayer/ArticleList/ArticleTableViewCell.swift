//
//  ArticleTableViewCell.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 29/04/23.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblPublishedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ArticleTableViewCell {
    func setupUI() {
        imgThumbnail.layer.cornerRadius = imgThumbnail.frame.height/2
    }
}

extension ArticleTableViewCell {
    static var cellIdentifier: String {
        return "articles"
    }
    
    static var nibName: String {
        return "ArticleTableViewCell"
    }
}
