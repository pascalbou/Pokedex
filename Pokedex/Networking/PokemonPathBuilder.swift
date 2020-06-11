//
//  PokemonPathBuilder.swift
//  Pokedex
//
//  Created by krikaz on 6/11/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

final class PokemonPathBuilder {
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func urlAllPokemons(limit: Int, offset: Int) -> String {
        "\(baseURL)/pokemon/?limit=\(limit)&offset=\(offset)"
    }
    
    func urlOnePokemon(forPokemon name: String) -> String {
        "\(baseURL)/pokemon/\(name)"
    }
    
}
