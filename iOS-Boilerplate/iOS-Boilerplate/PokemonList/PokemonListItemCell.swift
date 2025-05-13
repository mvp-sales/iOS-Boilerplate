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
            pokemonImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: self.topAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 96),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 96),
            pokemonImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
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
