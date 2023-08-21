//
//  DetailHeroView.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI
import Kingfisher

struct DetailHeroView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = DetailViewModel()
    @Binding var items: Result?
    
    
    
    var body: some View {
        switch viewModel.state {
        case .idle:
            Color.clear.onAppear {
                guard let item = items else {
                    return
                }
                viewModel.getOrigin(originURL: item.origin.url)
            }
        case .loading:
            LoadingView()
        case .end:
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack {
                        VStack(alignment: .center) {
                            KFImage(URL(string: items?.image ?? ""))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 148, height: 148)
                                .cornerRadius(16)
                                .padding()
                            Text(items?.name ?? "nil")
                                .font(AppFont.customLarge.font)
                                .foregroundColor(Color(asset: .textColor))
                                .padding()
                            Text(items?.status.rawValue ?? "nil")
                                .foregroundColor(items?.status == .alive ? Color(asset: .textColorGreen) : Color(asset: .textColorRed))
                        }
                        HStack {
                            Text("Info")
                                .font(AppFont.custom.font)
                                .foregroundColor(Color(asset: .textColor))
                                .padding(.leading)
                            Spacer()
                        }
                        CustomCellHeroType(species: items?.species ?? "nil", type: items?.type ?? "nil", gender: items?.gender.rawValue ?? "nil")
                        HStack {
                            Text("Origin")
                                .font(AppFont.custom.font)
                                .foregroundColor(Color(asset: .textColor))
                                .padding(.leading)
                            Spacer()
                        }
                        CustomCellOrigin(namePlanet: items?.origin.name ?? "nil", planet: viewModel.origin?.type ?? " ")
                        HStack {
                            Text("Episodes")
                                .font(AppFont.custom.font)
                                .foregroundColor(Color(asset: .textColor))
                                .padding(.leading)
                            Spacer()
                        }
                        ForEach(items!.episode, id: \.self) { episode in
                            CustomCellHero(nameEpisode: episode)
                              
                        }
                        
                        
                    }
                }
                .background(Color(asset: .backgroundColor))
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                                .foregroundColor(Color(asset: .textColor))
                            
                        }
                    }
                }
            }
        case .error:
            ErrorView(error: viewModel.alertItem) {
                guard let item = items else {
                    return
                }
                viewModel.getOrigin(originURL: item.origin.url)
            }
        }
    }
}

//struct DetailHeroView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailHeroView()
//    }
//}
