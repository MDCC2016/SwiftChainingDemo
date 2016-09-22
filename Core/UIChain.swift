//
//  UIChain.swift
//  SwiftChainingDemo
//
//  Created by Carl Chen on 9/13/16.
//  Copyright © 2016 nswebfrog. All rights reserved.
//

import UIKit
import SnapKit

protocol ChainConfigurable { }
extension ChainConfigurable where Self: UIView {

    func ccf_config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
}

extension UIView: ChainConfigurable {
    static func ccf_create(withSuperView: UIView) -> Self {
        let result = self.init()
        withSuperView.addSubview(result)
        return result
    }

    func ccf_adhere(toSuperView: UIView) -> Self {
        toSuperView.addSubview(self)
        return self
    }

    func ccf_layout(snapKitMaker: (ConstraintMaker) -> Void) -> Self {
        snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return self
    }

}

extension Namespace where Base: UIView {
    static func create(withSuperView: UIView) -> Namespace {
        let result = Base()
        withSuperView.addSubview(result)
        return Namespace(result)
    }

    func adhere(toSuperView: UIView) -> Namespace {
        toSuperView.addSubview(base)
        return self
    }

    func layout(snapKitMaker: (ConstraintMaker) -> Void) -> Namespace {
        base.snp.makeConstraints { (make) in
            snapKitMaker(make)
        }
        return self
    }

    func config(_ config: (Base) -> Void) -> Namespace {
        config(base)
        return self
    }

    var view: Base {
        return base
    }
}

