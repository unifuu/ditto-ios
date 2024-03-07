//
//  ActView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/03/07.
//

import SwiftUI

class ActApi {
    func fetchActs(completion: @escaping ([Activity]?) -> Void) {
        guard let url = URL(string: "https://unifuu.com/api/act") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(ActivityResp.self, from: data)
                completion(response.activities)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

struct BookView: View {
    @State private var acts: [Activity] = []

    var body: some View {
        VStack {
            List(acts, id: \.id) { act in
                VStack(alignment: .leading) {
                    Text(act.title)
                        .font(.headline)
                }
            }
            .onAppear {
                fetchActs()
            }
        }
    }

    func fetchActs() {
        ActApi().fetchActs { acts in
            if let acts = acts {
                self.acts = acts
            }
        }
    }
}
