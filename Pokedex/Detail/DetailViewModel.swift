//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by krikaz on 6/25/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

final class DetailViewModel {
    let client: PokemonClientType
    var pokemonName: String?
    
    // Outputs
    var types: ((String) -> Void)?
    var attacks: ((String) -> Void)?
    var pokemonSprite: ((Data) -> Void)?
    
    init(client: PokemonClientType) {
        self.client = client
    }
    
    func viewDidLoad() {
        guard let pokemonName = self.pokemonName else { return }
        client.fetchOnePokemon(for: pokemonName) { (result) in
            switch result {
            case let .success(pokemonDetail):
                self.fetchSprite(pokemonDetail.spriteURL)
                self.types?(pokemonDetail.types.joined(separator: ", ").capitalized)
                self.attacks?(pokemonDetail.attacks.joined(separator: ", ").capitalized)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchSprite(_ spriteURL: String) {
        client.fetchPokemonSprite(with: spriteURL) { (result) in
            switch result {
            case let .success(data):
                self.pokemonSprite?(data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
