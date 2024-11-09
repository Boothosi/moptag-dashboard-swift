//
//  DashboardViewModel.swift
//  MopTag Dashboard
//
//  Created by Ennio Italiano on 09/11/24.
//

import Dependencies
import Foundation
import SwiftUI

@MainActor @Observable
class DashboardViewModel {
    @ObservationIgnored @Dependency(\.logger) private var logger
    @ObservationIgnored @Dependency(\.mopsRemoteRepository) private var mopsRemoteRepository

    var mops: [MopModel]?
    var presentingResetSheet: Bool = false
    var presentingEndShiftAlert: Bool = false
    var tagToReset: String?
    var resetTagPath: [ResetTagStatus] = []

    func waitForTag() async {
        do {
            tagToReset = try await mopsRemoteRepository.getResettableTags().first
            if let tagToReset {
                resetTagPath.append(.tagFound)
            }
        } catch {
            logger.logError(.general, error.localizedDescription)
        }
    }

    func resetTag() async {
        do {
            resetTagPath.append(.resettingTag)
            try await Task.sleep(for: .seconds(2))
            resetTagPath.append(.resetSuccess)

        } catch {
            logger.logError(.general, error.localizedDescription)
        }
    }

    func dismissResetSheet() {
        tagToReset = nil
        resetTagPath = [.waitingForTag]
    }

    func getAllMops() async {
        do {
            mops = try await mopsRemoteRepository.getAllMops()
        } catch {
            logger.logError(.general, error.localizedDescription)
        }
    }
}

enum ResetTagStatus: Equatable {
    case waitingForTag
    case tagFound
    case resettingTag
    case resetSuccess

    var icon: String {
        return switch self {
        case .waitingForTag:
            "dot.radiowaves.left.and.right"
        case .tagFound:
            "sensor.tag.radiowaves.forward.fill"
        case .resettingTag:
            "clock.arrow.trianglehead.counterclockwise.rotate.90"
        case .resetSuccess:
            "checkmark.seal"
        }
    }

    func title(tag: String? = nil) -> String {
        return switch self {
        case .waitingForTag:
            "Waiting for the tag"
        case .tagFound:
            "Tag \(tag ?? "") found!"
        case .resettingTag:
            "Resetting tag"
        case .resetSuccess:
            "Tag reset successfully"
        }
    }
}
