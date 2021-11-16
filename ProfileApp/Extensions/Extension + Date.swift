//
//  Extension + Date.swift
//  Extension + Date
//
//  Created by Сергей Корнев on 16.11.2021.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int {
        Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
}

