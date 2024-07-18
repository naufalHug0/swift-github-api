//
//  API.swift
//  github-bio
//
//  Created by naufal on 18/07/24.
//

import Foundation

protocol APICall {
    var base_url: String { get }
    var headers: [String: String]? { get }
    func get(path: String) async throws -> GitHubUser
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

class API: APICall {
    var base_url: String = "https://api.github.com"

    var headers: [String : String]?
    
    func get(path: String) async throws -> GitHubUser {
        guard let url = URL(string:self.base_url+path) else { throw APIError.invalidURL }
        
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw APIError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(GitHubUser.self, from: data)
        } catch {
            throw APIError.invalidData
        }
        
    }
}
