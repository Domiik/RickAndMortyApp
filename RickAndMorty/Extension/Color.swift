//
//  Color.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI

extension Color {
    
    enum Assets: String, RawRepresentable {
        case backgroundColor
        case textColor
        case cellColor
        case textColorGreen
        case textColorGray
        case textColorRed
    }
    
    init(asset: Color.Assets) {
        self.init(asset.rawValue)
    }
    
}


extension UIColor {
    convenience init(asset: Color.Assets) {
        self.init(named: asset.rawValue)!
    }
}
