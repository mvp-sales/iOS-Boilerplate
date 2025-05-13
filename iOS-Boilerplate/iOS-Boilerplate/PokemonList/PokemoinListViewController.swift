//
//  PokemoinListViewController.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import UIKit

class PokemonListViewController: UIViewController {
    
    private let pokemonListView: PokemonListView
    private let viewModel: PokemonListViewModel
    
    init(viewModel: PokemonListViewModel) {
        self.pokemonListView = PokemonListView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = pokemonListView
        pokemonListView.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onItemsLoaded = { [weak self] in
            self?.pokemonListView.reloadData()
        }
        
        viewModel.onError = { error in
            print(error)
        }
        
        Task {
            await viewModel.loadPokemons()
        }
    }
}

extension PokemonListViewController: PokemonListViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonListItemCell.CellId, for: indexPath) as? PokemonListItemCell else {
            return UITableViewCell()
        }
        
        cell.configure(data: viewModel.items[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
