//
//  RetryInterceptor.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

/// This interceptor is a hint — actual retries are simpler to implement in NetworkClient.
/// But we provide it for demonstration and to show pluggable behavior.
final class RetryInterceptor: NetworkInterceptor {
    private let retryCount: Int

    init(retryCount: Int = 1) {
        self.retryCount = max(0, retryCount)
    }

    func intercept(request: URLRequest) async -> URLRequest {
        // no change to request, retries are handled in NetworkClient
        return request
    }

    func intercept(responseData: Data?, response: URLResponse?, error: Error?) async {
        // no-op: we keep retry logic centralized in the NetworkClient for clarity.
    }
}

