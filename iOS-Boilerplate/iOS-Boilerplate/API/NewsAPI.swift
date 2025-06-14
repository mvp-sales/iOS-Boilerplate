//
//  NewsAPI.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 08/06/25.
//

import Foundation

class NewsAPI {
    private let baseURL = URL(string: "https://newsapi.org/")!
    
    func getNews(request: GetNewsRequest) async -> Result<GetNewsApiResponse, GenericErrorApiResponse> {
        let url = baseURL.appendingPathComponent("/v2/\(request.searchType.endpoint)")
            .appending(
                queryItems: [
                    URLQueryItem(name: "q", value: request.query),
                    URLQueryItem(name: "page", value: "\(request.page)"),
                    URLQueryItem(name: "pageSize", value: "\(request.pageSize)"),
                    URLQueryItem(name: "sources", value: "\(request.sources.joined(separator: ","))")
                ]
            )
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            return Result.failure(GenericErrorApiResponse.genericError)
        }

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            let apiError = try? JSONDecoder().decode(GenericErrorApiResponse.self, from: data)
            return Result.failure(apiError ?? GenericErrorApiResponse.genericError)
        }

        guard let newsData = try? JSONDecoder().decode(GetNewsApiResponse.self, from: data) else {
            return Result.failure(GenericErrorApiResponse.genericError)
        }
        
        return Result.success(newsData)
    }
    
    func getHeadlinesSources(request: GetHeadlinesSourcesRequest) async -> Result<GetHeadlinesSourcesNewsApiResponse, GenericErrorApiResponse> {
        let url = baseURL.appendingPathComponent("/v2/top-headlines/sources")
            .appending(
                queryItems: [
                    URLQueryItem(name: "category", value: request.category)
                ]
            )
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            return Result.failure(GenericErrorApiResponse.genericError)
        }

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            let apiError = try? JSONDecoder().decode(GenericErrorApiResponse.self, from: data)
            return Result.failure(apiError ?? GenericErrorApiResponse.genericError)
        }

        guard let sourcesData = try? JSONDecoder().decode(GetHeadlinesSourcesNewsApiResponse.self, from: data) else {
            return Result.failure(GenericErrorApiResponse.genericError)
        }
        
        return Result.success(sourcesData)
    }
}
