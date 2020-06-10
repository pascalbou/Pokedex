//
//  AllPokemons.swift
//  Pokedex
//
//  Created by krikaz on 6/10/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

struct AllPokemonsResponse: Decodable {

    var results: [Pokemon]
    var next: String?
    var previous: String?
}
