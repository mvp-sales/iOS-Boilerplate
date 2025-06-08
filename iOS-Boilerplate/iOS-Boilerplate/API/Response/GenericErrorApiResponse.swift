//
//  GenericErrorApiResponse.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import Foundation

struct GenericErrorApiResponse: Error, Codable {
    let status: String
    let code: String
    let message: String
}

extension GenericErrorApiResponse {
    static var genericError: GenericErrorApiResponse {
        GenericErrorApiResponse(status: "520", code: "-1", message: "Internal app error")
    }
}
