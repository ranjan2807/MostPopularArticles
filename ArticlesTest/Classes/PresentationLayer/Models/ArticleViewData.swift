//
//  File.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

protocol ArticleViewDataProtocol {
    var id: String { get }
    var title: String { get }
    var thumbnailURL: URL? { get }
    var imageURL: URL? { get }
    var authors: String { get }
    var abstract: String { get }
    var htmlURL: URL? { get }
    var keywords: String { get }
    var facet: String { get }
    var caption: String { get }
    var publishedDate: String { get }
    
    func contains(searchText: String) -> Bool
}

struct ArticleViewData {
    private var articleRaw: ArticleModel
    
    init(articleRaw: ArticleModel) {
        self.articleRaw = articleRaw
    }
}

extension ArticleViewData: ArticleViewDataProtocol {
    var id: String {
        if let idTemp = articleRaw.id {
            return String(idTemp)
        } else {
            return ""
        }
    }
    
    var title: String { articleRaw.title ?? "" }
    
    var thumbnailURL: URL? {
        return URL(
            string: articleRaw.media?
                .filter { $0.type == "image" }
                .first?
                .media_metadata?
                .filter { $0.format == "Standard Thumbnail" }
                .first?
                .url ?? ""
        )
    }
    
    var imageURL: URL? {
        return URL(
            string: articleRaw.media?
                .filter { $0.type == "image" }
                .first?
                .media_metadata?
                .filter { $0.format == "mediumThreeByTwo440" }
                .first?
                .url ?? ""
        )
    }
    
    var authors: String { articleRaw.byline ?? "" }
    
    var abstract: String { articleRaw.abstract ?? "" }
    
    var htmlURL: URL? {
        guard let urlStr = articleRaw.url,
                let url = URL(string: urlStr) else { return nil }
        
        return url
    }
    
    var keywords: String { articleRaw.adx_keywords ?? "" }
    
    var facet: String {
        articleRaw.per_facet?.joined(separator: " ").replacingOccurrences(of: ",", with: " ") ?? ""
    }
    
    var caption: String {
        articleRaw.media?
            .filter { $0.type == "image" }
            .first?
            .caption ?? ""
    }
    
    var publishedDate: String { articleRaw.published_date ?? "" }
    
    func contains(searchText: String) -> Bool {
        return title.contains(searchText) ||
        abstract.contains(searchText) ||
        authors.contains(searchText) ||
        keywords.contains(searchText)
    }
}
