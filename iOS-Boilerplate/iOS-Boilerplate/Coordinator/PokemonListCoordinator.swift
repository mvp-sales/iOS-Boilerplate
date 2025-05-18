//
//  PokemonListCoordinator.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 16/05/25.
//

import Foundation
import UIKit

protocol PokemonListCoordinator: BaseCoordinator {
    func moveToPokemonDetails(pokemonName: String)
}

class PokemonListCoordinatorImpl: PokemonListCoordinator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = PokemonListViewModel(
            coordinator: self,
            apiClient: PokemonAPIClient()
        )
        let viewController = PokemonListViewController(viewModel: viewModel)

        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func moveToPokemonDetails(pokemonName: String) {
        let detailCoordinator: PokemonDetailsCoordinator = PokemonDetailsCoordinatorImpl(
            navigationController: navigationController,
            pokemonName: pokemonName
        )
        detailCoordinator.start()
    }
}
