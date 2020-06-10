//
//  DetailViewController.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemon: Pokemon?
    var pokemonResponse: PokemonResponse? {
        didSet {
            DispatchQueue.main.async {
                self.getPokemonSprite()
            }
        }
    }
    var pokemonSprite: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.pokemonImageView.image = self.pokemonSprite
                self.pokemonNameLabel.text = self.pokemon?.name.capitalized
//                self.pokemonTypeLabel.text = self.pokemonResponse?.types[0].type.name
//                self.pokemonAttacksLabel.text = self.pokemonResponse?.moves[0].move.name
            }
        }
    }

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAttacksLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getOnePokemon()
//        print(self.pokemonResponse)
//        print(self.pokemonResponse)
    }

    private func getOnePokemon() {
        var pokemonURL = baseURL
        pokemonURL.appendPathComponent("pokemon")
        if let name = pokemon?.name {
            pokemonURL.appendPathComponent(name)
        }
        var request = URLRequest(url: pokemonURL)
        request.httpMethod = HTTPMethod.get.rawValue

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }

            guard let data = data else { return }
            do {
                self.pokemonResponse = try JSONDecoder().decode(PokemonResponse.self, from: data)
//                print(self.pokemonResponse?.sprites.front_default)
            } catch {
                NSLog("Error: \(error)")
            }
        }
        task.resume()
    }


    private func getPokemonSprite() {
        guard let sprite = self.pokemonResponse?.spriteURLString, let spriteURL = URL(string: sprite) else { return }
        print(sprite)
        print(spriteURL)
        var request = URLRequest(url: spriteURL)
        request.httpMethod = HTTPMethod.get.rawValue

        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }

            guard let data = data else { return }
            self.pokemonSprite = UIImage(data: data)
        }
        task.resume()
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
