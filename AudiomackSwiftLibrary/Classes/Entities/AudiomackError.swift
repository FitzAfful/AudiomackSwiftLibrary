//
//  AudiomackError.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 11/11/2018.
//

import Foundation

/// `AudiomackError` is the error type returned. It encompasses a few different types of errors, each with their reasons

public struct AudiomackError : Error, InitializableWithDataAndResponse, InitializableWithJsonAndResponse {
	public var code: Int
	public var message: String = ""
	public var description: String = ""
	public var httpUrlResponse: HTTPURLResponse?
	
	init(data: Data?, response: HTTPURLResponse?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				print("yawa")
				throw NSError.createParseError()
		}
		try self.init(json: json, response: response)
		
	}
	
	init(json: [String : Any], response: HTTPURLResponse?) throws {
		print(json)
		self.code = json["errorcode"] as! Int
		self.message = json["message"] as! String
		if let desc = json["description"] as? String {
			self.description = desc
		}
		
		self.httpUrlResponse = response
		
	}
	
	init(code: Int, message: String, description: String, httpUrlResponse: HTTPURLResponse?){
		self.code = code
		self.message = message
		self.description = description
		self.httpUrlResponse = httpUrlResponse
	}
}
