//
//  DetailViewController.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    var pokemon: String?
    private let viewModel = DetailViewModel()

    var pokemonSprite: UIImage? {
        didSet {
            DispatchQueue.main.async {
                self.pokemonImageView.image = self.pokemonSprite
                self.pokemonNameLabel.text = self.viewModel.name
                self.pokemonTypeLabel.text = self.viewModel.types
                self.pokemonAttacksLabel.text = self.viewModel.attacks
            }
        }
    }

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var pokemonAttacksLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad(pokemon: pokemon)

    }
    
    func bind() {
        viewModel.pokemonSprite = { [weak self] pokemon in
            self?.pokemonSprite = pokemon
        }
    }

}
