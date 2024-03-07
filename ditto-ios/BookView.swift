//
//  BookView.swift
//  ditto-ios
//
//  Created by Fuu on 2024/02/12.
//

import SwiftUI

//class Api {
//    func fetchBooks(completion: @escaping ([Book]?) -> Void) {
//        guard let url = URL(string: "https://unifuu.com/api/book/?status=ToRead") else {
//            completion(nil)
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            guard let data = data, error == nil else {
//                completion(nil)
//                return
//            }
//            
//            do {
//                let response = try JSONDecoder().decode(BooksResp.self, from: data)
//                completion(response.books)
//            } catch {
//                print("Error decoding JSON: \(error)")
//                completion(nil)
//            }
//        }.resume()
//    }
//}
//
//struct BookView: View {
//    @State private var books: [Book] = []
//    
//    var body: some View {
//        VStack {
//            List(books, id: \.id) { book in
//                VStack(alignment: .leading) {
//                    Text(book.title)
//                        .font(.headline)
//                    Text("Author: \(book.author)")
//                        .font(.subheadline)
//                    Text("Publisher: \(book.publisher)")
//                        .font(.subheadline)
//                }
//            }
//            .onAppear {
//                fetchBooks()
//            }
//        }
//    }
//    
//    func fetchBooks() {
//        Api().fetchBooks { books in
//            if let books = books {
//                self.books = books
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
