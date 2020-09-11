//
//  StorageManager.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 07.09.2020.
//  Copyright © 2020 water. All rights reserved.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    //var savedGames: [SavedGame] = []
    
    private let defaults = UserDefaults.standard
    
    func getSavedGames() -> [SavedGame] {
        guard let games = defaults.object(forKey: "games") as? Data else { return [] }
        guard let loadedGames = try? JSONDecoder().decode([SavedGame].self, from: games) else { return [] }
        
        return loadedGames
    }
    
    func saveGame(game: SavedGame){
        var loadedGames: [SavedGame] = []
        if let games = defaults.object(forKey: "games") as? Data {
            if let loadedGamess = try? JSONDecoder().decode([SavedGame].self, from: games) {
                loadedGames = loadedGamess
            }
        }
        loadedGames.append(game)
        guard let gamesEncoded = try? JSONEncoder().encode(loadedGames) else { return }
        defaults.set(gamesEncoded, forKey: "games")
    }
    
    func deleteGame(indexGame: Int) {
        guard let games = defaults.object(forKey: "games") as? Data else { return  }
        guard var loadedGames = try? JSONDecoder().decode([SavedGame].self, from: games) else { return }
        
        loadedGames.remove(at: indexGame)
        
        guard let gamesEncoded = try? JSONEncoder().encode(loadedGames) else { return }
        defaults.set(gamesEncoded, forKey: "games")
    }
}
