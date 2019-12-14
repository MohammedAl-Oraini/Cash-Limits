//
//  Request.swift
//  Cash Limits
//
//  Created by Mohammad Al-Oraini on 14/12/2019.
//  Copyright © 2019 Mohammad Al-Oraini. All rights reserved.
//

import Foundation

struct ExchangeRate: Codable {
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: Rates
}

struct Rates: Codable {
    let USD: Double
    let SAR: Double
}

// base currency "EUR" From API
