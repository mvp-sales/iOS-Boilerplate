//
//  PokemonDetailsViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/05/25.
//

import Foundation
import Combine
import UIKit

class PokemonDetailsViewModel {
    
    private let pokemonName: String
    private let apiClient: PokemonAPI
    // MARK: - Publishers
    @Published private(set) var viewState: PokemonDetailsViewState = .initial
    
    init(pokemonName: String, apiClient: PokemonAPI) {
        self.pokemonName = pokemonName
        self.apiClient = apiClient
    }
    
    func loadPokemon() {
        Task {
            self.viewState = .loading
            let result = await apiClient.getPokemonDetails(pokemonName: pokemonName)
            
            switch(result) {
            case .success(let pokemonData):
                self.viewState = .loaded(pokemonData)
            case .failure(let error):
                self.viewState = .failed(error.localizedDescription)
            }
        }
    }
    
    enum PokemonDetailsViewState {
        case initial
        case loading
        case loaded(PokemonDetailsResponse)
        case failed(String)
    }
}
