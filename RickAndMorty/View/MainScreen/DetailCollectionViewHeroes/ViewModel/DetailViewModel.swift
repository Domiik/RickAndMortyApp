//
//  DetailViewModel.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import Foundation

final class DetailViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case end
        case error
    }
    
    @Published var alertItem: APError?
    @Published private(set) var state = State.idle
    @Published var resultHero: Result?
    @Published var origin: OriginModel?

    private let manager = ManagerGetOrigin()
    
    
    func loadDataFromCenterModel(item: Result) {
        self.state = .loading
        resultHero = item
        self.state = .end
    }
    
    func getOrigin(originURL: String) {
        self.state = .loading
        if originURL == "" {
            self.state = .end
        } else {
            manager.getOrigin(originURL: originURL) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let origin):
                        guard let self = self else { return }
                        self.origin = origin
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
     
    }
}

