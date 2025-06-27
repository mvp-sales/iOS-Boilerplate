//
//  NewsSourceDto.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import Foundation

struct NewsSourceDto: Codable {
    let id: String
    let name: String
    let description: String
    let url: String
    let category: String
    let language: String
    let country: String
}

extension NewsSourceDto {
    func toDomain() -> NewsSource {
        return NewsSource(id: id, name: name, description: description, url: url, category: category, language: language, country: country, favourite: false)
    }
}
