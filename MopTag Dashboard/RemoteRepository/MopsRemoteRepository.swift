//
//  MopsRemoteRepository.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 12/05/24.
//

import Alamofire
import CoreLocation
import Dependencies
import Foundation

protocol MopsRemoteRepository {
    func getAllMops() async throws -> [MopModel]
    func getResettableTags() async throws -> [String]
    func getMissingMops() async throws -> [MopModel]
    func endShift() async throws
    func getMopsInUse() async throws -> [MopModel]
}

struct MopsLiveRemoteRepository: MopsRemoteRepository {
    @Dependency(\.environment) private var environment
    @Dependency(\.logger) private var logger

    func getAllMops() async throws -> [MopModel] {
        let request = AF.request(
            "\(environment.baseURL)/api/mops/all",
            method: .get
        )

        do {
            let response = try await request.serializingDecodable([MopDataModel].self).value
            return try response.map { try $0.toModel() }
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }

    func getResettableTags() async throws -> [String] {
        let request = AF.request(
            "\(environment.baseURL)/api/tags/resettable",
            method: .get
        )
        
        do {
            let response = try await request.serializingDecodable([String].self).value
            return response
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }

    func getMissingMops() async throws -> [MopModel] {
        let request = AF.request(
            "\(environment.baseURL)/api/mops/missing/all",
            method: .get
        )

        do {
            let response = try await request.serializingDecodable([MopDataModel].self).value
            return try response.map { try $0.toModel() }
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }

    func getMopsInUse() async throws -> [MopModel] {
        let request = AF.request(
            "\(environment.baseURL)/api/tags/in_use",
            method: .get
        )

        do {
            let response = try await request.serializingDecodable([MopDataModel].self).value
            return try response.map { try $0.toModel() }
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }

    func endShift() async throws {
        let request = AF.request(
            "\(environment.baseURL)/endshift",
            method: .post
        )

        do {
            let response = try await request.serializingDecodable(String.self).value
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }
}
