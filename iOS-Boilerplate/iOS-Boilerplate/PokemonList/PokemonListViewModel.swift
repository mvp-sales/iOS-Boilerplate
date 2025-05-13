//
//  PokemonListViewModel.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import UIKit

@MainActor
class PokemonListViewModel {
    var itemsCount: Int {
        _items.count
    }
    var items: [PokemonData] {
        _items
    }
    private var _items: [PokemonData] = []
    private let apiClient: PokemonAPI = PokemonAPIClient()
    
    var onItemsLoaded: (() -> ())?
    var onError: ((String) -> ())?
    
    func loadPokemons() async {
        let result = await apiClient.loadPokemons(offset: itemsCount)
        
        switch(result) {
        case .success(let pokemonListData):
            _items = pokemonListData.results
            onItemsLoaded?()
        case .failure(let error):
            onError?(error.localizedDescription)
        }
    }
}
