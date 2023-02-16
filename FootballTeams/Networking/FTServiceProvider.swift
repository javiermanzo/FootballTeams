//
//  FTServiceProvider.swift
//  FootballTeams
//
//  Created by Javier Manzo on 13/02/2023.
//

import Foundation
import Harbor

class FTServiceProvider: HAuthProviderProtocol {
    
    init() {
        Harbor.setAuthProvider(self)
    }
    
    func getCredentialsHeader() async -> [String : String] {
        let header = ["X-Auth-Token": FTConfiguration.apikey]
        return header
    }
    
    static func getDefaultHeaders() -> [String:String] {
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        return headers
    }
}

public struct FTServiceApiError: Codable {
    let errorCode: FTServiceApiErrorCode
    let message: String
    
    init?(data: Data) {
        let decoder = JSONDecoder()
        
        if let error = try? decoder.decode(FTServiceApiError.self, from: data) {
            self = error
        } else {
            return nil
        }
    }
}

enum FTServiceApiErrorCode: Int, Codable {
    case rateLimit = 429
    case unknown = 0
    
    public init(from decoder: Decoder) throws {
        self = try FTServiceApiErrorCode(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
