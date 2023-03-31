//
//  RecentTransactionList.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import SwiftUI

struct RecentTransactionList:View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    var body : some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .bold()
                Spacer()
                NavigationLink{
                    TransactionListView()
                } label: {
                    HStack(spacing: 4) {
                        Text("See All")
                        Image(systemName: "chevron.right")
                        
                    }
                    .foregroundColor (.text)
                }
            }
            .padding (.top)
            
            ForEach(Array(transactionListVM.transactions.prefix(5).enumerated()),id:\.element){ index,transaction in
                TransactionRow(transaction: transaction)
                Divider()
                    .opacity(index == 4 ? 0 : 1)
                
            }
        }
        .padding()
        .background(Color.systemBackground)
        .clipShape(RoundedRectangle (cornerRadius: 20, style: .continuous))
        .shadow(color: Color.primary.opacity (0.2), radius: 10, x: 0, y: 5)
    }
}

struct RecentTransactionList_Previews: PreviewProvider {
    
    static let transactionListVM = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        RecentTransactionList()
            .environmentObject(transactionListVM)
    }
    
}
