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
    
    
    func getFullData(for cryptos: [String], against currency: String, success: @escaping ([Coin]) -> Void){
        //generate strings for URL
        var cryptoString = ""
        for crypto in cryptos {
            cryptoString += crypto + ","
        }
        cryptoString = String(cryptoString[..<cryptoString.endIndex])
        
        //generate URL
        guard let url = URL(string:
            BASE_URL + "/pricemultifull?fsyms=\(cryptoString)&tsyms=\(currency)") else {
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
                    if  let data = data,
                        let JSONResponse = self.responseFromJSONData(data) {
                        let coins = self.getCoins(coins: cryptos, from: JSONResponse, using: currency)
                        success(coins)
                    }
                    //NSLog(String(describing: self.coinFromJSONData(data!)!))
                    
                case 401: // unauthorized
                    NSLog("weather api returned an 'unauthorized' response. Did you set your API key?")
                default:
                    NSLog("weather api returned response: %d %@", httpResponse.statusCode, HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))
                }
            }
        }
        task.resume()
    }
    
    
    private func responseFromJSONData(_ data: Data) -> Response? {
        //Decodes JSONresponse into dict format
        do {
            let response = try JSONDecoder().decode(Response.self, from: data)
            return response
        } catch {
            print(error)
            return nil
        }
        
    }
    
    private func getCoins(coins: [String], from response: Response,
                          using currency: String) -> [Coin] {
        var output: [Coin] = []
        for coinName in coins {
            if let coin = response.response[coinName]?[currency] {
                output.append(coin)
            }
        }
        return output
    }
}

