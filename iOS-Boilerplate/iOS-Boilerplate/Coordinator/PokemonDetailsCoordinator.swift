//
//  PokemonDetailCoordinator.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 16/05/25.
//

import Foundation
import UIKit

protocol PokemonDetailsCoordinator: BaseCoordinator {
    
}

final class PokemonDetailsCoordinatorImpl: PokemonDetailsCoordinator {
    
    private let navigationController: UINavigationController
    private let pokemonName: String
    
    public init(navigationController: UINavigationController, pokemonName: String) {
        self.navigationController = navigationController
        self.pokemonName = pokemonName
    }
    
    func start() {
        let viewModel = PokemonDetailsViewModel(
            pokemonName: pokemonName,
            apiClient: PokemonAPIClient()
        )
        let viewController = PokemonDetailsViewController(viewModel: viewModel)

        navigationController.pushViewController(viewController, animated: false)
    }
}
