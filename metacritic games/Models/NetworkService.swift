//
//  NetworkService.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 31.08.2020.
//  Copyright © 2020 water. All rights reserved.
//

import Foundation

class NetworkService {
    private init() {
        self.completion = { _ in
        }
    }
    
    var completion: ((Any) -> ())
    static let shared = NetworkService()
    
    func getGames(gameName: String) {
        let session = URLSession.shared
        print("0")
        guard let url = URL(string: "https://chicken-coop.p.rapidapi.com/games?title=\(gameName)&rapidapi-key=74019db3bemshe66cccf6a4168ffp1ef1c1jsn450bff61b1c2") else {
            self.completion("Неверный запрос. Введите название игры на английском языке.")
            return }
        print("0.5")
        session.dataTask(with: url){ (data , _ , error) in
            print("1")
            guard let data = data else {
                print("no data")
                self.completion("Сервер не отвечает")
                return }
            print("2")
            do {
                let games = try JSONDecoder().decode(GameNameAndPlatform.self, from: data)
                print("do  \(games)")
                self.completion(games)
            } catch {
                print("catch")
                print(error)
                self.completion("Нет результата")
                return
            }
        }.resume()
        print("end")
        return
    }
    
    func getGameInfo(gameName: String, gamePlatform: String) {
        
        print("getGameInfo(gameName: \(gameName), gamePlatform: \(gamePlatform)")
        let session = URLSession.shared
        guard let url = URL(string: "https://chicken-coop.p.rapidapi.com/games/\(gameName)?platform=\(gamePlatform)&rapidapi-key=74019db3bemshe66cccf6a4168ffp1ef1c1jsn450bff61b1c2") else {
            self.completion("Неверный запрос. Введите название игры на английском языке.")
            return
        }
        session.dataTask(with: url) { (data , _ , error) in
            print("1")
            guard let data = data else {
                print("no data")
                self.completion("Сервер не отвечает")
                return
            }
            print("2")
            do {
                let games = try JSONDecoder().decode(GameInfo.self, from: data)
                print("do  \(games)")
                self.completion(games)
            } catch {
                print("catch")
                print(error)
                self.completion("Нет результата")
                return
            }
        }.resume()
    }
    
}
