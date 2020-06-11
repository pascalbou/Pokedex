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
    
    func fetchAllPokemons(using session: URLSession = URLSession.shared, completion: @escaping (AllPokemonsResponse?, Error?) -> Void) {
        
        let allPokemonsURLString = self.pathBuilder.urlAllPokemons()
        let allPokemonsURL = URL(string: allPokemonsURLString)!
        fetch(from: allPokemonsURL, using: session) { (allPokemons: AllPokemonsResponse?, error: Error?) in
            guard let allPokemons = allPokemons else {
                completion(nil, error)
                return
            }
            completion(allPokemons, nil)
        }
    }
    
    func fetchOnePokemon(named name: String, using session: URLSession = URLSession.shared, completion: @escaping (PokemonDetail?, Error?) -> Void) {
        
        let onePokemonURLString = self.pathBuilder.urlOnePokemon(forPokemon: name)
        let onePokemonURL = URL(string: onePokemonURLString)!
        fetch(from: onePokemonURL, using: session) { (onePokemon: PokemonDetail?, error: Error?) in
            guard let onePokemon = onePokemon else {
                completion(nil, error)
                return
            }
            completion(onePokemon, nil)
        }
    }
    
    func fetchPokemonSprite(withSprite sprite: String, using session: URLSession = URLSession.shared, completion: @escaping (Data?, Error?) -> Void) {

        let pokemonSpriteURL = URL(string: sprite)!
        fetchImageData(from: pokemonSpriteURL, using: session) { (pokemonSprite: Data?, error: Error?) in
            guard let pokemonSprite = pokemonSprite else {
                completion(nil, error)
                return
            }

            completion(pokemonSprite, nil)
        }
    }
    
    private func fetch<T: Decodable> (from url: URL, using session: URLSession = URLSession.shared, completion: @escaping (T?, Error?) -> Void) {
        session.dataTask(with: url) {(data, response, error) in
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
        }.resume()
    }
    
    private func fetchImageData(from url: URL, using session: URLSession = URLSession.shared, completion: @escaping (Data?, Error?) -> Void) {
        session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: -1, userInfo: nil))
                return
            }
            completion(data, nil)
        }.resume()
    }

}

