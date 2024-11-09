//
//  MopsRemoteRepositoryDependencyKey.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import Dependencies
import Foundation

enum MopsRemoteRepositoryDependencyKey: DependencyKey {
    static var liveValue: MopsRemoteRepository {
        return MopsLiveRemoteRepository()
    }
}

extension DependencyValues {
    var mopsRemoteRepository: MopsRemoteRepository {
        get { self[MopsRemoteRepositoryDependencyKey.self] }
        set { self[MopsRemoteRepositoryDependencyKey.self] = newValue }
    }
}
