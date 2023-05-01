//
//  AddAccountScreen.swift
//  BankingApp Demo
//
//  Created by Kārlis Štekels on 01/05/2023.
//

import SwiftUI

struct AddAccountScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject private var addAccountVM = AddAccountViewModel()
    
    var body: some View {
        Form {
            TextField("Name", text: self.$addAccountVM.name)
            Picker(selection: self.$addAccountVM.accountType) {
                ForEach(AccountType.allCases, id: \.self) { accountType in
                    Text(accountType.title).tag(accountType)
                }
            } label: {
                EmptyView()
            }.pickerStyle(SegmentedPickerStyle())
            TextField("Balance", text: self.$addAccountVM.balance)
            
            HStack {
                Spacer()
                Button("Submit") {
                    self.addAccountVM.createAccount { success in
                        if success {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }.buttonStyle(.borderedProminent)
                Spacer()
            }
            Text(self.addAccountVM.errorMessage)
        }
        .navigationTitle("Add Account")
        .embedInNavigationView()
    }
}

struct AddAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountScreen()
    }
}
