//
//  GameInfoViewController.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 28.08.2020.
//  Copyright © 2020 water. All rights reserved.
//

import UIKit

class GameInfoViewController: UIViewController {
    
    var gameName: String!
    var gamePlatform: String!
    var gamePlatformForUrl: String!
   
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var realeseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var viewForLoad: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        StorageManager.shared.saveGame(game: .init(gameName: gameName, gamePlatform: gamePlatform, score: Int(scoreLabel.text ?? "0") ?? 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewForLoad.isHidden = false
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        
        NetworkService.shared.completion = { [weak self] gameInfo in
            if let gameInfo = gameInfo as? GameInfo {
               self!.updateInterface(gameInfo: gameInfo)
            } else if let textError = gameInfo as? String {
               self!.displayError(textError: textError)
            }
        }
        
        NetworkService.shared.getGameInfo(gameName: ReplaceSpaces.rs(text: gameName), gamePlatform: makeGamePlatformForUrl(platform: gamePlatform))
    }
    
    func makeGamePlatformForUrl(platform: String) -> String {
        switch platform {
        case "PS5":
            return "playstation-5"
        case "PS4":
            return "playstation-4"
        case "PS3":
            return "playstation-3"
        case "PS2":
            return "playstation-2"
        case "PS1":
            return "playstation-1"
        case "PC":
            return "pc"
        case "Switch":
            return "switch"
        case "XBOX":
            return "xbox-one"
        case "X360":
            return "xbox-360"
        default:
            return platform.lowercased()
        }
    }
    
    func displayError(textError: String) {
        DispatchQueue.main.async {
            self.errorLabel.isHidden = false
            self.errorLabel.text = textError
            self.activityIndicator.stopAnimating()
        }
    }
    
    func takeAwayLoadView() {
        viewForLoad.isHidden = true
        activityIndicator.stopAnimating()
        errorLabel.isHidden = true
        loadImage.isHidden = true
    }
    
    func updateInterface(gameInfo: GameInfo) {
        DispatchQueue.main.async {
            self.platformLabel.text = self.gamePlatform
            self.gameNameLabel.text = self.gameName
            self.realeseDateLabel.text = gameInfo.result.releaseDate
            for genre in gameInfo.result.genre {
                self.genresLabel.text?.append("\(genre). ")
            }
            self.developerLabel.text = gameInfo.result.developer + "."
            for publisher in gameInfo.result.publisher {
                self.publisherLabel.text?.append("\(publisher). ")
            }
            
            self.ratingLabel.text = gameInfo.result.rating
            if self.ratingLabel.text == "" {
                self.ratingLabel.text = "?"
            }
        
            self.descriptionTextView.text = gameInfo.result.description
        
            let score = gameInfo.result.score
            switch score {
            case 75...100:
                print(score)
                self.scoreLabel.text = String(score)
                self.scoreLabel.backgroundColor = .green
            case 50...74:
                self.scoreLabel.text = String(score)
                self.scoreLabel.backgroundColor = .orange
            case 1...50:
                self.scoreLabel.text = String(score)
                self.scoreLabel.backgroundColor = .red
            default:
                self.scoreLabel.text = "?"
                self.scoreLabel.backgroundColor = .gray
            }
            
            self.takeAwayLoadView()
            
            guard let imageUrl = URL(string: gameInfo.result.image) else { return  }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            self.gameImage.image = UIImage(data: imageData)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
