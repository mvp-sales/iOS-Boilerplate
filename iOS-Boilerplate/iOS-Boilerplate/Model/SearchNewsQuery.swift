//
//  SearchNewsQuery.swift
//  iOS-Boilerplate
//
//  Created by User01 on 01/07/2025.
//

import Foundation

struct SearchNewsQuery {
    let searchType: SearchType
    let searchTerm: String
    let sources: [String]
    let page: Int
}
