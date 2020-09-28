//
//  String+Extension.swift
//  Social App
//
//  Created by PJ Gutierrez on 9/26/20.
//

import Foundation

extension String {
    func phoneFormat() -> String {
        if self.count == 1 {
            //Country Code
            return "+\(self) ("
        } else if self.count == 7 {
            //Area Code
            return "\(self)) "
        } else if self.count == 12 {
            //Phone pt. 1
            return "\(self)-"
        } else if self.count > 17 {
            //Phone pt. 2
            return String(self.prefix(17))
        } else if self.count == 2 || self.count == 8 {
            //backspace
            return String(self.dropLast(2))
        } else if self.count == 13 {
            return String(self.dropLast())
        }
        
        return self
    }
}
