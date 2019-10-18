//
//  CryptoAPI.swift
//  TaskBar-Crypto
//
//  Created by Sanal Bhatia on 27/09/2019.
//  Copyright © 2019 Sanal Bhatia. All rights reserved.
//

import Foundation

class CryptoAPI {
    //let API_KEY = ""
    let BASE_URL = "https://min-api.cryptocompare.com/data"
    
    /* Gets the live exchange rate of given crypto-currency against
       given currency using the CryptoCompare API
    */
    func getRate(for crypto: String, against currency: String){
        //price?fsym=BTC&tsyms=USD,JPY,EUR
        //let session = URLSession.shared
        guard let url = URL(string:
            BASE_URL + "/price?fsym=\(crypto)&tsyms=\(currency)") else {
                NSLog("Incorrect URL generated")
                return
        }
        let request = URLRequest(url: url)
        //request.setValue(API_KEY, forHTTPHeaderField: "Apikey")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // first check for a hard error
            if let err = error {
                NSLog("crypto api error: \(err)")
            }
            
            // then check the response code
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: // all good!
                    if let dataString = String(data: data!, encoding: .utf8) {
                        NSLog(dataString)
                    }
                case 401: // unauthorized
                    NSLog("weather api returned an 'unauthorized' response. Did you set your API key?")
                default:
                    NSLog("weather api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        task.resume()
    }
    
    
    func getFullData(for cryptos: [String], against currencies: [String]){
        //generate strings for URL
        var cryptoString = ""
        var currencyString = ""
        for crypto in cryptos {
            cryptoString += crypto + ","
        }
        for currency in currencies {
            currencyString += currency + ","
        }
        cryptoString = String(cryptoString[..<cryptoString.endIndex])
        currencyString = String(currencyString[..<currencyString.endIndex])
        
        //generate URL
        guard let url = URL(string:
            BASE_URL + "/pricemultifull?fsyms=\(cryptoString)&tsyms=\(currencyString)") else {
                NSLog("Incorrect URL generated")
                return
        }
        
        let request = URLRequest(url: url)
        //request.setValue(API_KEY, forHTTPHeaderField: "Apikey")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // first check for a hard error
            if let err = error {
                NSLog("crypto api error: \(err)")
            }
            
            // then check the response code
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200: // all good!
                    if let dataString = String(data: data!, encoding: .utf8) {
                        NSLog(dataString)
                    }
                case 401: // unauthorized
                    NSLog("weather api returned an 'unauthorized' response. Did you set your API key?")
                default:
                    NSLog("weather api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        task.resume()
    }
}


enum Currency {
    
}

enum Crypto {
    
}

