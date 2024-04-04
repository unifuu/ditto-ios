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
    
    //    var body: some View {
    //        Text(authToken ?? "")
    //            .padding()
    //            .navigationTitle("Main Screen")
    //
    //        NavigationView {
    //            List {
    //                NavigationLink(destination: BookView()) {
    //                    Text("Book Page")
    //                }
    //            }
    //            .navigationTitle("Books")
    //        }
    //    }
    
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
    
//    struct DetailView: View {
//        let menuItem: String
//        
//        var body: some View {
//            Text("Selected Menu Item: \(menuItem)")
//                .navigationBarTitle(menuItem)
//        }
//    }
//    
//    VStack {
//                ForEach(menus, id: \.self) { menu in
//                    NavigationLink(destination: self.destinationView(for: menu)) {
//                        Text(menu)
//                    }
//                }
//            }


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
