//
//  NetworkClient.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

/// A small composable network client with interceptor support.
/// Uses async/await URLSession and supports interceptors for request/response.
/// SOLID: depends on protocols (NetworkClientProtocol) so services can be mocked.

protocol NetworkClientProtocol {
    func request(endpoint: String,
                 method: String,
                 queryItems: [URLQueryItem]?,
                 headers: [String: String]?,
                 body: Data?) async throws -> (Data, URLResponse)
}

final class NetworkClient: NetworkClientProtocol {
    private let baseURL: URL
    private let session: URLSession
    private var interceptors: [NetworkInterceptor] = []
    private let maxRetryCount: Int

    init(baseURL: URL, session: URLSession = .shared, maxRetryCount: Int = 2) {
        self.baseURL = baseURL
        self.session = session
        self.maxRetryCount = maxRetryCount
    }

    func addInterceptor(_ interceptor: NetworkInterceptor) {
        interceptors.append(interceptor)
    }

    func request(endpoint: String,
                 method: String = "GET",
                 queryItems: [URLQueryItem]? = nil,
                 headers: [String: String]? = nil,
                 body: Data? = nil) async throws -> (Data, URLResponse) {

        guard var components = URLComponents(url: baseURL.appendingPathComponent(endpoint), resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        if let items = queryItems { components.queryItems = items }

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body
        headers?.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        // run request interceptors (in order)
        for interceptor in interceptors {
            urlRequest = await interceptor.intercept(request: urlRequest)
        }

        var attempt = 0
        var lastError: Error?

        while attempt <= maxRetryCount {
            do {
                let (data, response) = try await session.data(for: urlRequest)
                // call response interceptors
                for interceptor in interceptors {
                    await interceptor.intercept(responseData: data, response: response, error: nil)
                }
                return (data, response)
            } catch {
                lastError = error
                for interceptor in interceptors {
                    await interceptor.intercept(responseData: nil, response: nil, error: error)
                }
                attempt += 1
                // simple exponential backoff
                if attempt <= maxRetryCount {
                    let waitMs = UInt64(100 * pow(2.0, Double(attempt)))
                    try? await Task.sleep(nanoseconds: waitMs * 1_000_000)
                    continue
                } else {
                    break
                }
            }
        }
        throw lastError ?? URLError(.unknown)
    }
}

