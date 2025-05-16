//
//  PokemonListViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import UIKit

class PokemonListViewModel {
    var itemsCount: Int {
        _items.count
    }
    var items: [PokemonData] {
        _items
    }
    private var _items: [PokemonData] = []
    private let apiClient: PokemonAPI
    private let coordinator: PokemonListCoordinator
    
    var onItemsLoaded: (() -> ())?
    var onError: ((String) -> ())?
    
    init(
        coordinator: PokemonListCoordinator,
        apiClient: PokemonAPI
    ) {
        self.coordinator = coordinator
        self.apiClient = apiClient
    }
    
    func loadPokemons() {
        Task {
            let result = await apiClient.loadPokemons(offset: itemsCount)
            
            await MainActor.run {
                switch(result) {
                case .success(let pokemonListData):
                    self._items.append(contentsOf: pokemonListData.results)
                    self.onItemsLoaded?()
                case .failure(let error):
                    self.onError?(error.localizedDescription)
                }
            }
        }
    }
    
    func moveToDetail(pokemonName: String) {
        coordinator.moveToPokemonDetails(pokemonName: pokemonName)
    }
}
