//
//  PokemoinListViewController.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import Combine
import UIKit

class PokemonListViewController: UIViewController {
    
    private let pokemonListView: PokemonListView
    private let viewModel: PokemonListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: PokemonListViewModel) {
        self.pokemonListView = PokemonListView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        pokemonListView.delegate = self
        
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewState in
                switch viewState {
                case .loading:
                    self?.pokemonListView.isLoading = true
                case .newItemsLoaded:
                    self?.pokemonListView.isLoading = false
                    self?.pokemonListView.reloadData()
                case .failed(let error):
                    self?.pokemonListView.isLoading = false
                    self?.showErrorAlert(errorDescription: error)
                default:
                    break
                }
            }
            .store(in: &cancellables)
        
        viewModel.loadPokemons()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(pokemonListView)
        pokemonListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pokemonListView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pokemonListView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            pokemonListView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            pokemonListView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
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
                self.viewModel.loadPokemons()
            }
        )
        self.show(alert, sender: nil)
    }
}

extension PokemonListViewController: PokemonListViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == viewModel.itemsCount) {
            return tableView.dequeueReusableCell(withIdentifier: PokemonListActionCell.CellId, for: indexPath) as? PokemonListActionCell ?? UITableViewCell()
        }

        guard indexPath.row < viewModel.itemsCount,
            let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListItemCell.CellId, for: indexPath) as? PokemonListItemCell else {
            return UITableViewCell()
        }
        
        cell.configure(data: viewModel.items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == viewModel.itemsCount) {
            viewModel.loadPokemons()
            return
        }
        guard indexPath.row < viewModel.itemsCount else { return }
        
        let pokemon = viewModel.items[indexPath.row]
        viewModel.moveToDetail(pokemonName: pokemon.name)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
