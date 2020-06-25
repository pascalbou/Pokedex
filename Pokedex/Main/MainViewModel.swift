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
            self.pokemonsOutput?((self.pokemons?.map { $0.name })!)
        }
    }
    var nextPokemons: String?

    // Outputs
    var pokemonsOutput: (([String]) -> Void)?
    
    // Inputs
    func viewDidLoad() {
        // fetches the first 100 pokemons
        client.fetchAllPokemons(limit: 100, offset: 0) { (result) in
            switch result {
            case let .success(response):
//                self.pokemonsOutput?(response.results.map { $0.name })
                self.pokemons = response.results
                self.nextPokemons = response.next ?? nil
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchNextPokemons(count: Int) {
        if self.nextPokemons != nil {
            client.fetchAllPokemons(limit: 100, offset: count) { (result) in
                if let newPokemons = try? result.get() {
                    self.pokemons?.append(contentsOf: newPokemons.results)
                    self.nextPokemons = newPokemons.next
                }
            }
        }
    }
}
