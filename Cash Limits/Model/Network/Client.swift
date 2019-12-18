//
//  Client.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 14/12/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import Foundation

class NetworkClient {
    
    //MARK: - api key
    
    static let apiKey = "ENTER_Fixer_API_KEY_HERE"
    
    //MARK: - network method
    
    class func getExchangeRate (completion: @escaping (ExchangeRate?, Error?) -> Void) {
        
        let request = URLRequest(url: URL(string: "http://data.fixer.io/api/latest?access_key=\(NetworkClient.apiKey)&symbols=USD,SAR&format=1")!)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ExchangeRate.self, from: data!)
                print("The rate of SAR is \(responseObject.rates.SAR)")
                completion(responseObject,nil)
            } catch {
                print(error.localizedDescription)
                completion(nil,error)
            }
        }
        task.resume()
    }
}
