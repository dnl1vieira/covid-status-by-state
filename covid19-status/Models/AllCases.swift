//
//  AllCases.swift
//  covid19-status
//
//  Created by Daniel Vieira on 31/01/21.
//

import Foundation

struct AllCases: Decodable {
    let all: [CovidByState]
    
    enum CodingKeys: String, CodingKey {
        case all = "data"
    }
}
