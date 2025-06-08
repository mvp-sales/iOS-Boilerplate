//
//  GetNewsRequest.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import Foundation

struct GetNewsRequest {
    let searchType: SearchType
    let query: String
    let sources: [String] = []
    let page: Int
    let pageSize: Int = 25
}

extension SearchType {
    var endpoint: String {
        switch self {
        case .everything:
            "everything"
        case .headlines:
            "headlines"
        }
    }
}
