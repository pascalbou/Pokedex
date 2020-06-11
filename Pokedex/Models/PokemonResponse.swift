//
//  Pokemon.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

private struct RawServerResponse: Decodable {
    
    var moves: [SingleMove]
    var sprites: Sprite
    var types: [SingleType]
    var name: String

    struct SingleMove: Decodable {
        let move: MoveDetail
    }
    
    struct MoveDetail: Decodable {
        let name: String
        let url: String
    }
    
    struct Sprite: Decodable {
        let front_default: String
        let front_shiny: String
    }

    struct SingleType: Decodable {
        let slot: Int
        let type: TypeDetail
    }
    
    struct TypeDetail: Decodable {
        let name: String
        let url: String
    }
}

struct PokemonResponse: Decodable {
    var name: String
    var spriteURLString: String
    var types: [String] = []
    var attacks: [String] = []
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        
        name = rawResponse.name
        spriteURLString = rawResponse.sprites.front_default
        types.append(rawResponse.types[0].type.name)
        attacks.append(rawResponse.moves[0].move.name)
    }
}





