//
//  RegisterResponse.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

public struct RegisterResponse: InitializableWithData, InitializableWithJson {
	var oauth_token: String
	var oauth_token_secret: String
	var registered_user: AudiomackRegisteredUser
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	init(json: [String : Any]) throws {
		guard let oauth_token =  json["oath_token"] as? String,
			let oauth_token_secret = json["oauth_token_secret"] as? String else {
				throw NSError.createParseError()
		}
		
		if let user = json["user"] as? [String : Any] {
			self.registered_user = try AudiomackRegisteredUser(json: user)
		}else{
			throw NSError.createParseError()
		}
		
		self.oauth_token = oauth_token
		self.oauth_token_secret = oauth_token_secret
	}
}

public struct ForgotPasswordResponse: InitializableWithData, InitializableWithJson {
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	init(json: [String : Any]) throws {
		
	}
}

public struct EmptyResponse: InitializableWithData, InitializableWithJson {
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	init(json: [String : Any]) throws {
		
	}
}
