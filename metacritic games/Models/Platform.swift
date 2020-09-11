//
//  Platform.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 01.09.2020.
//  Copyright © 2020 water. All rights reserved.
//

import UIKit


enum Platform: String {
    case PC = "PC"
    case PS4 = "PS4"
    case Switch = "Switch"
    case XBOX = "XBOX"
    
    static func determineСolor(platform: String) -> UIColor {
        switch platform {
        case "PS5","PS4","PS3","PS2","PS1","VITA":
            return .systemBlue
        case "PC":
            return .black
        case "Switch","3DS","WII","N64","WIIU":
            return .systemYellow
        case "XBOX","X360","XONE":
            return .systemGreen
        default:
            return .gray
        }
    }
}
