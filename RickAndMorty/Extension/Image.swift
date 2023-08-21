//
//  Image.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI

extension Image {
    
    enum Assets: String, RawRepresentable {
        case placeholder
    }
    
    
    init(asset: Image.Assets) {
        self.init(asset.rawValue)
    }
    
   
}
