//
//  APError.swift
//  RickAndMorty
//
//  Created by Domiik on 20.08.2023.
//
import SwiftUI

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case internetConnection
}
