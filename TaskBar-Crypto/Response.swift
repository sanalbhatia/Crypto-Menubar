//
//  Response.swift
//  TaskBar-Crypto
//
//  Created by Sanal Bhatia on 25/10/2019.
//  Copyright © 2019 Sanal Bhatia. All rights reserved.
//

import Foundation

struct Response: Decodable {
    var response: [String:[String:Coin]]
    //var display: [String:[String:Coin]]
}

// MARK: - Codable
extension Response {
    // Coding Keys
    enum CodingKeys: String, CodingKey {
        case response = "RAW"
        //case display = "DISPLAY"
    }
    
    // Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //let res = try container.n
        //response = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .response)
        
        //testing
        let test = container.allKeys
        print("\n\nContainer: \(container)\n\n")
        print(test)
        
        response = try container.decode([String:[String:Coin]].self, forKey: .response)
        //display = try container.decode([String:[String:Coin]].self, forKey: .display)
    }
}




