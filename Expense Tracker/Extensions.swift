//
//  Extensions.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension DateFormatter {
    static let allNumeric: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

extension String {
    func parseDate() -> Date {
        guard let parsedDate = DateFormatter.allNumeric.date(from: self) else {return Date()}
        return parsedDate
    }
}

extension Date  {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}

extension Double {
    func roundedTo2Digits() -> Double  {
        return  (self * 100).rounded()/100
        
    }
}
