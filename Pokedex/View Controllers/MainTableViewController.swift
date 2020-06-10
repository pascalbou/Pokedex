//
//  MainTableViewController.swift
//  Pokedex
//
//  Created by krikaz on 6/9/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import UIKit

final class MainTableViewController: UITableViewController {

    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    private let cellReuseID = "PokemonCell"
    private var allPokemons: AllPokemons? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pokemons"
        self.getAllPokemons()
    }
    
    private func getAllPokemons() {
        var url = baseURL
        url.appendPathComponent("pokemon")
        var urlComp = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComp?.queryItems = [URLQueryItem(name: "limit", value: "100"), URLQueryItem(name: "offset", value: "0")]
        
        
        guard let url1 = urlComp?.url else { return }
//        print(url1)
        var request = URLRequest(url: url1)
        request.httpMethod = HTTPMethod.get.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
            guard let data = data else { return }
            do {
                self.allPokemons = try JSONDecoder().decode(AllPokemons.self, from: data)
//                print(self.allPokemons?.results)
//                print(self.allPokemons?.next)
//                print(self.allPokemons?.previous)
            } catch {
                NSLog("Error: \(error)")
            }
        }
        task.resume()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPokemons?.results.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseID, for: indexPath)
        cell.textLabel?.text = allPokemons?.results[indexPath.row].name
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
