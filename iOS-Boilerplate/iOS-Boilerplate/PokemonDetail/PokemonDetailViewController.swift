//
//  PokemonDetailViewController.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/05/25.
//

import Foundation
import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let pokemonDetailView: PokemonDetailView
    private let viewModel: PokemonDetailsViewModel
    
    init(viewModel: PokemonDetailsViewModel) {
        self.pokemonDetailView = PokemonDetailView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        viewModel.onLoading = { [weak self] isLoading in
            self?.pokemonDetailView.isLoading = isLoading
        }
        
        viewModel.onPokemonLoaded = { [weak self] pokemonData in
            self?.pokemonDetailView.configure(with: pokemonData)
        }
        
        viewModel.onError = { [weak self] error in
            let alert = UIAlertController(
                title: "Error",
                message: error,
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(title: "Retry", style: .default) { _ in
                    self?.viewModel.loadPokemon()
                }
            )
            self?.show(alert, sender: nil)
        }
        
        viewModel.loadPokemon()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(pokemonDetailView)
        pokemonDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonDetailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pokemonDetailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            pokemonDetailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            pokemonDetailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
