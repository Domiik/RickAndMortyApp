//
//  OriginModel.swift
//  RickAndMorty
//
//  Created by Domiik on 21.08.2023.
//

import Foundation

// MARK: - OriginModel
struct OriginModel: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
