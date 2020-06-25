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
    var pokemonsOutput: (([String]) -> Void)?

    // Inputs
    func viewDidLoad() {
        // fetches the first 100 pokemons
        client.fetchAllPokemons(limit: 100, offset: 0) { (result) in
            switch result {
            case let .success(response):
                self.pokemonsOutput?(response.results.map { $0.name })
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
