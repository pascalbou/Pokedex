//
//  DetailViewController.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    var pokemon: Pokemon?
    var pokemonSingle: PokemonSingle? {
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
//        print(self.pokemon)
//        print(self.pokemonSingle)
    }
    
    private func getOnePokemon() {
        var url = baseURL
        url.appendPathComponent("pokemon")
        if let name = pokemon?.name {
            url.appendPathComponent(name)
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
            guard let data = data else { return }
            do {
//                let dataJSON = try JSONDecoder().decode(PokemonSingleJSON.self, from: data)
//                print(dataJSON)
//                self.pokemonSingle?.sprite = dataJSON.sprites.front_default
                self.pokemonSingle = try JSONDecoder().decode(PokemonSingle.self, from: data)
//                print(self.pokemonSingle?.sprites.front_default)
                
//                print(self.pokemonSingle?.sprite)
            } catch {
                NSLog("Error: \(error)")
            }
        }
        task.resume()
    }
    
    
    private func getPokemonSprite() {
        guard let urlString = self.pokemonSingle?.sprites.front_default else { return }
        let url = URL(string: urlString)
        guard let url1 = url else { return }
        var request = URLRequest(url: url1)
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
