//
//  LogsDependencyKey.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import CommonLogging
import Dependencies
import Foundation

enum LogsDependencyKey: DependencyKey {
    static var liveValue: CommonLogging<LogsCategories> {
        return CommonLogging<LogsCategories>()
    }
}

extension DependencyValues {
    var logger: CommonLogging<LogsCategories> {
        get { self[LogsDependencyKey.self] }
        set { self[LogsDependencyKey.self] = newValue }
    }
}