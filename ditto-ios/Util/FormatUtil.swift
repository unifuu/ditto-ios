//
//  FormatUtil.swift
//  ditto-ios
//
//  Created by Fuu on 2024/04/22.
//

import Foundation

func api(url: String) -> String {
    var u = url
    if u.hasPrefix("/") {
        u = String(u.dropFirst())
    }
    return Constants.baseUrl + "/api/" +  u
}
