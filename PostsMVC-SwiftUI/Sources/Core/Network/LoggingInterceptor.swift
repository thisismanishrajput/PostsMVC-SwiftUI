//
//  LoggingInterceptor.swift
//  PostsMVC-SwiftUI
//
//  Created by Manish Singh on 18/11/25.
//

import Foundation

final class LoggingInterceptor: NetworkInterceptor {
    func intercept(request: URLRequest) async -> URLRequest {
        print("➡️ Request: \(request.httpMethod ?? "GET") \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = request.httpBody, let str = String(data: body, encoding: .utf8) {
            print("Body: \(str)")
        }
        return request
    }

    func intercept(responseData: Data?, response: URLResponse?, error: Error?) async {
        if let http = response as? HTTPURLResponse {
            print("⬅️ Response: \(http.statusCode) \(http.url?.absoluteString ?? "")")
        }
        if let error = error {
            print("❗️ Error: \(error.localizedDescription)")
        } else if let data = responseData, let s = String(data: data, encoding: .utf8) {
            // trimming long logs
            let preview = s.count > 500 ? String(s.prefix(500)) + "…(truncated)" : s
            print("Body: \(preview)")
        }
    }
}


