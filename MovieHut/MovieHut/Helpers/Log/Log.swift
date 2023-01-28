//
//  Log.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation

public enum Log {
    public static func debug(_ message: Any) {
        #if DEBUG
            print(message)
        #endif
    }
}
