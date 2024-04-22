//
//  ContentView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/02/10.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("auth_token") private var authToken: String?
    @State private var isAuth = false
    
    var body: some View {
        NavigationView {
            if isAuth {
                MainView()
            } else {
                LoginView(isAuth: $isAuth)
                .onAppear {
                    if let authToken = authToken, !authToken.isEmpty {
                        checkToken(token: authToken, isAuth: $isAuth)
                    }
                }
            }
        }
    }
}

func checkToken(
    token: String,
    isAuth: Binding<Bool>
) {
    guard let url = URL(string: api(url: "user/checkToken")) else { return }
    
    var req = URLRequest(url: url)
    req.httpMethod = "POST"
    
    let parameters = ["auth_token": token]
    guard let reqBody = try? JSONSerialization.data(withJSONObject: parameters) else {
        print("Failed to serialize request body")
        return
    }
    req.httpBody = reqBody
    
    // Perform network request
    URLSession.shared.dataTask(with: req) { data, response, error in
        // Handle response
        guard let data = data else {
            print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        
        // Decode response JSON
        if let resp = try? JSONDecoder().decode(AuthResp.self, from: data) {
            isAuth.wrappedValue = resp.is_auth
        } else {
            print("Failed to decode response JSON")
        }
    }.resume()
}

struct LoginView: View {
    @Binding var isAuth: Bool
    @State private var username = ""
    @State private var password = ""
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .onChange(of: username) { newValue in
                    if let firstCharacter = newValue.first {
                        if firstCharacter.isUppercase {
                            username = String(firstCharacter).lowercased() + String(newValue.dropFirst())
                        }
                    }
                }
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
        .alert(isPresented: $showAlert) {
            Alert(title: Text("NG"), message: Text("Failed to login!"), dismissButton: .default(Text("OK")))
        }
        .padding()
        .navigationTitle("Login")
    }
    
    func login() {
        guard let url = URL(string: api(url: "user/checkAuth")) else { return }
        
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
            if let response = try? JSONDecoder().decode(AuthResp.self, from: data) {
                // Handle login response
                if response.auth_token.isEmpty {
                    self.showAlert = true
                } else {
                    let authToken = response.auth_token
                    UserDefaults.standard.set(authToken, forKey: "auth_token")
                    isAuth = response.is_auth
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

