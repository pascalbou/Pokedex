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
    
    func urlAllPokemons(limit: Int, offset: Int) -> URL {
        var allPokemonsURL = baseURL
        allPokemonsURL.appendPathComponent("pokemon")
        let allPokemonsURLComp = NSURLComponents(url: allPokemonsURL, resolvingAgainstBaseURL: true)!
        allPokemonsURLComp.queryItems = [URLQueryItem(name: "limit", value: String(limit)), URLQueryItem(name: "offset", value: String(offset))]
        return allPokemonsURLComp.url!
    }
    
    func urlOnePokemon(forPokemon pokemonName: String) -> URL {
        var pokemonURL = baseURL
        pokemonURL.appendPathComponent("pokemon")
        pokemonURL.appendPathComponent(pokemonName)
        return pokemonURL
    }
    
    func urlPokemonSprite(withSprite sprite: String) -> URL? {
        guard let spriteURL = URL(string: sprite) else { return nil }
        return spriteURL
    }
}
