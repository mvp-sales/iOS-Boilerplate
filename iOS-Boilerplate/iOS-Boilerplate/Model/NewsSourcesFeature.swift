//
//  NewsSourcesFeature.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct NewsSourcesFeature {
    
    @ObservableState
    struct State: Equatable {
        var sources: [NewsSource] = []
        var error: GenericError?
    }
    
    enum Action {
        case loadSourcesFromServer(String)
        case loadedSources([NewsSource])
        case failedLoadingSources(GenericError)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadSourcesFromServer(let category):
                return .run { send in
                    let newsApi = NewsAPI()
                    let result = await newsApi.getHeadlinesSources(request: GetHeadlinesSourcesRequest(category: category))
                    switch result {
                    case .success(let response):
                        await send(.loadedSources(response.sources.map { $0.toEntity() }))
                    case .failure(let error):
                        await send(.failedLoadingSources(GenericError(message: error.message)))
                    }
                }
            case .loadedSources(let sources):
                state.sources = sources
                state.error = nil
                return .none
            case .failedLoadingSources(let error):
                state.error = error
                return .none
            }
        }
    }
    
}
