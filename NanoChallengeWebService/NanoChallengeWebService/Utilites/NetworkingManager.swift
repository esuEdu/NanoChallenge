//
//  NetworkingManager.swift
//  NanoChallengeWebService
//
//  Created by Eduardo on 21/08/23.
//

import Foundation

class NetworkingManager {
    
    func downloadRequest(url: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: url)
            let apiData = try await handleError(data: data, response: response)
            return apiData
        }catch {
            throw URLError(.badURL)
        }
    }
    
    func download(url: URL) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            let apiData = try await handleError(data: data, response: response)
            return apiData
        }catch {
            throw URLError(.badURL)
        }
    }
    
    private func handleError(data: Data?, response: URLResponse?) async throws -> Data {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode) else {
            throw URLError(.badURL)
        }
        return data
    }

}
