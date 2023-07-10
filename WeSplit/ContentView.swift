//
//  ContentView.swift
//  WeSplit
//
//  Created by Bruce Lopez on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @State private var splitBool = false
    @FocusState private var amountIsFocused: Bool
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalAmount: Double {
        _ = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue

        return grandTotal
    }
    
    var tipAmount: Double {
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection

        return tipValue
    }
    
    let currencyFormatter:FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier  ?? "USD")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Toggle("Split?", isOn: $splitBool)
                    if splitBool {
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<16) {
                                Text("\($0) people")
                            }
                        }}
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                if splitBool {
                    Section {
                        Text(totalPerPerson, format: currencyFormatter)
                    } header: {
                        Text("Amount per person")
                    }
                }
                
                Section {
                    Text(tipAmount, format: currencyFormatter)
                        .foregroundColor(tipPercentage == 0 ? .red : .blue)
                        
                } header: {
                    Text("Tip Amount")
                }
                
                Section {
                    Text(totalAmount, format: currencyFormatter)
                        .foregroundColor(tipPercentage == 0 ? .red : .blue)
                } header: {
                    Text("Total Amount (Amount + Tip)")
                }
            }
            .navigationTitle("TipCal+")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
