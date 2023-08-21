//
//  ErrorView.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI

struct ErrorView: View {
    
    @State var error: APError?
    var retryAction: () -> Void
    
    var body: some View {
        switch error {
        case .none:
            Text("Ошибка подключения")
                .bold()
                .foregroundColor(Color(asset: .textColor))
        case .some(.invalidURL):
            Text("Нет соединения с сервером")
                .bold()
                .foregroundColor(Color(asset: .textColor))
        case .some(.unableToComplete):
            VStack{
                Text("Нет интрернет соедениния")
                    .bold()
                    .foregroundColor(Color(asset: .textColor))
                Button(action: retryAction) {
                    Text("Попробовать еще раз")
                        .foregroundColor(Color(asset: .textColor))
                }
                .padding()
                .background(Color(asset: .textColorGreen))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))

            }
        case .some(.invalidResponse):
            Text("Нет соединения с сервером")
                .bold()
                .foregroundColor(Color(asset: .textColor))
        case .some(.invalidData):
            Text("Нет соединения с сервером")
                .bold()
                .foregroundColor(Color(asset: .textColor))
        case .some(.internetConnection):
            VStack{
                Text("Нет интрернет соедениния")
                    .foregroundColor(Color(asset: .textColor))
                    .bold()
                Button(action: retryAction) {
                    Text("Попробовать еще раз")
                        .foregroundColor(Color(asset: .textColor))
                }
                .padding()
                .background(Color(asset: .textColorGreen))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            }
        }
    }
}
