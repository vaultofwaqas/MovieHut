//
//  MovieManager.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation

protocol MovieManagerProtocol {
    func movieListApi(payload: ServicePayload, completion: @escaping ResultHandler<MovieBase>)
}

class MovieManager {
    
    func movieListApi(payload: ServicePayload, completion: @escaping ResultHandler<MovieBase>) {
        let request = APIService<MovieBase>(success: { (data: MovieBase) -> Void in
            completion(.success(data))
        }, failure: {
            completion(.failure)
        })
        request.makeCall(payload)
    }
}
