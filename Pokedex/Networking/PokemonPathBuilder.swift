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
    
    func urlAllPokemons() -> String {
        "\(baseURL)/pokemon/?limit=100&offset=0"
    }
    
    func urlOnePokemon(forPokemon name: String) -> String {
        "\(baseURL)/pokemon/\(name)"
    }
    
}
