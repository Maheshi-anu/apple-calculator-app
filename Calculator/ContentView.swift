//
//  ContentView.swift
//  Calculator
//
//  Created by Maheshi Anuradha on 2024-11-26.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("MonthlyPayment") var monthlyPayment: String = ""
    @AppStorage("InterestRate") var interestRate: String = ""
    @AppStorage("LoanTerm") var loanTerm: String = ""
    @AppStorage("BorrowValue") var borrowValue: String = ""
    
    func checkVal(text:String, type:String) -> String{
        if type == "double"{
            let value = text.filter {"0123456789.".contains($0)}
            var hasdecimal: Bool = false
            return value.filter { char in
                if char == "." {
                    if hasdecimal {
                        return false
                    } else {
                        hasdecimal = true
                        return true
                    }
                }
            return true
        }
    } else {
        return text.filter {"0123456789".contains($0)}
    }
}
    
    func calculate(){
        if monthlyPayment == "" || interestRate == "" || loanTerm == ""
        {
            return
        }
        var doubleInterestRate = Double(interestRate) ?? 0
        let doubleLoanTerm = Double(loanTerm) ?? 0
        let doubleMonthlyPayment = Double(monthlyPayment) ?? 0
        
        
        doubleInterestRate = doubleInterestRate / 1200
        
        let answer = (doubleMonthlyPayment * (pow((doubleInterestRate + 1), doubleLoanTerm) - 1) * pow((doubleInterestRate + 1), -doubleLoanTerm)) / doubleInterestRate
        
        
        borrowValue = String(format: "%.2f", answer)
    }
    
    var body: some View {
        ZStack{
            Image("house")
                .resizable()
                .scaledToFit()
                .opacity(0.4)
            
            VStack{
                Text("Mortgage Calculater")
                    .font(.system(size: 34 , weight: .bold))
                    
                HStack{
                    Image(systemName: "lirasign.circle.fill")
                    Text("Monthly Payment")
                }
                .font(.system(size: 25 , weight: .regular))
                .padding()
                
                TextField("Enter your monthly payment", text: $monthlyPayment)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: monthlyPayment) { value in
                        let value = checkVal(text: value, type: "double")
                        monthlyPayment = value
                    }
                
                
                
                HStack{
                    Image(systemName: "lirasign.circle.fill")
                    Text("Loan Period - years")
                }
                .font(.system(size: 25 , weight: .regular))
                .padding()
                
                TextField("Loan period", text: $loanTerm)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: loanTerm){ value in
                        let value = checkVal(text: value, type: "int")
                        loanTerm = value
                    }
                
                HStack{
                    Image(systemName: "lirasign.circle.fill")
                    Text("% Interest Rate")
                }
                .font(.system(size: 25 , weight: .regular))
                .padding()
                
                TextField("Interest Rate", text: $interestRate)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: interestRate) { value in
                        let value = checkVal(text: value, type: "double")
                        interestRate = value
                    }
                    .padding()
                Button(action: calculate ) {
                    Text("Calculate")
                }
                .padding()
                Text("Amount that can be browwed: \(borrowValue)")
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
