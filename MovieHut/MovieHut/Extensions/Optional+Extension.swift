//
//  Optional+Extension.swift
//  MovieHut
//
//  Created by Waqas Khan on 1/28/23.
//

import Foundation

extension Optional where Wrapped == String {
    var orNil: String {
        return self ?? ""
    }
}

extension Optional where Wrapped == Int {
    var orZero: Int {
        return self ?? 0
    }
}

extension Optional where Wrapped == Double {
    var orZero: Double {
        return self ?? 0.0
    }
}

extension Optional where Wrapped == Float {
    var orZero: Float {
        return self ?? 0.0
    }
}
