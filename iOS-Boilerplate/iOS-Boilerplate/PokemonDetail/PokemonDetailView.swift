//
//  PokemonDetailView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/05/25.
//

import Foundation
import UIKit

class PokemonDetailView: UIView {
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let pokemonSpeciesNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let pokemonBaseExperienceLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let pokemonHeightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let pokemonOrderLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let pokemonWeightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let pokemonIsDefaultLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        stackView.spacing = 8.0
        
        stackView.addArrangedSubview(pokemonImageView)
        stackView.addArrangedSubview(pokemonNameLabel)
        stackView.addArrangedSubview(pokemonSpeciesNameLabel)
        stackView.addArrangedSubview(pokemonBaseExperienceLabel)
        stackView.addArrangedSubview(pokemonOrderLabel)
        stackView.addArrangedSubview(pokemonHeightLabel)
        stackView.addArrangedSubview(pokemonWeightLabel)
        stackView.addArrangedSubview(pokemonIsDefaultLabel)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20.0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20.0),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 256),
        ])
    }
    
    func configure(with pokemonData: PokemonDetailsResponse) {
        pokemonNameLabel.text = "Name: \(pokemonData.name)"
        pokemonSpeciesNameLabel.text = "Species: \(pokemonData.species.name)"
        pokemonBaseExperienceLabel.text = "Base Experience: \(pokemonData.baseExperience)"
        pokemonOrderLabel.text = "Order: \(pokemonData.order)"
        pokemonHeightLabel.text = "Height: \(pokemonData.height)"
        pokemonWeightLabel.text = "Weight: \(pokemonData.weight)"
        pokemonIsDefaultLabel.text = "Is default: \(pokemonData.isDefault)"
        
        Task {
            await pokemonImageView.loadImage(from: pokemonData.imageUrl)
        }
    }
}
