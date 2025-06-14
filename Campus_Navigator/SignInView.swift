//
//  LoginView.swift
//  Campus_Navigator
//
//  Created by SAHimeshi 002 on 2025-06-12
//
import SwiftUI

struct SignInView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isAuthenticating = false
    @State private var showError = false
    @State private var navigateToUser = false
    @State private var navigateToPublic = false
    @State private var animateLogo = false

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color.indigo, Color.purple]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    // Close button
                    HStack {
                        Spacer()
                        Button(action: {
                            navigateToPublic = true
                        }) {
                            Image(systemName: "xmark")
                                .font(.title2)
                                .foregroundColor(.white.opacity(0.8))
                                .padding(10)
                                .background(.ultraThinMaterial, in: Circle())
                        }
                    }
                    .padding(.trailing)

                    Spacer()

                    //LOGO
                    Image(systemName: "graduationcap.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .scaleEffect(animateLogo ? 1.05 : 0.95)
                        .animation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true), value: animateLogo)
                        .padding(.bottom, 10)

                    
                    Text("Campus Navigator")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.bottom, 30)

                 //inputfield
                    VStack(spacing: 16) {
                        TextField("Username", text: $username)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled(true)
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                            .foregroundColor(.white)

                        SecureField("Password", text: $password)
                            .padding()
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)

                    // Error message
                    if showError {
                        Text("Invalid credentials")
                            .font(.caption)
                            .foregroundColor(.red)
                            .transition(.opacity)
                    }

                    // SIGNIN
                    Button(action: {
                        authenticateUser()
                    }) {
                        if isAuthenticating {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(.white.opacity(0.25))
                                .cornerRadius(12)
                        } else {
                            Text("Sign In")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background((username.isEmpty || password.isEmpty) ? Color.black.opacity(0.5) : Color.white.opacity(0.35))
                                .cornerRadius(12)
                        }
                    }
                    .disabled(username.isEmpty || password.isEmpty || isAuthenticating)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.top, 10)

                    Spacer()
                }
                .padding()
                .onAppear {
                    animateLogo = true
                }
            }
            .navigationBarBackButtonHidden(true)
         
            .navigationDestination(isPresented: $navigateToUser) {
             MainUserTabView()
            }
            .navigationDestination(isPresented: $navigateToPublic) {
                MainPublicTabView()
            }
        }
    }

    private func authenticateUser() {
        isAuthenticating = true
        showError = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if username == "COB" && password == "A123" {
                navigateToUser = true
            } else {
                showError = true
            }
            isAuthenticating = false
        }
    }
}

// MARK: - Preview
#Preview {
    SignInView()
}


