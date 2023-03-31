//
//  ContentView.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
           HomeView()
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        ContentView()
            .environmentObject(transactionListVM)
    }
}
