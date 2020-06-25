//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by krikaz on 6/25/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

final class DetailViewModel {
    let client = PokemonClient()
    
    var name: String?
    var types: String?
    var attacks: String?
    var pokemonSprite: ((UIImage) -> Void)?
    var spriteURL: String? {
        didSet {
            DispatchQueue.main.async {
                guard let spriteURL = self.spriteURL else { return }
                self.client.fetchPokemonSprite(with: spriteURL) { (result) in
                    if let data = try? result.get() {
                        self.pokemonSprite?(UIImage(data: data)!)
                    }
                }
            }
        }
    }
    
    
    func viewDidLoad(pokemon: String?) {
        guard let pokemon = pokemon else { return }
        client.fetchOnePokemon(for: pokemon) { (result) in
            if let pokemonDetail = try? result.get() {
                self.spriteURL = pokemonDetail.spriteURL
                self.name = pokemonDetail.name.capitalized
                self.types = pokemonDetail.types.joined(separator: ", ").capitalized
                self.attacks = pokemonDetail.attacks.joined(separator: ", ").capitalized
            }
        }
    }
    
}