//
//  FirstViewController.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 27.08.2020.
//  Copyright © 2020 water. All rights reserved.
//

import UIKit

class StartSearchGameViewController: UIViewController {

    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet var platformsButtons: [UIButton]!
    
    let borderColorRed = CGColor(srgbRed: 1, green: 0, blue: 0, alpha: 1)
    
    var selectedPlatform: Platform?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTF.delegate = self
        
        for button in platformsButtons {
            button.layer.borderColor = borderColorRed
            button.layer.borderWidth = 0
        }
    }
    
    @IBAction func choosePlatform(_ sender: UIButton) {
        if selectedPlatform != nil && sender.tag == selectedPlatform!.rawValue {
            sender.layer.borderWidth = 0
            selectedPlatform = nil
            return
        }
        
        switch sender.tag {
        case 0:
            selectedPlatform = .PC
        case 1:
            selectedPlatform = .PS4
        case 2:
            selectedPlatform = .Switch
        case 3:
            selectedPlatform = .XBOX
        default:
            print(#function + "switch default")
        }
        
        displaySelectedPlatform(selectedButton: sender)
    }
    
    func displaySelectedPlatform(selectedButton: UIButton) {
        for button in platformsButtons {
            if button == selectedButton {
                selectedButton.layer.borderWidth = 3
            } else {
                button.layer.borderWidth = 0
            }
        }
    }
    func fieldValidation() -> Bool {
        if searchTF.text == "" {
            presentAlertController(with: "empty field", message: "Enter the name of the game")
            return false
        }
        return true
    }
    func replaceSpaces(text: String) -> String {
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
    
    func search() {
        if selectedPlatform == nil {
            performSegue(withIdentifier: "go to the GamesTableView", sender: nil)
        } else {
            performSegue(withIdentifier: "go to the GameInfoViewController", sender: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "go to the GamesTableView":
            let gamesVC = segue.destination as! GamesTableViewController
            gamesVC.gameName = replaceSpaces(text: searchTF.text!)
        case "go to the GameInfoViewController":
            let gameInfoVC = segue.destination as! GameInfoViewController
            //
        default:
            break
        }
    }
    
}
// MARK: Text Field Delegate
extension StartSearchGameViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if fieldValidation() {
            search()
        }
        return true
    }
}
// MARK: kinds of platforms
enum Platform: Int {
    case PC
    case PS4
    case Switch
    case XBOX
}

// MARK: alertController

extension StartSearchGameViewController {
    func presentAlertController(with title: String, message: String) {
        let alertC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertC.addAction(.init(title: "OK", style: .cancel, handler: nil))
        present(alertC, animated: true, completion: nil)
    }
}
