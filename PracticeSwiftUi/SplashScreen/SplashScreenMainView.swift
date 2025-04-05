//
//  SplashScreenMainView.swift
//  PracticeSwiftUi
//
//  Created by 심연아 on 4/5/25.
//

import SwiftUI

struct SplashScreenMainView: View {
    @State private var showSplash = true
    var body: some View {
        ZStack {
            if showSplash {
                SplashScreenView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5 ))
            } else {
                Text("Hi, there")
                    .font(.largeTitle)
            }
        }
        .onAppear {
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        self.showSplash = false
                    }
                }
        }
    }
}

#Preview {
    SplashScreenMainView()
}
