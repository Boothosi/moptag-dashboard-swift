//
//  EnvironmentAPI.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import Foundation

protocol EnvironmentAPI {
    var baseURL: URL { get }
}

struct MTEnvironment: EnvironmentAPI {
    let baseURLPath: String = "http://192.168.85.152:5000"
    var baseURL: URL {
        URL(string: baseURLPath)!
    }
}
