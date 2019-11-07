//
//  AudiomackAuthClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

public typealias RegisterUserCompletionHandler = (_ response: Result<RegisterResponse>) -> Void
public typealias GetUserDetailsCompletionHandler = (_ response: Result<AudiomackUser>) -> Void
public typealias ForgotPasswordCompletionHandler = (_ response: Result<VoidResponse>) -> Void

/*
Register User Parameter
- email: Email of User to be registered
- name: User name
- password: password chosen
- password2: Re-entered password to confirm
*/

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
	//func getUserDetails(completionHandler: @escaping GetUserDetailsCompletionHandler)
	func forgotPassword(parameter: ForgotPasswordParameter, completionHandler: @escaping ForgotPasswordCompletionHandler)
}

class AuthenticationClientImplementation: AuthenticationClientProtocol {
	
	let apiClient: ApiClient
	let oauthGenerator: OAuth1Swift
	
	init(apiClient: ApiClient, oauthSignatureGenerator: OAuth1Swift) {
		self.apiClient = apiClient
		self.oauthGenerator = oauthSignatureGenerator
	}
	
	/** Register new user
	
	For more info,
	https://www.audiomack.com/data-api/docs#user-registration
	
	- Parameters:
	-  parameter: RegisterUserParameter ( email, artist_name, password, password2)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns RegisterResponse with oauth_token, oauth_token_secret, registered_user
	
	
	*/
	func registerUser(parameter: RegisterUserParameter, completionHandler: @escaping RegisterUserCompletionHandler) {
		let url = BASE_URL + "/register"
		let parameters : [String: Any] = [
			"artist_name":parameter.artist_name,
			"email":parameter.email,
			"password":parameter.password,
			"password2": parameter.password2
		]
		_ = oauthGenerator.client.post(url, parameters: parameters, success: { (response) in
			let result_ = try! RegisterResponse(data: response.data)
			completionHandler(.success(result_))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	// MARK: - Get Authenticated User details
	/// https://www.audiomack.com/data-api/docs#endpoint-flagging
	///
	/// - parameter musicSlug: Url slug of music
	/// - parameter musicType: Music Type - song, album
	/// - parameter artistSlug: URL slug of artist (owner of music)
	///
	/// - returns: A void response with 204 http code.
	/*func getUserDetails(completionHandler: @escaping GetUserDetailsCompletionHandler) {
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
	}*/
	
	/** Reset Password
	
	This sends an email with instructions to follow,  https://www.audiomack.com/data-api/docs#user-password-retrieval
	
	- Parameters:
	-  parameter: ForgotPasswordParameter( email)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns A void response with 204 http code.
	*/
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
