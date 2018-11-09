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

public enum FetchError: Error{
	case NetworkFailed()
	case DeserialisingFailed()
	case ApiError(message:String)
}

