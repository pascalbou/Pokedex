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
    private var pokemons: [Pokemon]? {
        didSet {
            self.pokemonNames?((self.pokemons?.map { $0.name })!)
        }
    }
    var nextPokemonsURLString: String?

    // Outputs
    var pokemonNames: (([String]) -> Void)?
    
    // Inputs
    func viewDidLoad() {
        // fetches the first 100 pokemons
        client.fetchAllPokemons(limit: 100, offset: 0) { (result) in
            switch result {
            case let .success(response):
                self.pokemons = response.results
                self.nextPokemonsURLString = response.next
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNextPokemons(count: Int) {
        guard let _ = self.nextPokemonsURLString else { return }
        client.fetchAllPokemons(limit: 100, offset: count) { (result) in
            if let newPokemons = try? result.get() {
                self.pokemons?.append(contentsOf: newPokemons.results)
                self.nextPokemonsURLString = newPokemons.next
            }
        }

    }
}
