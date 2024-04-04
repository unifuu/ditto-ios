//
//  MarkingView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/03/29.
//

import SwiftUI

struct MarkingView: View {
    //    @ObservedObject var apiService = APIService()
    //
    //    var body: some View {
    //        List {
    //            ForEach(apiService.markings, id: \.self) { item in
    //                Text(item.title)
    //            }
    //        }
    //        .onAppear {
    //            self.apiService.fetchData()
    //        }
    //    }
    
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
            self.apiService.fetchData()
        }
    }
}

class APIService: ObservableObject {
    @Published var markings: [Marking] = []
    
    func fetchData() {
        guard let url = URL(string: "https://unifuu.com/api/marking") else {
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
