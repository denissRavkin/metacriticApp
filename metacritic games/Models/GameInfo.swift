//
//  GameInfo.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 31.08.2020.
//  Copyright © 2020 water. All rights reserved.
//

import Foundation

struct GameInfo {
    let result: ResultInfo
}

struct ResultInfo {
    let title: String
    let releaseDate: String
    let description: String
    let genre: [String]
    let image: String
    let score: Int
    let developer: String
    let publisher: [String]
    let rating: Character
    let alsoAvailableOn: [String]
}


