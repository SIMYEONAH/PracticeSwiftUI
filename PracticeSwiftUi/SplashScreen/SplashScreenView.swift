//
//  SplashScreenView.swift
//  PracticeSwiftUi
//
//  Created by 심연아 on 4/5/25.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            Text("Welcome!")
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SplashScreenView()
}
