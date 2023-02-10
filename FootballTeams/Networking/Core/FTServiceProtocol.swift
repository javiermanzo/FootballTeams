//
//  FTServiceProtocol.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation

public protocol FTServiceProtocolBase: AnyObject {
    var url: String { get set }
    var httpMethod: FTHttpMethod { get set }
    var headers: [String: String]? { get set }
    var queryParameters: [String: String]? { get set }
    var pathParameters: [String: String]? { get set }
    var body: [String: Any]? { get set }
    var needAuth: Bool { get }
    var timeout: TimeInterval { get set }
    var task: URLSessionTask? { get set }
    func dataBody() -> Data?
}

extension FTServiceProtocolBase {
    public func isActive() -> Bool {
        if let task = self.task {
            if !task.progress.isPaused,
               !task.progress.isFinished,
               !task.progress.isCancelled {
                return true
            }
        }
        return false
    }
    
    public func cancel() {
        if let task = self.task {
            DispatchQueue.main.async {
                task.cancel()
                self.task = nil
            }
        }
    }
    
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
