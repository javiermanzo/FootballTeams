//
//  FTServiceError.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

public enum FTServiceError: Error {
    case apiError(statusCode: Int, errorData: Data)
    case authProviderNeeded
    case badRequestError
    case codableError
    case malformedRequestError
    case noConectionError
    case requestError(statusCode: Int, response: HTTPURLResponse, error: Error?)
    case timeoutError
}


