//
//  AppFont.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import SwiftUI

public enum AppFont {
    case custom
    case customLarge
    case customSmall
}

public extension AppFont {
    var font: Font {
        switch self {
        case .custom:
            return .custom("Gilroy-Bold", size: 17)
        case .customLarge:
            return .custom("Gilroy-Bold", size: 22)
        case .customSmall:
            return .custom("Gilroy-Bold", size: 13)
        }
    }
}
