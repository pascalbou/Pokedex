//
//  DetailViewController.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController {
    
    let viewModel = DetailViewModel(client: PokemonClient(pathBuilder: PokemonPathBuilder()))

    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypesLabel: UILabel!
    @IBOutlet weak var pokemonAttacksLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewDidLoad()

    }
    
    func bind() {
        viewModel.pokemonSprite = { [weak self] pokemonSprite in
            DispatchQueue.main.async {
                self?.pokemonImageView.image = UIImage(data: pokemonSprite)
            }
        }
        viewModel.types = { [weak self] types in
            DispatchQueue.main.async {
                self?.pokemonTypesLabel.text = types
            }
        }
        viewModel.attacks = { [weak self] attacks in
            DispatchQueue.main.async {
                self?.pokemonAttacksLabel.text = attacks
            }
        }
        self.pokemonNameLabel.text = self.viewModel.pokemonName?.capitalized
    }

}
