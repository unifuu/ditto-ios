//
//  ContentView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/02/10.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoggedIn = false
    @State private var authToken: String?
    
    var body: some View {
        if isLoggedIn {
            MainView()
        } else {
            LoginView(isLoggedIn: $isLoggedIn, authToken: $authToken)
        }
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
        // Construct URL
        guard let url = URL(string: "https://unifuu.com/api/user/login") else {
            print("Invalid URL")
            return
        }
        
        // Construct URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set request body
        let parameters = ["username": username, "password": password]
        guard let requestBody = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Failed to serialize request body")
            return
        }
        request.httpBody = requestBody
        
        // Perform network request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Decode response JSON
            if let response = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                // Handle login response
                if response.auth_token.isEmpty {
                    isLoggedIn = false
                    authToken = nil
                } else {
                    isLoggedIn = true
                    authToken = response.auth_token
                }
            } else {
                print("Failed to decode response JSON")
            }
        }.resume()
    }
}

struct LoginResponse: Decodable {
    let msg: String
    let auth_token: String
}

#Preview {
    ContentView()
}

