//
//  GamesTableViewController.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 28.08.2020.
//  Copyright © 2020 water. All rights reserved.
//

import UIKit

class GamesTableViewController: UITableViewController {

    var gameName: String!
    var games: GameNameAndPlatform?
    var selectGame: Result?
    
    @IBOutlet weak var viewForLoad: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var imageLoad: UIImageView!
    
    
    override func viewDidLoad() {
        
        labelError.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        super.viewDidLoad()
        NetworkService.shared.completion = { [weak self] games in
            if let games = games as? GameNameAndPlatform {
                self!.updateGames(games: games)
            } else if let textError = games as? String {
                self!.displayError(textError: textError)
            }
        }
        print(NetworkService.shared.getGames(gameName: gameName))
    }

    func displayError(textError: String) {
        DispatchQueue.main.async {
            self.labelError.isHidden = false
            self.labelError.text = textError
            self.activityIndicator.stopAnimating()
        }
    }
    func takeAwayLoadView() {
        viewForLoad.frame = .init(x: .zero, y: .zero, width: 0, height: 0)
        activityIndicator.stopAnimating()
        labelError.isHidden = true
        imageLoad.isHidden = true
    }
    func updateGames(games: GameNameAndPlatform) {
        self.games = games
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        if let games = games {
            print("tv if")
            takeAwayLoadView()
            return games.countResult
        }
        print("tf return 0")
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "game-platform", for: indexPath) as! GamePlatformViewCell

        let game = games!.result[indexPath.row]
        return cell.configureCell(game: game)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
     
               selectGame = games!.result[indexPath.row]
            performSegue(withIdentifier: "game-info", sender: nil)
        return indexPath
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        print(segue.destination)
        let gameInfoVC = segue.destination as! GameInfoViewController
        gameInfoVC.gameName = selectGame!.title
        gameInfoVC.gamePlatform = selectGame!.platform
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
