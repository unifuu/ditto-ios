//
//  ContentView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/02/10.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("authToken") private var authToken: String?
    
//    @State private var isLoggedIn = false
//    @State private var authToken: String?
    
    var body: some View {
        if let authToken = authToken, !authToken.isEmpty {
            MainView()
        } else {
            
        }
            
//        if isLoggedIn {
//            MainView()
//        } else {
//            LoginView(isLoggedIn: $isLoggedIn, authToken: $authToken)
//        }
    }
}

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var authToken: String?
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: login) {
                Text("Login")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Login")
    }
    
    func login() {
        guard let url = URL(string: "https://unifuu.com/api/user/login"
        ) else { return }
        
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        
        let parameters = ["username": username, "password": password]
        guard let requestBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Failed to serialize request body")
            return
        }
        req.httpBody = requestBody
        
        // Perform network request
        URLSession.shared.dataTask(with: req) { data, response, error in
            // Handle response
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Decode response JSON
            if let response = try? JSONDecoder().decode(AuthData.self, from: data) {
                // Handle login response
                if response.auth_token.isEmpty {
                    isLoggedIn = false
                    authToken = nil
                } else {
                    isLoggedIn = true
                    authToken = response.auth_token
                    
                    UserDefaults.standard.set(authToken, forKey: "auth_token")
                }
            } else {
                print("Failed to decode response JSON")
            }
        }.resume()
    }
}

#Preview {
    ContentView()
}

