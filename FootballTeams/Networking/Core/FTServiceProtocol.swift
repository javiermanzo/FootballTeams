//
//  FTServiceProtocol.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

public protocol FTServiceProtocolBase {
    var url: String { get set }
    var httpMethod: FTHttpMethod { get set }
    var headers: [String: String]? { get set }
    var queryParams: [String: String]? { get set }
    var pathParams: [String: String]? { get set }
    var body: [String: Any]? { get set }
    var needAuth: Bool { get }
    func dataBody() -> Data?
}

extension FTServiceProtocolBase {
    public func getDefaultHeaders() -> [String:String] {
        return FTServiceManager.getDefaultHeaders()
    }
    
    public func dataBody() -> Data? {
        do {
            if let body = self.body {
                let data = try JSONSerialization.data(withJSONObject: body as Any, options: .prettyPrinted)
                return data
            } else {
                return nil
            }
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: -  Protocol With Result
public protocol FTServiceProtocolWithResult: FTServiceProtocolBase {
    associatedtype T: Codable
    func parseData<T: Codable> (data: Data, model: T.Type) -> T?
    func request(completion: @escaping (FTResponseWithResult<T>)->())
}

extension FTServiceProtocolWithResult {
    public func parseData<T: Codable> (data: Data, model: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch (let error) {
            return nil
        }
    }
    
    public func request(completion: @escaping (FTResponseWithResult<T>) -> ()) {
        FTServiceManager.request(model: T.self, service: self, completion: completion)
    }
}
