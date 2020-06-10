//
//  Pokemon.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

struct Pokemon: Codable {
    let name: String
    let url: String
}

struct AllPokemons: Codable {
    var results: [Pokemon]
    var next: String?
    var previous: String?
}

struct Move: Codable {
    let name: String
    let url: String
}

struct Sprite: Codable {
    let front_default: String
    let front_shiny: String
//    let url: String
}

struct Type: Codable {
    let name: String
    let url: String
}

struct SingleType: Codable {
    let slot: Int
    let type: Type
}

struct SingleMove: Codable {
    let move: Move
}

struct PokemonSingle: Codable {
    var moves: [SingleMove]
    var sprites: Sprite
    var types: [SingleType]
}

