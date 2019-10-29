//
//  Coin.swift
//  TaskBar-Crypto
//
//  Created by Sanal Bhatia on 24/10/2019.
//  Copyright © 2019 Sanal Bhatia. All rights reserved.
//

import Foundation


struct Coin: CustomStringConvertible, Decodable {
    let name: String
    let imageURL: String
    let exchangeCurrency: String
    let price: Float
    let pctChange1hr: Double
    let pctChange24hr: Double
    let pctChangeDay: Double
    
}

// MARK: - CustomStringConvertible

extension Coin {
    var description: String {
        return name
    }
}


// MARK: - Codable

extension Coin {
    // Coding Keys
    enum CodingKeys: String, CodingKey {
        case name = "FROMSYMBOL"
        case imageURL = "IMAGEURL"
        case exchangeCurrency = "TOSYMBOL"
        case price = "PRICE"
        case pctChange1hr = "CHANGEPCTHOUR"
        case pctChange24hr = "CHANGEPCT24HOUR"
        case pctChangeDay = "CHANGEPCTDAY"
    }
    
    // Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        imageURL = try container.decode(String.self, forKey: .imageURL)
        exchangeCurrency = try container.decode(String.self,
                                                forKey: .exchangeCurrency)
        price = try container.decode(Float.self, forKey: .price)
        pctChange1hr = try container.decode(Double.self, forKey: .pctChange1hr)
        pctChange24hr = try container.decode(Double.self, forKey: .pctChange24hr)
        pctChangeDay = try container.decode(Double.self, forKey: .pctChangeDay)
    }
    
}


