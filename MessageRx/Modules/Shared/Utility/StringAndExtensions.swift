//
//  StringAndExtensions.swift
//  Utility
//
//  Created by Goyal, Pratik on 18/03/21.
//

import Foundation

public extension String {
    func isEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let pattern = NSPredicate(format: "SELF MATCHES %@", regex)
        return pattern.evaluate(with: self)
    }
}
