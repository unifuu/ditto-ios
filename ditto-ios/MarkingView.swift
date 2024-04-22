//
//  MarkingView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/03/29.
//

import SwiftUI

struct MarkingView: View {
    @State private var status = "Doing"
    
    var body: some View {
        StatusTabs()
    }
}

struct MarkingList: View {
    @Binding var status: String
    @ObservedObject var apiService = APIService()
    
    var body: some View {
        List(apiService.markings) { marking in
            VStack(alignment: .leading) {
                Text(marking.title)
                Text("By: \(marking.by)")
                // Add other properties as needed
            }
        }
        .onAppear {
            self.apiService.fetchData(withStatus: status)
        }
    }
}

struct StatusTabs: View {
    var body: some View {
        TabView {
            MarkingList(status: .constant("Done"))
                .tabItem {
                    Label("Done", systemImage: "circle.badge.checkmark")
                }
                .accentColor(.purple)
            MarkingList(status: .constant("Doing"))
                .tabItem {
                    Label("Doing", systemImage: "circle.badge.exclamationmark")
                }
                .accentColor(.green)
            MarkingList(status: .constant("Todo"))
                .tabItem {
                    Label("Todo", systemImage: "circle.badge.xmark")
                }
                .background(Color.pink)
        }
    }
}

//struct MarkingList: View {
//    @Binding var status: String
//    @ObservedObject var apiService = APIService()
//    
//    var body: some View {
//        $status
//            .onTapGesture {
//                withAnimation {
//                    List(apiService.markings) { marking in
//                        VStack(alignment: .leading) {
//                            Text(marking.title)
//                            Text("By: \(marking.by)")
//                            // Add other properties as needed
//                        }
//                    }
//                    .onAppear {
//                        self.apiService.fetchData(withStatus: status)
//                    }
//                }
//            }
//    }
//}
//
//struct StatusTabs: View {
//    var body: some View {
//        TabView {
//            MarkingList(status: "Done")
//                .badge(1)
//                .tabItem {
//                    Label("Received", systemImage: "tray.and.arrow.down.fill")
//                }
//            MarkingList(status: "Doing")
//                .badge(2)
//                .tabItem {
//                    Label("Received", systemImage: "tray.and.arrow.down.fill")
//                }
//        }
//    }
//}


class APIService: ObservableObject {
    @Published var markings: [Marking] = []
    
    func fetchData(withStatus status: String) {
        guard var components = URLComponents(string: api(url: "marking")) else {
            return
        }
        components.queryItems = [URLQueryItem(name: "status", value: status)]
        
        guard let url = components.url else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(MarkingResp.self, from: data)
                    DispatchQueue.main.async {
                        self.markings = decodedData.markings
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

#Preview {
    MarkingView()
}
