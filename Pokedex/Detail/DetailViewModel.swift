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
    
    var pokemonName: String?
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
    
    // Outputs
    var types: ((String) -> Void)?
    var attacks: ((String) -> Void)?
    var pokemonSprite: ((UIImage) -> Void)?
    
    func viewDidLoad() {
        guard let pokemonName = self.pokemonName else { return }
        client.fetchOnePokemon(for: pokemonName) { (result) in
            if let pokemonDetail = try? result.get() {
                self.spriteURL = pokemonDetail.spriteURL
                self.types?(pokemonDetail.types.joined(separator: ", ").capitalized)
                self.attacks?(pokemonDetail.attacks.joined(separator: ", ").capitalized)
            }
        }
    }
    
}
