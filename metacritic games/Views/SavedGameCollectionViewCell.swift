//
//  SavedGameCollectionViewCell.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 08.09.2020.
//  Copyright © 2020 water. All rights reserved.
//

import UIKit

protocol SavedGameCellDelegate{
    func deleteSavedGame(index: Int)
}

class SavedGameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var savedGameNameLabel: UILabel!
    @IBOutlet weak var savedGameScoreLabel: UILabel!
    @IBOutlet weak var savedGamePlatformLabel: UILabel!
    @IBOutlet weak var blurUnderButton: UIVisualEffectView!
    @IBOutlet weak var deleteButton: UIButton!
    var delegate: SavedGameCellDelegate!
    var indexCell: Int! 
    
    func configureCell(savedGame: SavedGame, indexCell: Int, navigationBarButtonType: RightBarButtonType) -> UICollectionViewCell {
        savedGameNameLabel.text = savedGame.gameName
        savedGameScoreLabel.text = String(savedGame.score)
        savedGamePlatformLabel.text = savedGame.gamePlatform
        savedGameScoreLabel.backgroundColor = determineColorByScore(score: savedGame.score)
        savedGameNameLabel.backgroundColor = determineColorByScore(score: savedGame.score)
        savedGamePlatformLabel.backgroundColor = Platform.determineСolor(platform: savedGame.gamePlatform)
        self.layer.cornerRadius = 8
        
        self.indexCell = indexCell
        
        switch navigationBarButtonType {
        case .edit:
            deleteButton.isHidden = true
            blurUnderButton.isHidden = true
        case .save:
            deleteButton.isHidden = false
            blurUnderButton.isHidden = false
        }
        blurUnderButton.layer.cornerRadius = 3
       
        return self
    }
    
    @IBAction func deleteSavedGame() {
        delegate.deleteSavedGame(index: indexCell)
    }
    
    func determineColorByScore(score: Int) -> UIColor {
        switch score {
        case 75...100:
            return .systemGreen
        case 50...74:
            return .orange
        case 1...100:
            return .red
        default:
            return .gray
        }
    }

}
