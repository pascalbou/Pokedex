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
    var pokemon: Pokemon?
    var pokemonResponse: PokemonDetail? {
        didSet {
            DispatchQueue.main.async {
                guard let sprite = self.pokemonResponse?.spriteURLString else { return }
                self.client.fetchPokemonSprite(withSprite: sprite) { (data, error) in
                    if let error = error {
                        NSLog("Error: \(error)")
                        return
                    }
                    guard let data = data else { return }
                    self.pokemonSprite = UIImage(data: data)
                }
            }
        }
    }
    var pokemonSprite: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.pokemonImageView.image = self.pokemonSprite
                self.pokemonNameLabel.text = self.pokemon?.name.capitalized
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
        guard let name = self.pokemon?.name else { return }
        client.fetchOnePokemon(named: name) { (pokemonResponse, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            self.pokemonResponse = pokemonResponse
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
