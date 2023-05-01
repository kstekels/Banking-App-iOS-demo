//
//  TransferFundsScreen.swift
//  BankingApp Demo
//
//  Created by Kārlis Štekels on 01/05/2023.
//

import SwiftUI

struct TransferFundsScreen: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject private var transferFundsVM = TransferFundsViewModel()
    @State private var showSheet: Bool = false
    @State private var isFromAccount = false
    
    var actionSheetButtons: [Alert.Button] {
        var actionBtn = self.transferFundsVM.filteredAccounts.map { account in
            Alert.Button.default(Text("\(account.name) (\(account.accountType))")) {
                if self.isFromAccount {
                    self.transferFundsVM.fromAccount = account
                } else {
                    self.transferFundsVM.toAccount = account
                }
            }
        }
        
        actionBtn.append(.cancel())
        return actionBtn
    }
    
    var body: some View {
        VStack {
            AccountListVIew(accounts: self.transferFundsVM.accounts).frame(height: 300)
            
            TransferFundsAccountSelectionView(transferFundsVM: self.transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAccount)
            Spacer()
            Text(self.transferFundsVM.message ?? "")
            Button("Submit Transfer") {
                self.transferFundsVM.submitTransfer()
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .disabled(self.transferFundsVM.toAccount == nil)
            
        }
        .onAppear{
            self.transferFundsVM.populateAccounts()
        }
        .actionSheet(isPresented: $showSheet, content: {
            ActionSheet(title: Text("Transfer Funds"), message: Text("Choose an account"), buttons: self.actionSheetButtons)
        })
        .navigationTitle("Transfer Funds")
        .embedInNavigationView()
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}

struct TransferFundsAccountSelectionView: View {
    
    @ObservedObject var transferFundsVM: TransferFundsViewModel
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Button("From \(self.transferFundsVM.fromAccounType)") {
                showSheet = true
                isFromAccount = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green)
            .foregroundColor(.white)
            
            Button("To \(self.transferFundsVM.toAccounType)") {
                isFromAccount = false
                showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green)
            .foregroundColor(.white)
            .opacity(self.transferFundsVM.fromAccount != nil ? 1.0 : 0.5)
            .disabled(self.transferFundsVM.fromAccount == nil)
            
            TextField("Amount", text: self.$transferFundsVM.amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            
        }.padding()
    }
}
