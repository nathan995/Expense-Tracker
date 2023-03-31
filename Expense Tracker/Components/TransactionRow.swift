//
//  TransactionRow.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import SwiftUI

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack(spacing: 20 ){
            RoundedRectangle (cornerRadius: 20, style: .continuous)
            .fill(Color.icon.opacity(0.3))
            .frame (width: 44, height: 44)
            .overlay{
                Image(systemName: "square.fill")
            }
            
            VStackLayout(alignment: .leading,spacing: 6){
                Text(transaction.merchant)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                Text(transaction.category)
                    .font(.footnote)
                    .lineLimit(1)
                Text(transaction.parsedDate,format:.dateTime.year().month().year())
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(transaction.signedAmount,format: .currency(code: "USD"))
                .bold()
                .foregroundColor(transaction.type == .credit ? .text:.primary)
            
        }.padding(.vertical,8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        TransactionRow(transaction: transactionPreviewData)
    }
}
