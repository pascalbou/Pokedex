//
//  PokemonPathBuilder.swift
//  Pokedex
//
//  Created by krikaz on 6/11/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

protocol PokemonPathBuilderType {
    func urlAllPokemons(limit: Int, offset: Int) -> String
    func urlOnePokemon(for name: String) -> String
}

final class PokemonPathBuilder: PokemonPathBuilderType {
    private let baseURL = "https://pokeapi.co/api/v2"
    
    func urlAllPokemons(limit: Int, offset: Int) -> String {
        "\(baseURL)/pokemon/?limit=\(limit)&offset=\(offset)"
    }
    
    func urlOnePokemon(for name: String) -> String {
        "\(baseURL)/pokemon/\(name)"
    }
}
