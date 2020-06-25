//
//  DetailViewController.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    private let client = PokemonClient()
    var pokemon: String?
    var pokemonResponse: PokemonDetail? {
        didSet {
            DispatchQueue.main.async {
                guard let sprite = self.pokemonResponse?.spriteURL else { return }
                self.client.fetchPokemonSprite(with: sprite) { (result) in
                    if let data = try? result.get() {
                        self.pokemonSprite = UIImage(data: data)
                    }
                }
            }
        }
    }
    var pokemonSprite: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.pokemonImageView.image = self.pokemonSprite
                self.pokemonNameLabel.text = self.pokemon
                self.pokemonTypeLabel.text = self.pokemonResponse?.types.joined(separator: ", ").capitalized
                self.pokemonAttacksLabel.text = self.pokemonResponse?.attacks.joined(separator: ", ").capitalized
            }
        }
    }

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAttacksLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pokemon = self.pokemon else { return }
        client.fetchOnePokemon(for: pokemon) { (result) in
            if let pokemonDetail = try? result.get() {
                self.pokemonResponse = pokemonDetail
            }
        }
    }

}
