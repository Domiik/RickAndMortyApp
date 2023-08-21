//
//  CustomCellOrigin.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI

struct CustomCellOrigin: View {

    @State var namePlanet: String
    @State var planet: String
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(named: "Planet.png")!)
                .resizable()
                .frame(width: 24, height: 24)
                .padding()
                .background(Rectangle().fill(Color(asset: .backgroundColor)).frame(maxWidth: 64, maxHeight: 64) .cornerRadius(15))
            VStack(alignment: .leading) {
                Text(namePlanet)
                    .font(AppFont.custom.font)
                    .foregroundColor(Color(asset: .textColor))
                    .padding(.bottom, 3.0)
                Text(planet)
                    .font(AppFont.custom.font)
                    .foregroundColor(Color(asset: .textColorGreen))
            }
            Spacer()
        }
        .padding()
        .background(Rectangle().fill(Color(asset: .cellColor)).frame(maxWidth: .infinity, maxHeight: 86) .cornerRadius(15))
        .padding()
    }
}

struct CustomCellOrifin_Previews: PreviewProvider {
    static var previews: some View {
        CustomCellOrigin(namePlanet: "Earth", planet: "Planet")
    }
}
