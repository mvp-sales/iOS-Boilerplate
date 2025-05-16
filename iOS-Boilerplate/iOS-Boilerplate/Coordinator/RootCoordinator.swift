//
//  RootCoordinator.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import UIKit

class RootCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private var childCoordinator: PokemonListCoordinator?

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let listCoordinator: PokemonListCoordinator = PokemonListCoordinatorImpl(navigationController: navigationController)
        self.childCoordinator = listCoordinator
        listCoordinator.start()
    }
}
