//
//  Fetch.swift
//  Pokedex
//
//  Created by krikaz on 6/11/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation
import UIKit

final class PokemonClient {
    let pathBuilder = PokemonPathBuilder()
    
    func fetchAllPokemons(limit: Int, offset: Int, completion: @escaping (AllPokemonsResponse?, Error?) -> Void) {
        
        let allPokemonsURLString = self.pathBuilder.urlAllPokemons(limit: limit, offset: offset)
        let allPokemonsURL = URL(string: allPokemonsURLString)!
        fetch(from: allPokemonsURL) { (allPokemons: AllPokemonsResponse?, error: Error?) in
            guard let allPokemons = allPokemons else {
                completion(nil, error)
                return
            }
            completion(allPokemons, nil)
        }
    }
    
    func fetchOnePokemon(for name: String, completion: @escaping (PokemonDetail?, Error?) -> Void) {
        
        let onePokemonURLString = self.pathBuilder.urlOnePokemon(for: name)
        let onePokemonURL = URL(string: onePokemonURLString)!
        fetch(from: onePokemonURL) { (onePokemon: PokemonDetail?, error: Error?) in
            guard let onePokemon = onePokemon else {
                completion(nil, error)
                return
            }
            completion(onePokemon, nil)
        }
    }
    
    func fetchPokemonSprite(with sprite: String, completion: @escaping (Data?, Error?) -> Void) {

        let pokemonSpriteURL = URL(string: sprite)!
        fetchImageData(from: pokemonSpriteURL) { (pokemonSprite: Data?, error: Error?) in
            guard let pokemonSprite = pokemonSprite else {
                completion(nil, error)
                return
            }
            completion(pokemonSprite, nil)
        }
    }
    
    private func fetch<T: Decodable> (from url: URL, completion: @escaping (T?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: -1, userInfo: nil))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(decodedObject, nil)
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    private func fetchImageData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: -1, userInfo: nil))
                return
            }
            completion(data, nil)
        }
        task.resume()
    }

}

