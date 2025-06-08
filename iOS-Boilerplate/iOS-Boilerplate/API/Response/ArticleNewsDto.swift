//
//  ArticleNewsDto.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import Foundation

struct ArticleNewsDto: Codable {
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    let source: ArticleSourceNewsDto
}

struct ArticleSourceNewsDto: Codable {
    let id: String?
    let name: String
}
