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
    private let baseURL = URL(string: "https://pokeapi.co/api/v2/")!
    
    func fetchAllPokemons(using session: URLSession = URLSession.shared, completion: @escaping (AllPokemonsResponse?, Error?) -> Void) {
        
        let allPokemonsURL = self.urlAllPokemons()
        fetch(from: allPokemonsURL, using: session) { (allPokemons: AllPokemonsResponse?, error: Error?) in
            guard let allPokemons = allPokemons else {
                completion(nil, error)
                return
            }
            completion(allPokemons, nil)
        }
    }
    
    func fetchOnePokemon(named name: String, using session: URLSession = URLSession.shared, completion: @escaping (PokemonResponse?, Error?) -> Void) {
        
        let onePokemonURL = self.urlOnePokemon(forPokemon: name)
        fetch(from: onePokemonURL, using: session) { (onePokemon: PokemonResponse?, error: Error?) in
            guard let onePokemon = onePokemon else {
                completion(nil, error)
                return
            }
            completion(onePokemon, nil)
        }
    }
    
    func fetchPokemonSprite(withSprite sprite: String, using session: URLSession = URLSession.shared, completion: @escaping (Data?, Error?) -> Void) {

        guard let pokemonSpriteURL = self.urlPokemonSprite(withSprite: sprite) else { return }
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
    
    private func urlAllPokemons() -> URL {
        var allPokemonsURL = baseURL
        allPokemonsURL.appendPathComponent("pokemon")
        let allPokemonsURLComp = NSURLComponents(url: allPokemonsURL, resolvingAgainstBaseURL: true)!
        allPokemonsURLComp.queryItems = [URLQueryItem(name: "limit", value: "100"), URLQueryItem(name: "offset", value: "0")]
        return allPokemonsURLComp.url!
    }
    
    private func urlOnePokemon(forPokemon pokemonName: String) -> URL {
        var pokemonURL = baseURL
        pokemonURL.appendPathComponent("pokemon")
        pokemonURL.appendPathComponent(pokemonName)
        return pokemonURL
    }
    
    private func urlPokemonSprite(withSprite sprite: String) -> URL? {
        guard let spriteURL = URL(string: sprite) else { return nil }
        return spriteURL
    }

}

