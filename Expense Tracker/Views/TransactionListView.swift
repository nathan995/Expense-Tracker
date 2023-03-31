//
//  TransactionListView.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import SwiftUI

struct TransactionListView: View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    var body: some View {
        VStack {
            List {
                ForEach(Array(transactionListVM.groupTransactionByMonth()),id: \.key){ month,transactions in
                    Section {
                        ForEach(transactions){ transaction in
                            TransactionRow(transaction: transaction)
                        }
                    } header: {
                        Text(month)
                    }
                    .listSectionSeparator(.hidden)
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Transactions")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static let transactionListVM = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        NavigationView {
            TransactionListView()
                .environmentObject(transactionListVM)
        }
    }
}
