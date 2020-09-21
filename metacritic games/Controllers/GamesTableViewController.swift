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
        super.viewDidLoad()
        setupLoadView()
        
        let gamesDataFetcher = GamesDataFetcherService()
        gamesDataFetcher.getGames(gameName: gameName, networkErrorDelegate: self) { [weak self] games in
            guard let games = games else { return }
            self?.updateGames(games: games)
        }
    }

    func updateGames(games: GameNameAndPlatform) {
        self.games = games
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupLoadView() {
        labelError.isHidden = true
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    func takeAwayLoadView() {
        viewForLoad.frame = .init(x: .zero, y: .zero, width: 0, height: 0)
        activityIndicator.stopAnimating()
        labelError.isHidden = true
        imageLoad.isHidden = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        if let games = games {
            takeAwayLoadView()
            return games.countResult
        }
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

}

extension GamesTableViewController: NetworkErrorDelegate {
    func displayError(error: NetworkErrorType) {
        DispatchQueue.main.async {
            self.labelError.isHidden = false
            self.activityIndicator.stopAnimating()
            switch error {
            case .incorrectUrl:
                self.self.labelError.text = "Неверный запрос. Введите название игры на английском языке."
            case .noData:
                self.labelError.text = "Данные не пришли"
            case .failedDecode:
                self.labelError.text = "Нет результата"
            }
        }
    }
}
