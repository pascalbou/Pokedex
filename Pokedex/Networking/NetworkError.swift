//
//  NetworkError.swift
//  Pokedex
//
//  Created by krikaz on 6/12/20.
//  Copyright © 2020 thewire. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badImage
    case badData
    case noDecode
    case otherError
}
