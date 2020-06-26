//
//  MainTableViewController.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

final class MainTableViewController: UITableViewController {
    
    private let viewModel = MainViewModel()
    private let cellReuseID = "PokemonCell"
    var pokemonNames: [String] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemons"
        bind()
        viewModel.viewDidLoad()
    }

    func bind() {
        viewModel.pokemonNames = { [weak self] pokemons in
            self?.pokemonNames = pokemons
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonNames.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseID, for: indexPath)
        cell.textLabel?.text = pokemonNames[indexPath.row].capitalized
        
        let count = (self.pokemonNames.count)
        
        // fetches more pokemons when reaching the bottom of the list
        if indexPath.row > 90, indexPath.row == count - 1 {
            viewModel.fetchNextPokemons(count: count)
        }
        
        return cell
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            if let destinationVC = segue.destination as? DetailViewController, let index = tableView.indexPathForSelectedRow?.row {
                destinationVC.viewModel.pokemonName = self.pokemonNames[index]
            }
        }
    }

}
