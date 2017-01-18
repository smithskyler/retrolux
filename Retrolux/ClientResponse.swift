//
//  ClientResponse.swift
//  Retrolux
//
//  Created by Bryan Henderson on 12/12/16.
//  Copyright © 2016 Bryan. All rights reserved.
//

import Foundation

public struct ClientResponse {
    public let data: Data?
    public let response: URLResponse?
    public let error: Error?
    
    public var status: Int? {
        return (response as? HTTPURLResponse)?.statusCode
    }
    
    public init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }
}
