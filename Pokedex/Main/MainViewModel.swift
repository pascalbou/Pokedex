//
//  MainViewModel.swift
//  Pokedex
//
//  Created by krikaz on 6/25/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

final class MainViewModel {
    private let client = PokemonClient()
//    private var pokemons: [Pokemon] = []

    // Outputs
    var pokemonsOutput: ((AllPokemonsResponse) -> Void)?
//    var pokemonsOutput: (([Pokemons]) -> Void)?

    // Inputs
    func viewDidLoad() {
        // fetches the first 100 pokemons
        client.fetchAllPokemons(limit: 100, offset: 0) { (result) in
            switch result {
            case let .success(response):
//                self.pokemons.append(firstPokemons.results.map { $0.name })
//                self.pokemonsOutput?(self.pokemons)
                self.pokemonsOutput?(response)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
