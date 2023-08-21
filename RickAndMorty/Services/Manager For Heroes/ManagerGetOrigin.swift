//
//  ManagerGetOrigin.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI

class ManagerGetOrigin {
    
    @ObservedObject var connectivity    = Connectivity()
    
    func getOrigin(originURL: String, completed: @escaping (Swift.Result <OriginModel, APError>) -> Void) {
        if connectivity.isConnected {
            guard let url = URL(string: originURL) else {
                completed(.failure(.invalidURL))
                return
            }
            // Create the url request
            let request = URLRequest(url: url)
         
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let _ =  error {
                    completed(.failure(.unableToComplete))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completed(.failure(.invalidData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(OriginModel.self, from: data)
                    completed(.success(decodedResponse))
                } catch {
                    completed(.failure(.invalidData))
                }
            }
            
            task.resume()
        } else {
            completed(.failure(.internetConnection))
            
        }
    }
    
    
    func getEpisode(episodeURL: String, completed: @escaping (Swift.Result <Episode, APError>) -> Void) {
        if connectivity.isConnected {
            guard let url = URL(string: episodeURL) else {
                completed(.failure(.invalidURL))
                return
            }
            // Create the url request
            let request = URLRequest(url: url)
         
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                if let _ =  error {
                    completed(.failure(.unableToComplete))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completed(.failure(.invalidData))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedResponse = try decoder.decode(Episode.self, from: data)
                    completed(.success(decodedResponse))
                } catch {
                    completed(.failure(.invalidData))
                }
            }
            
            task.resume()
        } else {
            completed(.failure(.internetConnection))
            
        }
    }
    
}
