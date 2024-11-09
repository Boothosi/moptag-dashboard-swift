//
//  MopsDataModel.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import Foundation

public struct MopDataModel: Codable {
    let id: Int
    let inUse: Int
    let isMissing: Int
    let isReplaced: Int
    let lastLocation: String
    let lastSeenDatetime: String
    let tag: String
    let usage: Int

    enum CodingKeys: String, CodingKey {
        case id
        case inUse = "in_use"
        case isMissing = "is_missing"
        case isReplaced = "is_replaced"
        case lastLocation = "last_location"
        case lastSeenDatetime = "last_seen_datetime"
        case tag
        case usage
    }

    func toModel() throws -> MopModel {
        guard let lastSeenDateTime = Date(string: lastSeenDatetime) else { throw DateError.parsingFailed }
        return .init(
            id: id,
            inUse: inUse,
            isMissing: isMissing,
            isReplaced: isReplaced,
            lastLocation: lastLocation,
            lastSeenDatetime: lastSeenDateTime,
            tag: tag,
            usage: usage
        )
    }
}

enum DateError: Error {
    case parsingFailed
}
