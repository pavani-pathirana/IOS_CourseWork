//
//  ContentView.swift
//  Campus_Navigator
//
//  Created by SAHimeshi 002 on 2025-06-12.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var animateLogo = false

    var body: some View {
        if isActive {
            SignInView()
        } else {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    Image(systemName: "graduationcap.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .scaleEffect(animateLogo ? 1.05 : 0.95)
                        .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true), value: animateLogo)
                        .padding(.bottom, 10)

                    VStack(spacing: 6) {
                        Text("HOGWART UNIVERSITY")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .textCase(.uppercase)

                        Text("Campus Navigator")
                            .font(.system(size: 29))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                }
                .onAppear {
                    animateLogo = true
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
