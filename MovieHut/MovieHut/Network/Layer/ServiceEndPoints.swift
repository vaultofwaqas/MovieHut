//
//  ServiceEndPoints.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation

enum ServiceEndPoints {
    
    case movieList(_ apiKey: String)
    
    var methodName: String {
        switch self {
        case .movieList(let apiKey):
            return "?api_key=\(apiKey)"
        }
    }
}

/*========================================================================*/
