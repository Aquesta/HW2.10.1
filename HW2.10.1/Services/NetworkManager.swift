//
//  NetworkManager.swift
//  HW2.10.1
//
//  Created by Aquesta 's on 21.09.2020.
//
import Foundation

enum TypeRequest: String {
    case random
    case general
}

enum TypeFactRequest: String {
    case trivia = "/trivia"
    case math = "/math"
    case year = "/year"
}

class NetworkManager {
    static let shared = NetworkManager()

    func getFact(typeRequest: TypeRequest, typeFactRequest: TypeFactRequest?, number: String?, completion: @escaping (Fact) -> Void) {
        let api = "http://numbersapi.com/"
        let endpoint = "?json"

        if typeRequest == .general {
            guard let number = number else { return }

            let fullURL = api + number + endpoint

            guard let factURL = URL(string: fullURL) else { return }
            URLSession.shared.dataTask(with: factURL) { data, _, error in
                guard let data = data else { return }
                let jsonDecorer = JSONDecoder()
                do {
                    let fact = try jsonDecorer.decode(Fact.self, from: data)
                    completion(fact)
                } catch {
                    print(error)
                }
            }.resume()
        } else {
            let randomParametr = TypeRequest.random.rawValue
            guard let querry = typeFactRequest?.rawValue else { return }
            let fullURL = api + randomParametr + querry + endpoint

            guard let factURL = URL(string: fullURL) else { return }
            URLSession.shared.dataTask(with: factURL) { data, _, error in
                guard let data = data else { return }
                let jsonDecorer = JSONDecoder()
                do {
                    let fact = try jsonDecorer.decode(Fact.self, from: data)
                    completion(fact)
                } catch {
                    print(error)
                }
            }.resume()
        }
    }
}
