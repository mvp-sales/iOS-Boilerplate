//
//  RootCoordinator.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import UIKit

@MainActor
class RootCoordinator: @preconcurrency BaseCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = PokemonListViewController(viewModel: PokemonListViewModel())
        navigationController.pushViewController(vc, animated: false)
    }
    
    func moveToDetail(id: Int) {
        
    }
}
