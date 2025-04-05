//
//  BottomSheetView.swift
//  PracticeSwiftUi
//
//  Created by 심연아 on 4/5/25.
//

import SwiftUI

struct SheetView: View {
    @Binding var isSheetPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Button Sheet View")
                    .font(.title).bold()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        isSheetPresented = false
                    }
                }
            }
        }
    }
}


