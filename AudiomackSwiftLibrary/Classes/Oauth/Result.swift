//
//  Result.swift
//  Audiomack
//
//  Created by Fitzgerald Afful on 04/01/2018.
//  Copyright © 2018 Aftown. All rights reserved.
//

import Foundation

public struct CoreError: Error {
	var localizedDescription: String {
		return message
	}
	
	var message = ""
}


public enum Result<T> {
	case success(T)
	case failure(Error)
	
	public func dematerialize() throws -> T {
		switch self {
		case let .success(value):
			return value
		case let .failure(error):
			throw error
		}
	}
}

public extension Error {
	var audiomackError: AudiomackError? {
		if let apiError = self as? ApiError {
			if let resultError = try? AudiomackError(data: apiError.data, response: apiError.httpUrlResponse) {
			return resultError
			} else{
				return nil
			}
		}else if let apiError = self as? OAuthSwiftError{
			return AudiomackError(code: apiError.errorCode, message: apiError.description, description: apiError.underlyingMessage ?? "", httpUrlResponse: nil)
		}else{
			return nil
		}
	}
}

public enum FetchError: Error{
	case NetworkFailed()
	case AudiomackError(code:Int, message:String)
}

