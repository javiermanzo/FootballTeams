//
//  FTServiceError.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

public enum FTServiceError: Error {
    case codableError
    case defaultError
    case serviceError(message: String?)
    case requestError(statusCode: Int)
    case timeoutError
    case noConectionError
    case signInError
    case decryptError
    case authorizationError(message: String?)
    case apiError(statusCode: Int, error: FTServiceApiError)
}

public struct FTServiceApiError: Codable {
    let errorCode: FTServiceApiErrorCode
    let message: String
    
    static func parse(data: Data) -> FTServiceApiError? {
        let decoder = JSONDecoder()
        return try? decoder.decode(FTServiceApiError.self, from: data)
    }
}

enum FTServiceApiErrorCode: Int, Codable {
    case rateLimit = 429
    case unknown = 0
    
    public init(from decoder: Decoder) throws {
        self = try FTServiceApiErrorCode(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
