//
//  FTServiceManager.swift
//  FootballTeams
//
//  Created by Javier Manzo on 18/01/2023.
//

import Foundation
import SystemConfiguration

final class FTServiceManager {
    
    static var authProvider: FTAuthProviderProtocol?
    
    // MARK: -  Request with Result
    public static func request<T: Codable, P: FTServiceProtocolWithResult>(model: T.Type, service: P, completion: @escaping (FTResponseWithResult<T>)->()) {
        
        if !self.isConnectedToNetwork() {
            completion(.error(FTServiceError.noConectionError))
            return
        }
        if service.needAuth {
            if let authProvider = self.authProvider {
                if service.headers == nil {
                    service.headers = [String: String]()
                }
                
                service.headers?.merge(authProvider.getCredentialsHeader(), uniquingKeysWith: { (_, new) in new })
                self.requestHandler(model: model, service: service, completion: completion)
            } else {
                completion(.error(FTServiceError.authProviderNeeded))
            }
        } else {
            self.requestHandler(model: model, service: service, completion: completion)
        }
    }
    
    private static func requestHandler<T: Codable, P: FTServiceProtocolWithResult>(model: T.Type, service: P, completion: @escaping (FTResponseWithResult<T>)->()) {
        
        guard let request = self.buildRequest(service: service) else {
            completion(.error(FTServiceError.defaultError))
            return
        }
        
        if let service = service as? FTDebugServiceProtocol {
            service.printRequest(request: request)
        }
        
        service.task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  let data = data else {
                completion(.error(.requestError(statusCode: 0)))
                return
            }
            
            if error != nil {
                completion(.error(.requestError(statusCode: httpResponse.statusCode)))
                return
            }
            
            if let service = service as? FTDebugServiceProtocol {
                service.printResponse(httpResponse: httpResponse, data: data)
            }
            //Debugging
            //           let printData = String(data: data, encoding: .utf8)
            //           print("OVServicesManager::Response ======: ", printData)
            
            if !(200..<300).contains(httpResponse.statusCode) {
                if let error = FTServiceApiError.parse(data: data) {
                    completion(.error(.apiError(statusCode: httpResponse.statusCode, error: error)))
                } else {
                    completion(.error(.requestError(statusCode: httpResponse.statusCode)))
                }
            } else if let parsedResponse = service.parseData(data: data, model: model) {
                completion(.success(parsedResponse))
            } else {
                completion(.error(.codableError))
            }
            
            service.task = nil
        }
        
        service.task?.resume()
    }
    
    // MARK: -  Private Base Methods
    private static func buildRequest<P: FTServiceProtocolBase>(service: P) -> URLRequest? {
        guard let url = compositeURL(url: service.url, pathParams: service.pathParameters, queryParams:  service.queryParameters) else { return nil }
        
        var request = URLRequest(url: url)
        
        if let headers = service.headers, !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.httpMethod = service.httpMethod.rawValue
        
        request.timeoutInterval = service.timeout
        
        if let body = service.dataBody() {
            request.httpBody = body
            request.setValue( "\(body.count)", forHTTPHeaderField: "Content-Length")
        }
        
        return request
    }
    
    private static func compositeURL(url: String, pathParams: [String: String]?, queryParams: [String: String]?) -> URL? {
        var composite = url
        
        if let pp = pathParams {
            for (key, value) in pp {
                composite = url.replacingOccurrences(of: "{\(key)}", with: value)
            }
        }
        
        var url: URL? = URL(string: composite)
        
        if var urlComponents = URLComponents(string: composite) {
            if let qp = queryParams, !qp.isEmpty {
                var queryItems = [URLQueryItem]()
                for (key, value) in qp {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
                urlComponents.queryItems = queryItems.sorted(by: { q1, q2 in
                    return q1.name < q2.name
                })
                url = urlComponents.url
            }
        }
        
        return url
    }
    
    private static func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
    }
    
    static func getDefaultHeaders() -> [String:String] {
        let headers = [
            "Content-Type": "application/json",
            "Accept": "application/json",
        ]
        return headers
    }
}
