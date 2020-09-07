//
//  ReplaceSpaces.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 03.09.2020.
//  Copyright © 2020 water. All rights reserved.
//

import Foundation

class ReplaceSpaces {
    static func rs(text: String) -> String {
        var newText = ""
        for ch in text {
            if ch == " " {
                newText.append("%20")
            } else {
                newText.append(ch)
            }
        }
        return newText
    }
}
    
