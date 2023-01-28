//
//  ServiceEndPoints.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation

enum ServiceEndPoints {
    
    case movieList(_ apiKey: String, _ page: Int)
    case movieDetail(_ movieId: Int, _ apiKey: String)
    
    var methodName: String {
        switch self {
        case .movieList(let apiKey, let page):
            return "?api_key=\(apiKey)&page=\(page)"
        case .movieDetail(let movieId, let apiKey):
            return "/\(movieId)?api_key=\(apiKey)"
        }
    }
}
