//
//  PokemonData.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonData]
}

struct PokemonData: Codable {
    let name: String
    let url: String
}

enum PokemonAPIError: Error {
    case generalError
}

extension PokemonData {
    var imageUrl: URL {
        let pokemonId = url.split(separator: "/").last(where: { !$0.isEmpty }) ?? "1"
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonId).png")!
    }
}
