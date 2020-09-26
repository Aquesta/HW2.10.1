//
//  NetworkManagerAM.swift
//  HW2.10.1
//
//  Created by Геннадий Красношлык on 26.09.2020.
//

import Alamofire
import UIKit

class NetworkManagerAF {
    static let shared = NetworkManagerAF()
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
    
    private func fetchData(_ stringURL: String) {
        AF.request(stringURL)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let data):
                    self.onCompletion?(Fact.getFact(from: data))
                case .failure:
                    self.onCompletion?(Fact())
                }
            }
    }
}
