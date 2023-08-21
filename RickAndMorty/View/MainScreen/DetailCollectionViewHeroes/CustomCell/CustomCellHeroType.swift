//
//  CustomCellHeroType.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI

struct CustomCellHeroType: View {
    
    @State var species: String
    @State var type: String
    @State var gender: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Species:")
                    .foregroundColor(Color(asset: .textColorGray))
                    .font(AppFont.custom.font)
                    .padding(.vertical, 4.0)
                Spacer()
                Text(species)
                    .foregroundColor(Color(asset: .textColor))
                    .font(AppFont.custom.font)
                    .padding(.vertical, 4.0)
            }
            HStack {
                Text("Type:")
                    .foregroundColor(Color(asset: .textColorGray))
                    .font(AppFont.custom.font)
                    .padding(.bottom, 4.0)
                Spacer()
                Text(type)
                    .foregroundColor(Color(asset: .textColor))
                    .font(AppFont.custom.font)
                    .padding(.bottom, 4.0)
                    .onAppear {
                        if type == "" {
                            type = "Unknow"
                        } else {
                            type = type
                        }
                    }
            }
            HStack {
                Text("Gender:")
                    .foregroundColor(Color(asset: .textColorGray))
                    .font(AppFont.custom.font)
                    .padding(.bottom, 4.0)
                Spacer()
                Text(gender)
                    .foregroundColor(Color(asset: .textColor))
                    .font(AppFont.custom.font)
                    .padding(.bottom, 4.0)
            }
        }
        .padding()
        .background(Rectangle().fill(Color(asset: .cellColor)).frame(maxWidth: .infinity, maxHeight: 124) .cornerRadius(16))
        .padding()
    }
    
}

struct CustomCellHeroType_Previews: PreviewProvider {
    static var previews: some View {
        CustomCellHeroType(species: "Human", type: "None", gender: "Male")
    }
}
