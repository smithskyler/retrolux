//
//  HTTPClient.swift
//  Retrolux
//
//  Created by Christopher Bryan Henderson on 7/15/16.
//  Copyright © 2016 Bryan. All rights reserved.
//

import Foundation

// TODO: Add support for ignoring SSL errors.
open class HTTPClient: NSObject, Client, URLSessionDelegate, URLSessionTaskDelegate {
	public private(set) var session: URLSession!
	
	public override init() {
		super.init()
		session = URLSession(configuration: makeSessionConfiguration(), delegate: self, delegateQueue: nil)
	}
	
	public func makeAsynchronousRequest(
		request: inout URLRequest,
		callback: @escaping (_ response: ClientResponse) -> Void
		) -> Task
	{
		request.cachePolicy = session.configuration.requestCachePolicy
		request.timeoutInterval = session.configuration.timeoutIntervalForRequest
		let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
			let clientResponse = ClientResponse(data: data, response: response, error: error)
			callback(clientResponse)
		})
		return HTTPTask(task: task)
	}
	
	/// Subclasses can override this method to provide configuration options during init
	/// (changing a configuration's properties once the session has been created has no effect)
	public func makeSessionConfiguration() -> URLSessionConfiguration {
		return URLSessionConfiguration.default
	}
}
