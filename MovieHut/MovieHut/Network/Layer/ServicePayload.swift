//
//  ServicePayload.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation
import UIKit

struct ServicePayload {
    
    init() {}
    
    private var baseUrl: String?
    private var apiEndpoint: ServiceEndPoints?
    private var parameters: [String: Any]?
    private var requestType: URLRequest.RequestMethod?
    private var timeoutInterval: Double? = 15.0
}

extension ServicePayload {
    
    func getBaseUrl() -> String {
        return baseUrl.orNil
    }
    
    func getEndPoint() -> ServiceEndPoints? {
        return apiEndpoint
    }
    
    func getParameters() -> [String: Any]? {
        return parameters
    }
    
    func getRequestType() -> URLRequest.RequestMethod {
        return requestType ?? .get
    }
    
    func getTimeoutInterval() -> Double {
        return timeoutInterval ?? 15.0
    }
    
    mutating func setPayload(baseUrl: String? = nil,
                             apiEndPoint: ServiceEndPoints? = nil,
                             parameters: [String: Any]? = nil,
                             requestType: URLRequest.RequestMethod? = nil,
                             timeoutInterval: Double? = 15.0) {
        self.baseUrl = baseUrl
        self.apiEndpoint = apiEndPoint
        self.parameters = parameters
        self.requestType = requestType
        self.timeoutInterval = timeoutInterval
    }
    
    func getHeaders() -> [String: String] {
        
        var headers = [String: String]()
        
        headers["accept"] = "*/*"
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        
        return headers
    }
}
