//
//  NetworkInterceptor.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

/// Interceptor protocol to allow request/response hooks.
/// This mimics middleware style interceptors (request/response)
protocol NetworkInterceptor {
    /// Modify/observe request before sending. Return possibly modified request.
    func intercept(request: URLRequest) async -> URLRequest

    /// Observe response (data/response/error) after network call.
    func intercept(responseData: Data?, response: URLResponse?, error: Error?) async
}

extension NetworkInterceptor {
    // provide default no-op implementations
    func intercept(request: URLRequest) async -> URLRequest { request }
    func intercept(responseData: Data?, response: URLResponse?, error: Error?) async {}
}

