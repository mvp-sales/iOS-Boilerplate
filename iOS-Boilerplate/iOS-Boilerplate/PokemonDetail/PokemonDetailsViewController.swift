//
//  PokemonDetailViewController.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/05/25.
//

import Foundation
import Combine
import UIKit

class PokemonDetailsViewController: UIViewController {
    
    private let pokemonDetailsView: PokemonDetailsView
    private let viewModel: PokemonDetailsViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: PokemonDetailsViewModel) {
        self.pokemonDetailsView = PokemonDetailsView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewState in
                switch viewState {
                case .loading:
                    self?.pokemonDetailsView.isLoading = true
                case .loaded(let pokemonData):
                    self?.pokemonDetailsView.isLoading = false
                    self?.pokemonDetailsView.configure(with: pokemonData)
                case .failed(let error):
                    self?.pokemonDetailsView.isLoading = false
                    self?.showErrorAlert(errorDescription: error)
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        viewModel.loadPokemon()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(pokemonDetailsView)
        pokemonDetailsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonDetailsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pokemonDetailsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            pokemonDetailsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            pokemonDetailsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func showErrorAlert(errorDescription: String) {
        let alert = UIAlertController(
            title: "Error",
            message: errorDescription,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(title: "Retry", style: .default) { _ in
                self.viewModel.loadPokemon()
            }
        )
        self.show(alert, sender: nil)
    }
}
