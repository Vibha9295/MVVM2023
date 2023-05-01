//
//  Validation.swift

import UIKit
import Foundation

struct Validation{
    
    func isEmpty(txtField: Any) -> Bool {
        let value: String = (txtField as AnyObject).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (value.count ) == 0 {
            return true
        }
        return false
    }
   
}
