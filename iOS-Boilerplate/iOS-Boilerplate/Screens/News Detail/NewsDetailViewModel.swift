//
//  NewsDetailViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/06/25.
//

import Foundation

@Observable
final class NewsDetailViewModel {
    let article: ArticleNews
    
    init(article: ArticleNews) {
        self.article = article
    }
}
