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
    private let client = PokemonClient()
    private let cellReuseID = "PokemonCell"
    private var allPokemons: AllPokemonsResponse? {
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
        viewModel.pokemonsOutput = { [weak self] pokemons in
            self?.allPokemons = pokemons
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPokemons?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseID, for: indexPath)
        cell.textLabel?.text = allPokemons?.results[indexPath.row].name.capitalized
        
//        let count = (self.allPokemons?.results.count)!
        
        // fetches more pokemons when reaching the bottom of the list
//        if indexPath.row > 90, indexPath.row == count - 1, self.allPokemons?.next != nil {
//            client.fetchAllPokemons(limit: 100, offset: count) { (result) in
//                if let newPokemons = try? result.get() {
//                    self.allPokemons?.results.append(contentsOf: newPokemons.results)
//                    self.allPokemons?.next = newPokemons.next
//                }
//            }
//        }
        
        return cell
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            if let destinationVC = segue.destination as? DetailViewController, let index = tableView.indexPathForSelectedRow?.row {
                destinationVC.pokemon = self.allPokemons?.results[index]
            }
        }
    }

}
