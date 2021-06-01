//
//  CovidByState.swift
//  covid19-status
//
//  Created by Daniel Vieira on 31/01/21.
//

import Foundation

class CovidByState: Decodable{
    
    let id: Int
    let uf: String
    let state: String
    let cases: Int
    let deaths: Int
    let suspects: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id = "uid"
        case uf
        case state
        case cases
        case deaths
        case suspects
        case date = "datetime"
    }
    
}
