//
//  HomeView.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import SwiftUI
import SwiftUICharts

struct HomeView : View {
    @EnvironmentObject var transactionListVM : TransactionListViewModel
    var body: some View {
        ScrollView{
            VStack (alignment: .leading,spacing: 24){
                Text("Overview")
                    .font(.title2)
                    .bold()
                let data = transactionListVM.accumulateTransactions()
                if !data.isEmpty {
                    let totalExpenses = data.last?.1 ?? 0
                    CardView(showShadow: false) {
                        VStack(alignment: .leading) {
                            ChartLabel(totalExpenses.formatted(.currency(code: "USD")),type: .title,format: "$%.02f" )
                            LineChart()
                        }.background(Color.systemBackground)
                    }
                    .data(data)
                        .chartStyle(.init(backgroundColor: .systemBackground, foregroundColor: ColorGradient(.icon.opacity(0.3),.icon)))
                        .frame(height: 300)
                        .clipShape(RoundedRectangle (cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.primary.opacity (0.2), radius: 10, x: 0, y: 0)
                }
                
                RecentTransactionList()
            }
            .padding()
            .frame(maxWidth: .infinity)
        }.background(Color.background)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem{
                    Image(systemName: "bell.badge")
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color.icon,.primary)
                }
            }
    }
}


struct HomeView_Previews : PreviewProvider {
    static let transactionListVM = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        HomeView()
            .environmentObject(transactionListVM)
        
    }
}
