//
//  BankApp.swift
//  PracticeSwiftUi
//
//  Created by 심연아 on 2/17/25.
//

import SwiftUI

struct BankApp: View {
    @State private var selectedTab = 0
    @State private var cardOffset: CGFloat = 0
    @State private var showDetails = false
    
    var body: some View {
        ZStack {
            VStack {
                
            }
        }
    }
}


struct ActionButton: View {
    var iconName: String
    var labels: String
    var body: some View {
        VStack {
            Button {
                
            } label: {
                Image(systemName: iconName)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(Circle())
            }
            
            Text(labels)
                .font(.caption)
                .foregroundStyle(.gray)
        }
    }
}

struct TransactionRow: View {
    var body: some View {
        HStack {
            Image(systemName: "cart.fill")
                .scaledToFit()
                .font(.title)
                .foregroundStyle(.white)
                .padding()
                .background(Color.red.opacity(0.5))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text("Shopping")
                    .font(.headline)
                Text("17 Feb 2025")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text("-$140.00")
                .font(.headline)
                .foregroundColor(.red)
        }
        .background(Color.white)
        .cornerRadius(10)
    }
}


#Preview {
    BankApp()
}
