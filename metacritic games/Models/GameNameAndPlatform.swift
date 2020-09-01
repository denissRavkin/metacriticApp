//
//  GameNameAndPlatform.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 31.08.2020.
//  Copyright © 2020 water. All rights reserved.
//

import Foundation

struct GameNameAndPlatform: Decodable {
    let result: [Result]
    let countResult: Int
}
struct Result: Decodable {
    let title: String
    let platform: String
}
