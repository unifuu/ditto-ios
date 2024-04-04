//
//  MarkingView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/03/29.
//

import SwiftUI

struct MarkingView: View {
    let markings = ["AAA", "BBB", "CCC"]
    
    var body: some View {
        List {
            ForEach(markings, id: \.self) { item in
                NavigationLink(destination: DetailView(item: item)) {
                    Text(item)
                }
            }
        }
    }
    
    struct DetailView: View {
        let item: String
        
        var body: some View {
            Text("Selected Item: \(item)")
                .navigationBarTitle(item)
        }
    }
}

#Preview {
    MarkingView()
}
