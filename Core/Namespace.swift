//
//  Namespace.swift
//  SwiftChainingDemo
//
//  Created by Carl Chen on 9/13/16.
//  Copyright © 2016 nswebfrog. All rights reserved.
//

import Foundation

protocol NamespaceCompatible {
    associatedtype CompatibleType
    var ccf: CompatibleType { get }
    static var ccf: CompatibleType.Type { get }
}

struct Namespace<Base> {
    let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

extension NamespaceCompatible {
    var ccf: Namespace<Self> {
        return Namespace(self)
    }

    static var ccf: Namespace<Self>.Type {
        return Namespace.self
    }
}

extension NSObject: NamespaceCompatible { }
