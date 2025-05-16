//
//  PokemonListActionCell.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 16/05/25.
//

import Foundation
import UIKit

class PokemonListActionCell: UITableViewCell {
 
    static let CellId = "PokemonListActionCell"
    
    private let loadMoreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(loadMoreButton)
        loadMoreButton.translatesAutoresizingMaskIntoConstraints = false
        loadMoreButton.setTitle("Load More", for: .normal)
        
        NSLayoutConstraint.activate([
            loadMoreButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            loadMoreButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            loadMoreButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
            loadMoreButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
    }
}
