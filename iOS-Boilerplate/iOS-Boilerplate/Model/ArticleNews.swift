//
//  ArticleNews.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 14/06/25.
//

import Foundation

struct ArticleNews: Equatable, Identifiable, Hashable {
    let id: UUID = UUID()
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    let source: ArticleSource
}

struct ArticleSource: Equatable, Hashable {
    let id: String?
    let name: String
}

extension ArticleNews {
    func formatPublishedDate(format: String) -> String {
        let fixedDate = publishedAt.replacing("+00:00", with: "Z")
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX") // ensures consistent parsing
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = inputFormatter.date(from: fixedDate) else {
            return ""
        }

        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current

        return formatter.string(from: date)
    }
}
