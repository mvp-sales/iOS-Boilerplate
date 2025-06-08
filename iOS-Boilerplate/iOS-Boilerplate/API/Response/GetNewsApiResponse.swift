//
//  GetNewsApiResponse.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import Foundation

struct GetNewsApiResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [ArticleNewsDto]
}
