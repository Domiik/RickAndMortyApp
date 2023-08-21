//
//  EpisodeViewModel.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import Foundation


final class EpisodeViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case end
        case error
    }
    
    @Published var alertItem: APError?
    @Published private(set) var state = State.idle
    @Published var episode: Episode?

    private let manager = ManagerGetOrigin()
    
    
    func getEpisode(episodeURL: String) {
        self.state = .loading
        manager.getEpisode(episodeURL: episodeURL) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let episode):
                    guard let self = self else { return }
                    self.episode = episode
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
