//
//  GamePlatformViewCell.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 01.09.2020.
//  Copyright © 2020 water. All rights reserved.
//

import UIKit

class GamePlatformViewCell: UITableViewCell {

    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    
    func configureCell(game: Result )-> UITableViewCell {
        
        self.gameNameLabel.text = game.title
        //self.gameNameLabel.backgroundColor =
        self.platformLabel.text = game.platform
        self.platformLabel.backgroundColor = Platform.determineСolor(platform: game.platform)
    
        return self
    }
    
    
    
}
