//
//  APINetworkSession.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation

public typealias URLResponse = Result<(data: Data, response: HTTPURLResponse), Error>

class APINetworkSession: NSObject {
    
    var session: URLSession!
    
    deinit {
        session.invalidateAndCancel()
        session = nil
    }
    
    public override convenience init() {
        // Configure the default URLSessionConfiguration.
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 15.0
        sessionConfiguration.waitsForConnectivity = true
        
        // Create a `OperationQueue` instance for scheduling the delegate calls and completion handlers.
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 3
        queue.qualityOfService = .userInitiated
        
        // Call the designated initializer
        self.init(configuration: sessionConfiguration, delegateQueue: queue)
    }
    
    /// Designated initializer.
    /// - Parameters:
    /// - configuration: `URLSessionConfiguration` instance.
    /// - delegateQueue: `OperationQueue` instance for scheduling the delegate calls and completion handlers.
    public init(configuration: URLSessionConfiguration, delegateQueue: OperationQueue) {
        super.init()
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: delegateQueue)
    }
}

extension APINetworkSession: URLSessionDelegate {
    func dataTask(_ request: URLRequest, completionHandler: @escaping (URLResponse) -> Void) -> URLSessionDataTask {
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let data = data, let response = response as? HTTPURLResponse {
                completionHandler(.success((data, response)))
            } else {
                let error = error ?? NSError(domain: "Error", code: -1, userInfo: [:])
                completionHandler(.failure(error))
            }
        }
        dataTask.resume()
        return dataTask
    }
}
