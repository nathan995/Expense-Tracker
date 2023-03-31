//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import SwiftUI

@main
struct Expense_TrackerApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
