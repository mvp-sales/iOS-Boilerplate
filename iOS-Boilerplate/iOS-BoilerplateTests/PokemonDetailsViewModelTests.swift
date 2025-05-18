//
//  PokemonDetailViewModelTests.swift
//  iOS-BoilerplateTests
//
//  Created by Marcus Vinicius Palassi Sales on 17/05/25.
//

import Testing
@testable import iOS_Boilerplate

@Suite struct PokemonDetailsViewModelTests {
    
    @Test func loadPokemon_success_test() async {
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
        let sut = PokemonDetailsViewModel(
            pokemonName: pokemonName,
            apiClient: MockPokemonAPIClient(result: .success(expected))
        )
        sut.loadPokemon()
        
        for await state in sut.$viewState.values {
            if case .loaded(let actualPokemon) = state {
                #expect(actualPokemon == expected)
                break
            }
        }
    }
    
    @Test func loadPokemon_error_test() async {
        let pokemonName = "bulbasaur"
        let expected = PokemonAPIError.generalError.localizedDescription
        let sut = PokemonDetailsViewModel(
            pokemonName: pokemonName,
            apiClient: MockPokemonAPIClient(result: .failure(.generalError))
        )
        sut.loadPokemon()
        
        for await state in sut.$viewState.values {
            if case .failed(let actualError) = state {
                #expect(actualError == expected)
                break
            }
        }
    }
}

fileprivate class MockPokemonAPIClient: PokemonAPI {
    
    private let result: Result<PokemonDetailsResponse, PokemonAPIError>
    
    init(result: Result<PokemonDetailsResponse, PokemonAPIError>) {
        self.result = result
    }
    
    func loadPokemons(offset: Int) async -> Result<iOS_Boilerplate.PokemonListResponse, iOS_Boilerplate.PokemonAPIError> {
        fatalError("shouldn't call this method here")
    }
    
    func getPokemonDetails(pokemonName: String) async -> Result<iOS_Boilerplate.PokemonDetailsResponse, iOS_Boilerplate.PokemonAPIError> {
        return result
    }
}
