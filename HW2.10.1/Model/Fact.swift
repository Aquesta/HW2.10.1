//
//  Fact.swift
//  HW2.10.1
//
//  Created by Aquesta 's on 21.09.2020.
//

struct Fact: Decodable {
    let text: String
    let found: Bool
    let number: Int
    let type, date: String?

    init(){
        text = "Error - Not found"
        found = false
        number = 0
        type = "no type"
        date = "no date"
    }
    
    init(factData: [String: Any]) {
        text = factData["text"] as? String ?? "none"
        found = factData["found"] as? Bool ?? false
        number = factData["number"] as? Int ?? 0
        type = factData["type"] as? String
        date = factData["date"] as? String
    }
    
    static func getFact(from value: Any) -> Fact {
        guard let value = value as? [String: Any] else { return Fact()}
        let fact = Fact(factData: value)
        return fact
    }
}
