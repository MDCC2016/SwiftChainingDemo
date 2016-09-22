//
//  StringExtension.swift
//  SwiftChainingDemo
//
//  Created by Carl Chen on 9/19/16.
//  Copyright © 2016 nswebfrog. All rights reserved.
//

import Foundation

extension StringProxy {
    var selfValue: String {
        return value
    }
}


struct StringProxy {
    fileprivate let value: String
    init(_ value: String) {
        self.value = value
    }
}

extension String: NamespaceCompatible {
    typealias CompatibleType = StringProxy
    var ccf: CompatibleType {
        return StringProxy(self)
    }

    static var ccf: CompatibleType.Type {
        return StringProxy.self
    }
}

