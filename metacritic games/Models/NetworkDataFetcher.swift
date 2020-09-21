//
//  NetworkDataFetcher.swift
//  metacritic games
//
//  Created by ТАБЛЕТКИ on 15.09.2020.
//  Copyright © 2020 water. All rights reserved.
//

import Foundation

protocol NetworkErrorDelegate {
    func displayError(error: NetworkErrorType)
}

class NetworkDataFetcher {
    
    func fetchGenericJSONData<T: Decodable>(urlString: String, nenworkErrorDelegate: NetworkErrorDelegate, completion: @escaping (T?) -> ()) {
        guard let url = URL(string: urlString) else {
            print(urlString)
            nenworkErrorDelegate.displayError(error: .incorrectUrl)
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data , _ , error) in
            guard let data = data else { nenworkErrorDelegate.displayError(error: .noData); completion(nil);  return }
            do {
                let games = try JSONDecoder().decode(T.self, from: data)
                completion(games)
            } catch {
                print(error)
                nenworkErrorDelegate.displayError(error: .failedDecode)
                completion(nil)
                return
            }
        }.resume()
    }
}
