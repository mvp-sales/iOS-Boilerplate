//
//  PokemonDetailViewModelTests.swift
//  iOS-BoilerplateTests
//
//  Created by Marcus Vinicius Palassi Sales on 17/05/25.
//

import Testing
@testable import iOS_Boilerplate

@Suite struct PokemonDetailViewModelTests {
    
    @Test func loadPokemon_success_test(){
        let pokemonName = "bulbasaur"
        let expected = PokemonDetailsResponse(
            id: 1,
            name: pokemonName,
            height: 6,
            baseExperience: 24,
            isDefault: true,
            order: 1,
            weight: 24,
            species: PokemonSpeciesDTO(name: pokemonName)
        )
        let sut = PokemonDetailsViewModel(pokemonName: pokemonName, apiClient: MockPokemonAPIClient(shouldReturnError: false))
        sut.onPokemonLoaded = { actualPokemon in
            #expect(actualPokemon == expected)
        }
        sut.loadPokemon()
    }
    
    @Test func loadPokemon_error_test(){
        let pokemonName = "bulbasaur"
        let expected = PokemonAPIError.generalError.localizedDescription
        let sut = PokemonDetailsViewModel(pokemonName: pokemonName, apiClient: MockPokemonAPIClient(shouldReturnError: true))
        sut.onError = { actualError in
            #expect(actualError == expected)
        }
        sut.loadPokemon()
    }
}

fileprivate class MockPokemonAPIClient: PokemonAPI {
    
    public let shouldReturnError: Bool
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func loadPokemons(offset: Int) async -> Result<iOS_Boilerplate.PokemonListResponse, iOS_Boilerplate.PokemonAPIError> {
        return Result.success(PokemonListResponse(results: []))
    }
    
    func getPokemonDetails(pokemonName: String) async -> Result<iOS_Boilerplate.PokemonDetailsResponse, iOS_Boilerplate.PokemonAPIError> {
        if shouldReturnError {
            return Result.failure(PokemonAPIError.generalError)
        } else {
            return Result.success(
                PokemonDetailsResponse(
                    id: 1,
                    name: pokemonName,
                    height: 6,
                    baseExperience: 24,
                    isDefault: true,
                    order: 1,
                    weight: 24,
                    species: PokemonSpeciesDTO(name: pokemonName)
                )
            )
        }
    }
}
