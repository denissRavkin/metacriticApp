//
//  GamesDataFetcherService.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 15.09.2020.
//  Copyright © 2020 water. All rights reserved.
//

import Foundation

class GamesDataFetcherService {
    
    var networkDataFetcher: NetworkDataFetcher
    
    init(networkDataFetcher: NetworkDataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func getGames(gameName: String,networkErrorDelegate: NetworkErrorDelegate, completion: @escaping (GameNameAndPlatform?) -> ()) {
        let urlString = "https://chicken-coop.p.rapidapi.com/games?title=\(gameName)&rapidapi-key=74019db3bemshe66cccf6a4168ffp1ef1c1jsn450bff61b1c2"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, nenworkErrorDelegate: networkErrorDelegate, completion: completion)
    }
    
    func getGameInfo(gameName: String, gamePlatform: String, networkErrorDelegate: NetworkErrorDelegate, completion:@escaping (GameInfo?) -> ()) {
        let urlString = "https://chicken-coop.p.rapidapi.com/games/\(ReplaceSpaces.rs(text: gameName))?platform=\(makeGamePlatformForUrl(platform: gamePlatform))&rapidapi-key=74019db3bemshe66cccf6a4168ffp1ef1c1jsn450bff61b1c2"
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, nenworkErrorDelegate: networkErrorDelegate, completion: completion)
    }
   
    private func makeGamePlatformForUrl(platform: String) -> String {
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
    
}

