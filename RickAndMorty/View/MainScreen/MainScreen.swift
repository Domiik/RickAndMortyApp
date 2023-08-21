//
//  MainScreen.swift
//  RickAndMorty
//
//  Created by Domiik on 20.08.2023.
//

import SwiftUI

struct MainScreen: View {
    
    @StateObject private var viewModel = MainScreenViewModel()
    @State private var items: [Result]? = nil
    @State private var selectedItem: Result? = nil
    @State private var isDetailViewPresented = false
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear {
                viewModel.getHeroes()
            }
        case .loading:
            LoadingView()
        case .end:
            NavigationView {
                CollectionView(items: $items, viewModel: viewModel, selectedItem: $selectedItem, isDetailViewPresentedB: $isDetailViewPresented)
                    .navigationTitle("Characters")
                    .background(Color(asset: .backgroundColor))
                    .onAppear {
                        items = viewModel.resultHero
                    }
                    .fullScreenCover(isPresented: $isDetailViewPresented, content: {
                        DetailHeroView(items: $selectedItem)
                    })
            }
        case .error:
            ErrorView(error: viewModel.alertItem) {
                viewModel.getHeroes()
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
