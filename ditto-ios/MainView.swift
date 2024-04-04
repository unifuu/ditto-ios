//
//  MainView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/02/10.
//

import SwiftUI

struct MainView: View {    
    let authToken = UserDefaults.standard.string(forKey: "auth_token")
    
    let menuItems = ["Activities", "Gaming", "Marking"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menuItems, id: \.self) { menuItem in
                    NavigationLink(destination: destinationView(menu: menuItem)) {
                        Text(menuItem)
                    }
                }
            }
            .navigationBarTitle("Menu")
        }
    }
    
    func destinationView(menu: String) -> some View {
        switch menu {
        case "Marking":
            return AnyView(MarkingView())
        default:
            return AnyView(EmptyView())
        }
    }
}


#Preview {
    MainView()
}
