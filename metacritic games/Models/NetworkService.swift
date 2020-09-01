//
//  NetworkService.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 31.08.2020.
//  Copyright © 2020 water. All rights reserved.
//

import Foundation

class NetworkService {
    private init() {}
    
    var completion: ((GameNameAndPlatform) -> ())?
    static let shared = NetworkService()
    
    func getGames(gameName: String) {
        let session = URLSession.shared
        
        guard let url = URL(string: "https://chicken-coop.p.rapidapi.com/games?title=\(gameName)&rapidapi-key=74019db3bemshe66cccf6a4168ffp1ef1c1jsn450bff61b1c2") else { return }
        
        session.dataTask(with: url) { (data , _, error) in
            guard let data = data else { return }
            do {
                let games = try JSONDecoder().decode(GameNameAndPlatform.self, from: data)
                self.completion?(games)
            } catch {
                print(error)
            }
        }.resume()
    }
}
