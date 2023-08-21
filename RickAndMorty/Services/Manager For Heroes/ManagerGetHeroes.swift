//
//  ManagerGetHeroes.swift
//  RickAndMorty
//
//  Created by Domiik on 20.08.2023.
//

import SwiftUI
import UIKit

class ManagerGetHeroes {
    
    @ObservedObject var connectivity    = Connectivity()
    
    func getHeroes(page: Int, completed: @escaping (Swift.Result <Heroes, APError>) -> Void) {
        if connectivity.isConnected {
            let endURL = Constants.baseURL + String(page)
            guard let url = URL(string: endURL) else {
                completed(.failure(.invalidURL))
                return
            }
            // Create the url request
            var request = URLRequest(url: url)
         
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
                    let decodedResponse = try decoder.decode(Heroes.self, from: data)
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
    
    
    func loadNextPage(nextPage: String, completed: @escaping (Swift.Result <Heroes, APError>) -> Void) {
        if connectivity.isConnected {
            guard let url = URL(string: nextPage) else {
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
                    let decodedResponse = try decoder.decode(Heroes.self, from: data)
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
