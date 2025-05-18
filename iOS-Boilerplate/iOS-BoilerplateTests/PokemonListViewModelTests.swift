//
//  PokemonListViewModelTests.swift
//  iOS-BoilerplateTests
//
//  Created by Marcus Vinicius Palassi Sales on 17/05/25.
//

import Testing
@testable import iOS_Boilerplate

@Suite struct PokemonListViewModelTests {
    private let mockCoordinator: PokemonListCoordinator = MockCoordinator()
    
    @Test func loadPokemons_success_test() async {
        let expected: [PokemonData] = [
            PokemonData(
                name: "bulbasaur",
                url: ""
            ),
            PokemonData(
                name: "ivysaur",
                url: ""
            ),
            PokemonData(
                name: "venusaur",
                url: ""
            )
        ]
        let sut = PokemonListViewModel(
            coordinator: mockCoordinator,
            apiClient: MockPokemonAPIClient(result: .success(PokemonListResponse(results: expected)))
        )

        sut.loadPokemons()
        
        for await state in sut.$viewState.values {
            if case .newItemsLoaded = state {
                #expect(sut.items == expected)
                break
            }
        }
    }
    
    @Test func loadPokemons_error_test() async {
        let expected = PokemonAPIError.generalError.localizedDescription
        let sut = PokemonListViewModel(
            coordinator: mockCoordinator,
            apiClient: MockPokemonAPIClient(result: .failure(.generalError))
        )

        sut.loadPokemons()
        
        for await state in sut.$viewState.values {
            if case .failed(let actualError) = state {
                #expect(actualError == expected)
                break
            }
        }
    }
}

fileprivate class MockCoordinator: PokemonListCoordinator {
    func moveToPokemonDetails(pokemonName: String) { }
    
    func start() { }
}

fileprivate class MockPokemonAPIClient: PokemonAPI {
    private let result: Result<PokemonListResponse, PokemonAPIError>
    
    init(result: Result<PokemonListResponse, PokemonAPIError>) {
        self.result = result
    }
    
    func loadPokemons(offset: Int) async -> Result<iOS_Boilerplate.PokemonListResponse, iOS_Boilerplate.PokemonAPIError> {
        return result
    }
    
    func getPokemonDetails(pokemonName: String) async -> Result<iOS_Boilerplate.PokemonDetailsResponse, iOS_Boilerplate.PokemonAPIError> {
        fatalError("shouldn't call this method here")
    }
}
