//
//  Data.swift
//  ditto-ios
//
//  Created by Fuu on 2024/02/15.
//

import Foundation

struct Activity: Codable {
    let id: String
    let type: String
    let date: String
    let start: String
    let end: String
    let duration: Int
    let target_id: String
    let title: String
}

struct ActivityResp: Codable {
    let activities: [Activity]
}

struct Summary: Codable {
    let type: String
    let duration: Int
    let hour: Int
    let min: Int
}

struct Stopwatch: Codable {
    let start_time: String
    let end_tiem: String
    let duration: Int
    let type: String
    let target_id: String
    let target_title: String
}

struct Book: Codable {
    let id: String
    let title: String
    let author: String
    let publisher: String
    let pub_year: Int
    let genre: String
    let cur_page: Int
    let total_page: Int
    let status: String
    let total_time: Int
    let hour: Int
    let min: Int
    let page_progress: String
    let page_percentage: String
    let logs: String?
}

struct BooksResp: Codable {
    let books: [Book]
}

struct AuthResp: Codable {
    let is_auth: Bool
    let auth_token: String
}

struct Marking: Codable {
    let id: String
    let title: String
    let by: String
    let type: String
    let year: String
    let current: Int
    let total: Int
    let Status: String
    let progress: String
    let percentage: String
}
