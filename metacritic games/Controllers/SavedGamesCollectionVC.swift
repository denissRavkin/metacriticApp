//
//  SavedGamesCollectionVC.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 07.09.2020.
//  Copyright © 2020 water. All rights reserved.
//

import UIKit

enum RightBarButtonType: String {
    case edit = "Ред."
    case save = "Сохр."
}

class SavedGamesCollectionVC: UICollectionViewController {
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    var barButtonEdit: UIBarButtonItem!
    var barButtonSave: UIBarButtonItem!
    var rightBarButtonType: RightBarButtonType = .edit
    
    var savedGames: [SavedGame] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        barButtonEdit = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(switchBarButton(barButton:)))
        barButtonSave = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(switchBarButton(barButton:)))
        navigationBar.rightBarButtonItem = barButtonEdit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        savedGames = StorageManager.shared.getSavedGames()
        collectionView.reloadData()
    }
    
    @objc func switchBarButton(barButton: UIBarButtonItem) {
        switch barButton {
        case barButtonEdit:
            navigationBar.rightBarButtonItem = barButtonSave
            rightBarButtonType = .save
            collectionView.reloadData()
        case barButtonSave:
            navigationBar.rightBarButtonItem = barButtonEdit
            rightBarButtonType = .edit
            collectionView.reloadData()
        default:
            navigationBar.rightBarButtonItem = barButtonEdit
            rightBarButtonType = .edit
            collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return savedGames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "saved game", for: indexPath) as! SavedGameCollectionViewCell
       
        print("\(#function) - \(indexPath.row)")
    
        cell.delegate = self
        return cell.configureCell(savedGame: savedGames[indexPath.row], indexCell: indexPath.row, navigationBarButtonType: rightBarButtonType)
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("df")
        performSegue(withIdentifier: "go to the GameInfoViewController 2",
                     sender: savedGames[indexPath.row])
    }
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let game = sender as? SavedGame else { return }
        let gameInfoVC = segue.destination as! GameInfoViewController
        gameInfoVC.gameName = game.gameName
        gameInfoVC.gamePlatform = game.gamePlatform
    }
    
}

extension SavedGamesCollectionVC: SavedGameCellDelegate {
    func deleteSavedGame(index: Int) {
        StorageManager.shared.deleteGame(indexGame: index)
        savedGames = StorageManager.shared.getSavedGames()
    }
}
