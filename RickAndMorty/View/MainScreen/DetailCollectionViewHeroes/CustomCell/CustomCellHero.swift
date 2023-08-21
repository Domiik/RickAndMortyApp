//
//  CustomCellHero.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI

struct CustomCellHero: View {
    
    @State var nameEpisode: String
    @StateObject private var viewModel = EpisodeViewModel()
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear {
                viewModel.getEpisode(episodeURL: nameEpisode)
            }
        case .loading:
            LoadingView()
        case .end:
            VStack(alignment: .leading) {
                Text(viewModel.episode?.name ?? "nil")
                    .foregroundColor(Color(asset: .textColor))
                    .font(AppFont.custom.font)
                    .padding(.vertical, 3.0)
                HStack {
                    Text(viewModel.episode?.episode ?? "nil")
                        .foregroundColor(Color(asset: .textColorGreen))
                        .font(AppFont.customSmall.font)
                    Spacer()
                    Text(viewModel.episode?.airDate ?? "nil")
                        .foregroundColor(Color(asset: .textColorGray))
                        .font(AppFont.customSmall.font)
                }
            }
            .padding()
            .background(Rectangle().fill(Color(asset: .cellColor)).frame(maxWidth: .infinity, maxHeight: 86) .cornerRadius(15))
            .padding()
        case .error:
            ErrorView(error: viewModel.alertItem) {
                viewModel.getEpisode(episodeURL: nameEpisode)
            }
        }
    }
}

