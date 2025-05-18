//
//  PokemonListView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import UIKit

protocol PokemonListViewDelegate: UITableViewDelegate, UITableViewDataSource {
}

class PokemonListView: UIView {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        return tableView
    }()
    
    private let loadingIndicatorView = {
        return UIActivityIndicatorView()
    }()
    
    var isLoading: Bool = false {
        didSet {
            loadingIndicatorView.isHidden = !isLoading
        }
    }
    
    weak var delegate: PokemonListViewDelegate? {
        didSet {
            tableView.delegate = delegate
            tableView.dataSource = delegate
            tableView.register(PokemonListItemCell.self, forCellReuseIdentifier: PokemonListItemCell.CellId)
            tableView.register(PokemonListActionCell.self, forCellReuseIdentifier: PokemonListActionCell.CellId)
        }
    }

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(tableView)
        self.addSubview(loadingIndicatorView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loadingIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}
