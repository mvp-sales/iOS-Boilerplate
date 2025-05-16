//
//  PokemonListItemCell.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 13/05/25.
//

import Foundation
import UIKit

class PokemonListItemCell: UITableViewCell {
    
    static let CellId = "PokemonCell"
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(pokemonImageView)
        self.addSubview(pokemonNameLabel)
        pokemonImageView.translatesAutoresizingMaskIntoConstraints = false
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            pokemonImageView.topAnchor.constraint(equalTo: self.topAnchor),
            pokemonImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25),
            pokemonImageView.heightAnchor.constraint(equalTo: self.pokemonImageView.widthAnchor),
            pokemonImageView.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 8.0),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16.0),
            pokemonNameLabel.centerYAnchor.constraint(equalTo: pokemonImageView.centerYAnchor)
        ])
    }
    
    func configure(data: PokemonData) {
        pokemonNameLabel.text = data.name
        Task {
            await pokemonImageView.loadImage(from: data.imageUrl)
        }
    }
}
