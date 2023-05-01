//
//  ArticleResponseModel.swift
//  ArticlesTest
//
//  Created by Ranjan Patra on 30/04/23.
//

import Foundation

struct ArticleAPIResponse: Codable {
    let status: String?
    let copyright: String?
    let num_results: Int?
    let results: [ArticleModel]?
}

struct ArticleModel: Codable {
    let uri: String?
    let url: String?
    let id: Int?
    let asset_id: Int?
    let source: String?
    let published_date: String?
    let updated: String?
    let section: String?
    let subsection: String?
    let nytdsection: String?
    let adx_keywords: String?
    let byline: String?
    let type: String?
    let title: String?
    let abstract: String?
    let des_facet: [String]?
    let org_facet: [String]?
    let per_facet: [String]?
    let media: [ArticleMediaModel]?
}

struct ArticleMediaModel: Codable {
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let approved_for_syndication: Int?
    let media_metadata: [ArticleMediaMetaDataModel]?
    
    private enum CodingKeys : String, CodingKey {
        case media_metadata = "media-metadata"
        case type, subtype, caption, copyright, approved_for_syndication
    }
}

struct ArticleMediaMetaDataModel: Codable {
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?
}
