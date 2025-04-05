//
//  ButtonSheetMainView.swift
//  PracticeSwiftUi
//
//  Created by 심연아 on 4/6/25.
//

import SwiftUI

struct ButtonSheetMainView: View {
    @State private var isSheetPresented = false
    var body: some View {
        VStack {
            Button {
                isSheetPresented.toggle()
            } label: {
                Text("Show Bottom Sheet").bold()
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SheetView(
                isSheetPresented: $isSheetPresented)
            .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    ButtonSheetMainView()
}
