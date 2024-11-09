//
//  EnvironmentDependencyKeys.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import Dependencies
import Foundation

enum EnvironmentDependencyKeys: DependencyKey {
    static var liveValue: EnvironmentAPI {
        MTEnvironment()
    }
}

extension DependencyValues {
    var environment: EnvironmentAPI {
        get { self[EnvironmentDependencyKeys.self] }
        set { self[EnvironmentDependencyKeys.self] = newValue }
    }
}
