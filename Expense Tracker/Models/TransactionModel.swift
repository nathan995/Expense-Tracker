//
//  TransactionModel.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import Foundation

struct Transaction : Identifiable,Decodable,Hashable {
    let id: Int
    let date: String
    let institution: String
    let account: String
    var merchant: String
    let amount: Double
    let type: TransactionType
    var categoryId: Int
    var category: String
    let isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var parsedDate: Date {
        date.parseDate()
    }
    
    var signedAmount : Double {
        type == .credit  ? amount : -amount 
    }
    
    var month: String {
        parsedDate.formatted(.dateTime.year().month(.wide))
    }
}

enum TransactionType : String,Decodable {
    case debit
    case credit 
}
