//
//  MainView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/02/10.
//

import SwiftUI

struct MainView: View {
//    let authToken: String? = KeyChain.load(key: "auth_token")
    
    let authToken = UserDefaults.standard.string(forKey: "auth_token")
    
    var body: some View {
        Text(authToken ?? "")
            .padding()
            .navigationTitle("Main Screen")
    }
}


#Preview {
    MainView()
}
