//
//  NetworkResult.swift
//  SwiftChainingDemo
//
//  Created by Carl Chen on 9/13/16.
//  Copyright © 2016 nswebfrog. All rights reserved.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

extension APIResult {
    func flatMap<U>(_ transform: (T) -> APIResult<U>) -> APIResult<U> {
        let result: APIResult<U>
        switch self {
        case let .success(value):
            result = transform(value)
        case let .failure(error):
            result = .failure(error)
        }
        return result
    }

    func map<U>(_ transform: @escaping (T) -> U) -> APIResult<U> {
        let result: APIResult<U>
        switch self {
        case let .success(value):
            result = .success(transform(value))
        case let .failure(error):
            result = .failure(error)
        }
        return result
    }
}

extension APIResult {
    @discardableResult
    func successHandler(_ success: (T) -> Void) -> APIResult<T> {
        if case let .success(value) = self {
            success(value)
        }
        return self
    }

    @discardableResult
    func failureHandler(_ failure: (Error) -> Void) -> APIResult<T> {
        if case let .failure(error) = self {
            failure(error)
        }
        return self
    }
}
