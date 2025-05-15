//
//  PokemonDetailsViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/05/25.
//

import Foundation
import UIKit

@MainActor
class PokemonDetailsViewModel {
    
    private let pokemonName: String
    private let apiClient: PokemonAPI
    
    var onPokemonLoaded: ((PokemonDetailsResponse) -> ())?
    var onError: ((String) -> ())?
    
    init(pokemonName: String, apiClient: PokemonAPI) {
        self.pokemonName = pokemonName
        self.apiClient = apiClient
    }
    
    func loadPokemon() async {
        let result = await apiClient.getPokemonDetails(pokemonName: pokemonName)
        
        switch(result) {
        case .success(let pokemonData):
            onPokemonLoaded?(pokemonData)
        case .failure(let error):
            onError?(error.localizedDescription)
        }
    }
}
