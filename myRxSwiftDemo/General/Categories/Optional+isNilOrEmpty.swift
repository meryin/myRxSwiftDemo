//
//  Optional+isNilOrEmpty.swift
//  myRxSwiftDemo
//
//  Created by 尹彩霞 on 2018/1/4.
//  Copyright © 2018年 尹彩霞. All rights reserved.
//

import Foundation
// Since all optionals are actual enum values in Swift, we can easily
// extend them for certain types, to add our own convenience APIs

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case let string?:
            return string.isEmpty
        case nil:
            return true
        }
    }
}

// Since strings are now Collections in Swift 4, you can even
// add this property to all optional collections:

extension Optional where Wrapped: Collection {
    var isNilOrEmpty: Bool {
        switch self {
        case let collection?:
            return collection.isEmpty
        case nil:
            return true
        }
    }
}

/*例子
 func validateTextFields() -> Bool {
 guard !usernameTextField.text.isNilOrEmpty else {
 return false
 }
 
 ...
 
 return true
 }

 
 
 */
