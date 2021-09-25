//
//  Data+Extension.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/21.
//

import Foundation
extension Data {
    func toString() -> String {
        String(data: self, encoding: .utf8) ?? ""
    }
}

