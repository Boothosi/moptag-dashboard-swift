//
//  MopModel.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import Foundation

struct MopModel {
    let id: Int
    let inUse: Int
    let isMissing: Int
    let isReplaced: Int
    let lastLocation: String
    let lastSeenDatetime: Date
    let tag: String
    let usage: Int
}
