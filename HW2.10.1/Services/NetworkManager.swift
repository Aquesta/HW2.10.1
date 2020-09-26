//
//  NetworkManager.swift
//  HW2.10.1
//
//  Created by Aquesta 's on 21.09.2020.
//
import Foundation

enum TypeRequest {
    case random(typeFactRequest: TypeFactRequest)
    case general(number: String)
}

enum TypeFactRequest {
    case trivia
    case math
    case year
}

class NetworkManager {
    
    static let shared = NetworkManager()

    var onCompletion: ((Fact) -> Void)?

    func getFact(typeRequest: TypeRequest) {
        var stringURL = ""
        
        switch typeRequest {
        case .random(let typeFactRequest):
            stringURL = "http://numbersapi.com/random/\(typeFactRequest)?json"
        
        case .general(let number):
            stringURL = "http://numbersapi.com/\(number)?json"
        }
        fetchData(stringURL)
    }

    fileprivate func fetchData(_ stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            guard let fact = self.parseJSON(from: data) else { return }
            self.onCompletion?(fact)
        }
        task.resume()
    }

    fileprivate func parseJSON(from data: Data) -> Fact? {
        let jsonDecorer = JSONDecoder()
        do {
            let fact = try jsonDecorer.decode(Fact.self, from: data)
            return fact
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
}
