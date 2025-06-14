//
//  PublicHomeView.swift
//  Campus_Navigator
//
//  Created by SAHimeshi 002 on 2025-06-13.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            let r = Double((hexNumber & 0xff0000) >> 16) / 255
            let g = Double((hexNumber & 0x00ff00) >> 8) / 255
            let b = Double(hexNumber & 0x0000ff) / 255
            
            self.init(red: r, green: g, blue: b)
        } else {
            self.init(red: 0, green: 0, blue: 0)
        }
    }
}

struct PublicHomeView: View {
    @State private var searchText = ""
    @State private var selectedBuilding: String? = nil
    
    var body: some View {
        NavigationView {
            ZStack {
               
                LinearGradient(
                    gradient: Gradient(colors: [Color(hex: "403A7A").opacity(0.05), Color(hex: "403A7A").opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                 
                    headerView
                
                    searchBarView
        
                    mapView
              
                    quickActionsView
                    
                    Spacer()
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: - Header View
    private var headerView: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "403A7A"), Color(hex: "403A7A").opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("CAMPUS")
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("NAVIGATOR")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "bell")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
        }
        .frame(height: 120)
    }
    
    // Search Bar View
    private var searchBarView: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .font(.system(size: 16))
            
            TextField("Search Maps", text: $searchText)
                .font(.system(size: 16))
                .textFieldStyle(PlainTextFieldStyle())
            
           
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 2)
        .padding(.horizontal, 20)
        .padding(.top,10)
        .zIndex(1)
    }
    
    // MARK: - Map View
    private var mapView: some View {
        ZStack {
          
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(hex: "403A7A").opacity(0.1), Color(hex: "403A7A").opacity(0.05)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 400)
                .shadow(color: Color(hex: "403A7A").opacity(0.2), radius: 15, x: 0, y: 5)
            
           
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }
    

    
   
    private func buildingView(name: String, color: Color, position: CGPoint, size: CGSize) -> some View {
        Button(action: {
            selectedBuilding = name
            // Add haptic feedback
            let impactFeedback = UIImpactFeedbackGenerator(style: .light)
            impactFeedback.impactOccurred()
        }) {
            Text(name)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: size.width, height: size.height)
                .background(color)
                .cornerRadius(8)
                .shadow(color: color.opacity(0.4), radius: 4, x: 0, y: 2)
                .scaleEffect(selectedBuilding == name ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: selectedBuilding)
        }
        .offset(x: position.x, y: position.y)
    }
    
    }
    
   
    private var quickActionsView: some View {
        LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12)
        ], spacing: 12) {
            
            // Timeschedule
            actionCard(
                title: "Time Schedule",
                icon: "calendar.badge.clock",
                gradient: [Color(hex: "403A7A"), Color(hex: "403A7A").opacity(0.8)],
                action: {}
            )
            
           //Emergency
            actionCard(
                title: "Help & Emergency",
                icon: "questionmark.circle",
                gradient: [Color(hex: "403A7A").opacity(0.9), Color(hex: "403A7A").opacity(0.7)],
                action: {}
            )
        }
        .padding(.horizontal, 20)
        .padding(.top, 30)
    }
    
    //cards
    private func actionCard(title: String, icon: String, gradient: [Color], action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.white)
                
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: gradient),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(16)
            .shadow(color: gradient.first?.opacity(0.3) ?? .clear, radius: 8, x: 0, y: 4)
        }
        .buttonStyle(ScaleButtonStyle())
    }


// Bottom Tab Bar

struct MainPublicTabView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            
            
            PublicHomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
         
            Text("map")
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("Map")
                }
                .tag(1)
            
            // Library Tab
            PublicReservationView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Library")
                }
                .tag(2)
            
            // Cafeteria Tab
            Text("Cafeteria")
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Cafeteria")
                }
                .tag(3)
            
            // More Tab
            Text("More")
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                    Text("More")
                }
                .tag(4)
        }
        .accentColor(Color(hex: "403A7A"))
    }
}


struct MainUserTabView: View {
    @State private var selectedTab = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Home Tab
            
            
           Text("Home")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
            
         
            Text("map")
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("Map")
                }
                .tag(1)
            
            
            
                .tabItem {
                    Image(systemName: "book")
                    Text("Library")
                }
                .tag(2)
            
            // Cafeteria Tab
            Text("Cafeteria")
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("Cafeteria")
                }
                .tag(3)
            
            // More Tab
            Text("More")
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                    Text("More")
                }
                .tag(4)
        }
        .accentColor(Color(hex: "403A7A"))
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}


struct PublicHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainPublicTabView()
        MainUserTabView()
    }
}
