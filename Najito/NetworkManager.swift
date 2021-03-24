//
//  NetworkManager.swift
//  Najito
//
//  Created by Emilio Del Castillo on 24/03/2021.
//

import Foundation

enum NetWorkError: String, Error {
    case invalidIdentifier = "The identifier is invalid."
    case unableToComplete = "Unable to complete your request."
    case invalidResponse = "Invalid response from the server."
    case invalidData = "The received data is invalid."
}

enum SearchParameter {
    case ingredient
    case name
    case identifier
}

class NetworkManager {
    static let shared = NetworkManager()
    
    var components: URLComponents
    let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        components = URLComponents()
        components.scheme = "https"
        components.host = "www.thecocktaildb.com"
    }
    
    func searchBy(_ parameter: SearchParameter, _ token: String, completion: @escaping (Result<APIResults, NetWorkError>) -> Void){
        
        switch parameter {
        case .identifier:
            components.path = "/api/json/v1/1/lookup.php"
            components.queryItems = [URLQueryItem(name: "i", value: token)]
            
        case .ingredient:
            components.path = "/api/json/v1/1/filter.php"
            components.queryItems = [URLQueryItem(name: "i", value: token)]
            
        case .name:
            components.path = "/api/json/v1/1/search.php"
            components.queryItems = [URLQueryItem(name: "s", value: token)]
        }
        
        URLSession.shared.dataTask(with: components.url!) { data, response, error in
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let json = try self.decoder.decode(APIResults.self, from: data)
                completion(.success(json))
                
            } catch {
                completion(.failure(.invalidData))
            }
            
        }.resume()
        
    }
    
}
