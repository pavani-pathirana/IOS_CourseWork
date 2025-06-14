//
//  PublicReservationView.swift
//  Campus_Navigator
//
//  Created by SAHimeshi 002 on 2025-06-13.
//


import SwiftUI

struct PublicReservationView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var showSignIn = false
    @State private var isPressed = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(spacing: 0) {
                        
                        HStack(spacing: 16) {
                            Button(action: {
                                dismiss()
        }) {
        Image(systemName: "chevron.left")
        .font(.system(size: 18, weight: .medium))
        .foregroundColor(.primary)
    .frame(width: 44, height: 44)
    .background(Color(.systemGray6))
    .clipShape(Circle())
            }
                            
   Text("Library Reservation")
     .font(.system(size: 24, weight: .bold, design: .rounded))
       .foregroundColor(.primary)
                            
   Spacer()
      }
    .padding(.horizontal, 24)
    .padding(.top, 20)
    .padding(.bottom, 40)
                        
                        
    VStack(spacing: 32) {
                            
    VStack(spacing: 24) {
                                
    ZStack {
        Circle()
            .fill(
            LinearGradient(
             colors: [Color(hex: "403A7A").opacity(0.1), Color(hex: "403A7A").opacity(0.05)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                        )
                        ).frame(width: 120, height: 120)
                                    
        Image(systemName: "books.vertical.fill")
            .font(.system(size: 48, weight: .medium))
            .foregroundColor(Color(hex: "403A7A"))
                                }
                                
        VStack(spacing: 12) {
        Text("Sign in to reserve your library seat")
            .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                            }
                            .padding(.horizontal, 16)
                            }
                            
            // cards
        VStack(spacing: 16) {
                            
                FeatureCard(
                    icon: "clock.fill",
                    title: "Flexible Timing",
                    description: "Choose from available time slots"
                        )
                                
                                FeatureCard(
                                    icon: "location.fill",
                                    title: "Seat Selection",
                                    description: "Pick your ideal study location"
                                )
                            }
                            .padding(.horizontal, 24)
                            
                           //signin button
                            VStack(spacing: 16) {
                                NavigationLink(destination: SignInView().navigationBarBackButtonHidden(true)
                , isActive: $showSignIn
                                
                                ) {
                                    EmptyView()
                                }
                                
                       Button(action: {
                                    showSignIn = true
                                }) {
        HStack(spacing: 12) {
        Image(systemName: "person.fill")
        .font(.system(size: 16, weight: .semibold))
                                        
        Text("Sign In to Continue")
        .font(.system(size: 17, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    LinearGradient(
                    gradient: Gradient(colors: [
                    Color(red: 58/255, green: 58/255, blue: 122/255),
                    Color(red: 88/255, green: 88/255, blue: 152/255)
                                ]),
                    startPoint: .leading,
                    endPoint: .trailing
                                        )
                                    )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color(red: 58/255, green: 58/255, blue: 122/255).opacity(0.4), radius: 12, x: 0, y: 6)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
            }
        .simultaneousGesture(
        DragGesture(minimumDistance: 0)
    .onChanged { _ in isPressed = true }
    .onEnded { _ in isPressed = false }
    )
    .padding(.horizontal, 24)
                                
    }
                            
    Spacer(minLength: 40)
                        }
                        .frame(minHeight: geometry.size.height - 100)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .background(Color(.systemBackground))
    }
}

//card styling
struct FeatureCard: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Icon
            ZStack {
                Circle()
                    .fill(Color(red: 58/255, green: 58/255, blue: 122/255).opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(Color(red: 58/255, green: 58/255, blue: 122/255))
            }
            
        
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.systemGray5), lineWidth: 1)
        )
    }
}



struct PublicReservationView_Previews: PreviewProvider {
    static var previews: some View {
        PublicReservationView()
            .preferredColorScheme(.light)
    }
}
