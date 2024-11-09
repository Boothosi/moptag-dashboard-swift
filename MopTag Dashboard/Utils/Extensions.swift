//
//  Extensions.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import Foundation

extension Date {
    init?(string: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd' 'HH':'mm':'ss"
        if let date = dateFormatter.date(from: string) {
            self = date
        } else {
            return nil
        }
    }
}
