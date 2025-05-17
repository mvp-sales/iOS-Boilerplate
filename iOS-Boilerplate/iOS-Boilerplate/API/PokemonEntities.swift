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

struct PokemonData: Codable, Equatable {
    let name: String
    let url: String
}

struct PokemonDetailsResponse: Codable, Equatable {
    let id: Int
    let name: String
    let height: Int
    let baseExperience: Int
    let isDefault: Bool
    let order: Int
    let weight: Int
    let species: PokemonSpeciesDTO
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case order
        case weight
        case species
        case baseExperience = "base_experience"
        case isDefault = "is_default"
    }
}

struct PokemonSpeciesDTO: Codable, Equatable {
    let name: String
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

extension PokemonDetailsResponse {
    var imageUrl: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}
