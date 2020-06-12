//
//  Pokemon.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

private struct PokemonDetailResponse: Decodable {
    
    let name: String
    let sprites: Sprite
    let types: [PokemonType]
    let moves: [Move]
    
    struct Sprite: Decodable {
        let frontDefault: String
    }
    
    struct PokemonType: Decodable {
        let type: TypeDetail
        
        struct TypeDetail: Decodable {
            let name: String
            let url: String
        }
    }
    
    struct Move: Decodable {
        let move: MoveDetail
        
        struct MoveDetail: Decodable {
            let name: String
            let url: String
        }
    }
}

struct PokemonDetail: Decodable {
    let name: String
    let spriteURL: String
    var types: [String]
    var attacks: [String]
    
    init(from decoder: Decoder) throws {
        let response = try PokemonDetailResponse(from: decoder)
        
        self.name = response.name
        self.spriteURL = response.sprites.frontDefault
        self.types = response.types.map { $0.type.name }
        self.attacks = response.moves.map { $0.move.name }
    }
}





