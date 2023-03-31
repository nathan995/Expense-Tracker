//
//  TransactionListViewModel.swift
//  Expense Tracker
//
//  Created by Nathan Getachew on 3/31/23.
//

import Foundation
import Combine
import OrderedCollections

typealias TransactionGroup = OrderedDictionary< String,[Transaction]>
typealias TransactionPrefixSum = [(String,Double)]

class TransactionListViewModel : ObservableObject {
    @Published var transactions : [Transaction] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else { print("Invalid URL"); return}
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ (data,response)-> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200  else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on:DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions",error.localizedDescription)
                case .finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] transactions in
                self?.transactions = transactions
                dump(transactions)
            }
            .store(in: &cancellables)
        
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:]}
        let groupedTransactions = TransactionGroup(grouping: transactions){ $0.month }
        return groupedTransactions
        
    }
    
    func accumulateTransactions() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return []}
        
        let today = "02/17/2022".parseDate()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        var sum : Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start, to: today, by: 60*60*24){
            let dailyExpenses = transactions.filter{ $0.parsedDate == date && $0.isExpense }
            let dailyTotal = dailyExpenses.reduce(0){$0 - $1.signedAmount}
            sum += dailyTotal.roundedTo2Digits()
            cumulativeSum.append((date.formatted(),sum))
        }
        return cumulativeSum
    }
}

