//
//  MainScreenViewModel.swift
//  RickAndMorty
//
//  Created by Domiik on 20.08.2023.
//

import Foundation

final class MainScreenViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case end
        case error
    }
    
    @Published var alertItem: APError?
    @Published private(set) var state = State.idle
    @Published var heroes: Heroes?
    @Published var resultHero: [Result] = []
    @Published var currentPage = 1
    @Published var countHeroes: Int?

    private let heroesManager = ManagerGetHeroes()
    
    func getHeroes() {
        self.state = .loading
        heroesManager.getHeroes(page: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let heroes):
                    guard let self = self else { return }
                    self.heroes = heroes
                    self.resultHero = heroes.results
                    self.state = .end
                case .failure(let error):
                    guard let self = self else { return }
                    self.state = .error
                    switch error {
                    case .invalidData:
                        self.alertItem = .invalidData
                    case .invalidURL:
                        self.alertItem = .invalidURL
                    case .invalidResponse:
                        self.alertItem = .invalidResponse
                    case .unableToComplete:
                        self.alertItem = .unableToComplete
                    case .internetConnection:
                        self.alertItem = .internetConnection
                    }
                }
            }
        }
    }
    
    
    func loadNextPage(nextPage: String, completion: @escaping (Bool) -> Void) {
        //self.state = .loading
        heroesManager.loadNextPage(nextPage: nextPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let heroes):
                    guard let self = self else { return }
                    self.heroes = heroes
                    self.resultHero.append(contentsOf: heroes.results)
                    self.state = .end
                    completion(true)
                case .failure(let error):
                    guard let self = self else { return }
                    //self.state = .error
                    switch error {
                    case .invalidData:
                        self.alertItem = .invalidData
                    case .invalidURL:
                        self.alertItem = .invalidURL
                    case .invalidResponse:
                        self.alertItem = .invalidResponse
                    case .unableToComplete:
                        self.alertItem = .unableToComplete
                    case .internetConnection:
                        self.alertItem = .internetConnection
                    }
                }
            }
        }
    }
}
