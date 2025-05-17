//
//  PokemonListViewModelTests.swift
//  iOS-BoilerplateTests
//
//  Created by Marcus Vinicius Palassi Sales on 17/05/25.
//

import Testing
@testable import iOS_Boilerplate

@Suite struct PokemonListViewModelTests {
    private let mockApi: PokemonAPI = MockPokemonAPIClient()
    private let mockCoordinator: PokemonListCoordinator = MockCoordinator()
    
    @Test func loadPokemons_success_test(){
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
        let sut = PokemonListViewModel(coordinator: mockCoordinator, apiClient: MockPokemonAPIClient(shouldReturnError: false))
        sut.onItemsLoaded = {
            #expect(sut.items == expected)
        }
        sut.loadPokemons()
    }
    
    @Test func loadPokemons_error_test(){
        let expected = PokemonAPIError.generalError.localizedDescription
        let sut = PokemonListViewModel(coordinator: mockCoordinator, apiClient: MockPokemonAPIClient(shouldReturnError: true))
        sut.onError = { actualError in
            #expect(actualError == expected)
        }
        sut.loadPokemons()
    }
}

fileprivate class MockCoordinator: PokemonListCoordinator {
    func moveToPokemonDetails(pokemonName: String) { }
    
    func start() { }
}

fileprivate class MockPokemonAPIClient: PokemonAPI {
    
    public let shouldReturnError: Bool
    
    init(shouldReturnError: Bool = false) {
        self.shouldReturnError = shouldReturnError
    }
    
    func loadPokemons(offset: Int) async -> Result<iOS_Boilerplate.PokemonListResponse, iOS_Boilerplate.PokemonAPIError> {
        if shouldReturnError {
            return Result.failure(PokemonAPIError.generalError)
        } else {
            return Result.success(
                PokemonListResponse(
                    results: [
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
                )
            )
        }
    }
    
    func getPokemonDetails(pokemonName: String) async -> Result<iOS_Boilerplate.PokemonDetailsResponse, iOS_Boilerplate.PokemonAPIError> {
        return Result.failure(PokemonAPIError.generalError)
    }
}
