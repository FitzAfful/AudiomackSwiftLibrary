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
			let error1String = apiError.description.components(separatedBy: "Response-Body=")[1]
			let errorString = error1String.components(separatedBy: ", ")[0]
			let data = Data(errorString.utf8)
			do {
				let error = try AudiomackError(data: data, response: nil)
				return error
			}catch{
				return nil
			}
		}else{
			return nil
		}
	}
}

public enum FetchError: Error{
	case NetworkFailed
	case AudiomackError(code:Int, message:String)
}


extension String {
	
	func slice(from: String, to: String) -> String? {
		
		return (range(of: from)?.upperBound).flatMap { substringFrom in
			(range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
				String(self[substringFrom..<substringTo])
			}
		}
	}
}
