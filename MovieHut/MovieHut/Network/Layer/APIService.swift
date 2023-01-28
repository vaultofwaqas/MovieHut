//
//  APIService.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation

typealias ResultHandler<T> = (ResultType<T>) -> Void

enum ResultType<T> {
    case success(T)
    case failure
}

class APIService<T> where T: Codable {
    
    private let successCall: ((T) -> Void)
    private let failureCall: () -> Void
    
    let apiNetworkSession = APINetworkSession()
    let apiRequestDispatcher = APIRequestDispatcher<T>()
    var task: URLSessionDataTask!
    
    init(success: @escaping (T) -> Void, failure: @escaping () -> Void) {
        self.successCall = success
        self.failureCall = failure
    }
}

extension APIService {
    
    @discardableResult func makeCall(_ payload: ServicePayload, urlRequest: URLRequest? = nil) -> URLSessionDataTask? {
        guard let request = urlRequest else {
            var url = String()
            let baseUrl = payload.getBaseUrl()
            
            if let endPoint = payload.getEndPoint() {
                url = baseUrl + endPoint.methodName
            }
            
            guard let requestURL = URL(string: url) else { return nil }
            
            let urlRequest = URLRequest(url: requestURL,
                                        method: payload.getRequestType(),
                                        header: payload.getHeaders(),
                                        body: payload.getParameters(),
                                        timeoutInterval: payload.getTimeoutInterval())
            
            return executeCall(with: urlRequest)
        }
        
        return executeCall(with: request)
    }
    
    private func executeCall(with request: URLRequest) -> URLSessionDataTask {
        task?.cancel()
        task = apiNetworkSession.dataTask(request, completionHandler: { result in
            switch result {
            case .success(let response):
                Log.debug("------------------------------------------------")
                Log.debug("STATUS_CODE: \(response.response.statusCode)")
                Log.debug("ROUTE: \(request.url?.absoluteString ?? "")")
                Log.debug("METHOD: \(request.method ?? .get)")
                Log.debug("HEADERS: \(request.allHTTPHeaderFields?.getJsonFromDictionary ?? "")")
                
                if let parameter = request.httpBody?.getJSONFromData {
                    Log.debug("PARAMETERS: \(parameter)")
                }
                
                if let dataJsonResponse = response.data.getJSONFromData {
                    Log.debug(("RESPONSE: \(dataJsonResponse)"))
                }
                Log.debug("------------------------------------------------")
                
                let result = self.apiRequestDispatcher.parse(response.data)
                
                switch result {
                case .success(let apiResponse):
                    let requestResult = self.apiRequestDispatcher.verify(apiResponse: apiResponse, statuscode: response.response.statusCode)
                    switch requestResult {
                    case .success(let response):
                        self.handleSucessResponse(data: response)
                    case .failure(let error):
                        Log.debug(error)
                        self.failureCall()
                    }
                case .failure(let error):
                    Log.debug(error)
                    self.failureCall()
                }
            case .failure(let error):
                Log.debug(error)
                self.failureCall()
            }
        })
        
        return task
    }
    
    private func handleSucessResponse(data: T?) {
        guard let data = data else {
            failureCall()
            return
        }
        
        // MARK: Success From Server
        successCall(data)
    }
}
