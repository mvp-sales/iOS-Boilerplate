//
//  GetHeadlinesSourcesNewsApiResponse.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import Foundation

struct GetHeadlinesSourcesNewsApiResponse: Codable {
    let status: String
    let sources: [NewsSourceDto]
}
