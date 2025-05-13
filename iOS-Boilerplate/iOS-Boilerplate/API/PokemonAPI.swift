//
//  PokemonAPIClient.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation

protocol PokemonAPI {
    func loadPokemons(offset: Int) async -> Result<PokemonListResponse, PokemonAPIError>
}

class PokemonAPIClient: PokemonAPI {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!

    func loadPokemons(offset: Int) async -> Result<PokemonListResponse, PokemonAPIError> {
        let url = baseURL.appendingPathComponent("pokemon").appending(queryItems: [URLQueryItem(name: "limit", value: "50")])
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            return Result.failure(PokemonAPIError.generalError)
        }

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            return Result.failure(PokemonAPIError.generalError)
        }

        guard let pokemonData = try? JSONDecoder().decode(PokemonListResponse.self, from: data) else {
            return Result.failure(PokemonAPIError.generalError)
        }
        
        return Result.success(pokemonData)
    }
}
