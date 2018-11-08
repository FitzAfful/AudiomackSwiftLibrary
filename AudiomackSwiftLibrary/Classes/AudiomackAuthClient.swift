//
//  AudiomackAuthClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

public typealias RegisterUserCompletionHandler = (_ response: Result<RegisterResponse>) -> Void
public typealias GetUserDetailsCompletionHandler = (_ response: Result<AudiomackUser>) -> Void
public typealias ForgotPasswordCompletionHandler = (_ response: Result<ForgotPasswordResponse>) -> Void

public struct RegisterUserParameter {
	var email: String
	var artist_name: String
	var password: String
	var password2: String
}

public struct ForgotPasswordParameter {
	var email: String
}

protocol AuthenticationClientProtocol {
	func registerUser(parameter: RegisterUserParameter, completionHandler: @escaping RegisterUserCompletionHandler)
	func getUserDetails(completionHandler: @escaping GetUserDetailsCompletionHandler)
	func forgotPassword(parameter: ForgotPasswordParameter, completionHandler: @escaping ForgotPasswordCompletionHandler)
}

class AuthenticationClientImplementation: AuthenticationClientProtocol {
	
	let apiClient: ApiClient
	let oauthGenerator: OAuth1Swift
	
	init(apiClient: ApiClient, oauthSignatureGenerator: OAuth1Swift) {
		self.apiClient = apiClient
		self.oauthGenerator = oauthSignatureGenerator
	}
	
	func registerUser(parameter: RegisterUserParameter, completionHandler: @escaping RegisterUserCompletionHandler) {
		/*let registerRequest = RegisterRequest(parameter: parameter, generator: oauthGenerator)
		
		apiClient.execute(request: registerRequest) { (result: Result<ApiResponse<RegisterResponse>>) in
			switch result {
			case let .success(response):
				let result_ = response.entity
				completionHandler(.success(result_))
			case let .failure(error):
				completionHandler(.failure(error))
			}
		}*/
	}
	
	func getUserDetails(completionHandler: @escaping GetUserDetailsCompletionHandler) {
		/*let request = UserDetailsRequest(generator: oauthGenerator)
		apiClient.execute(request: request) { (result: Result<ApiResponse<AudiomackUser>>) in
			switch result {
			case let .success(response):
				let result_ = response.entity
				completionHandler(.success(result_))
			case let .failure(error):
				completionHandler(.failure(error))
			}
		}*/
	}
	
	func forgotPassword(parameter: ForgotPasswordParameter, completionHandler: @escaping ForgotPasswordCompletionHandler) {
		/*let request = ForgotPasswordRequest(parameter: parameter, generator: oauthGenerator)
		apiClient.execute(request: request) { (result: Result<ApiResponse<ForgotPasswordResponse>>) in
			switch result {
			case let .success(response):
				let result_ = response.entity
				completionHandler(.success(result_))
			case let .failure(error):
				completionHandler(.failure(error))
			}
		}*/
	}
}
