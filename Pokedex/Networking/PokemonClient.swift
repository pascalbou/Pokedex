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
    
    func fetchAllPokemons(limit: Int, offset: Int, completion: @escaping (Result<AllPokemonsResponse, NetworkError>) -> Void) {
        
        let allPokemonsURLString = self.pathBuilder.urlAllPokemons(limit: limit, offset: offset)
        let allPokemonsURL = URL(string: allPokemonsURLString)!
        fetch(from: allPokemonsURL) { (result: Result<AllPokemonsResponse, NetworkError>) in
            if let allPokemons = try? result.get() {
                completion(.success(allPokemons))
            } else {
                completion(.failure(.badData))
            }
            
        }
    }
    
    func fetchOnePokemon(for name: String, completion: @escaping (Result<PokemonDetail, NetworkError>) -> Void) {
        
        let onePokemonURLString = self.pathBuilder.urlOnePokemon(for: name)
        let onePokemonURL = URL(string: onePokemonURLString)!
        fetch(from: onePokemonURL) { (result: Result<PokemonDetail, NetworkError>) in
            if let onePokemon = try? result.get() {
                completion(.success(onePokemon))
            } else {
                completion(.failure(.badData))
            }
            
        }
    }
    
    func fetchPokemonSprite(with sprite: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {

        let pokemonSpriteURL = URL(string: sprite)!
        fetchImageData(from: pokemonSpriteURL) { (result) in
            if let pokemonSprite = try? result.get() {
                completion(.success(pokemonSprite))
            } else {
                completion(.failure(.badData))
            }
        }
    }
    
    private func fetch<T: Decodable> (from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, _, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedObject = try jsonDecoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(.noDecode))
            }
        }
        task.resume()
    }
    
    private func fetchImageData(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let _ = error {
                completion(.failure(.otherError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.badData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }

}

