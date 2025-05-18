//
//  PokemonDetailView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/05/25.
//

import Foundation
import UIKit

class PokemonDetailsView: UIView {
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let pokemonNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.accessibilityIdentifier = "pokemonDetailsNameLabel"
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
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let loadingIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView()
    }()
    
    var isLoading: Bool = false {
        didSet {
            loadingIndicatorView.isHidden = !isLoading
            stackView.isHidden = isLoading
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
        self.addSubview(scrollView)
        scrollView.addSubview(stackView)
        self.addSubview(loadingIndicatorView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.backgroundColor = .white
        stackView.spacing = 8.0
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20.0, bottom: 0, right: 20.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.addArrangedSubview(pokemonImageView)
        stackView.addArrangedSubview(pokemonNameLabel)
        stackView.addArrangedSubview(pokemonSpeciesNameLabel)
        stackView.addArrangedSubview(pokemonBaseExperienceLabel)
        stackView.addArrangedSubview(pokemonOrderLabel)
        stackView.addArrangedSubview(pokemonHeightLabel)
        stackView.addArrangedSubview(pokemonWeightLabel)
        stackView.addArrangedSubview(pokemonIsDefaultLabel)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            pokemonImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35),
            loadingIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loadingIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
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
