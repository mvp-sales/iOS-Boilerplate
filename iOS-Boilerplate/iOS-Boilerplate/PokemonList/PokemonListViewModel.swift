//
//  PokemonListViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import Combine
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
    
    @Published private(set) var viewState: PokemonListViewState = .initial
    
    init(
        coordinator: PokemonListCoordinator,
        apiClient: PokemonAPI
    ) {
        self.coordinator = coordinator
        self.apiClient = apiClient
    }
    
    func loadPokemons() {
        Task {
            self.viewState = .loading
            let result = await apiClient.loadPokemons(offset: itemsCount)

            switch(result) {
            case .success(let pokemonListData):
                self._items.append(contentsOf: pokemonListData.results)
                self.viewState = .newItemsLoaded
            case .failure(let error):
                self.viewState = .failed(error.localizedDescription)
            }
        }
    }
    
    func moveToDetail(pokemonName: String) {
        coordinator.moveToPokemonDetails(pokemonName: pokemonName)
    }
    
    enum PokemonListViewState {
        case initial
        case loading
        case newItemsLoaded
        case failed(String)
    }
}
