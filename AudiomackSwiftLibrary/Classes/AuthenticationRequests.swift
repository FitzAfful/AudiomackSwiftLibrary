//
//  AuthenticationRequests.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

var BASE_URL = "https://api.audiomack.com/v1"

struct RegisterRequest: ApiRequest {
	let parameter: RegisterUserParameter
	
	var urlRequest: URLRequest {
		let url: URL! = URL(string: BASE_URL + "/register")
		var request = URLRequest(url: url)
		do{
			let parameters : [String: Any] = [
				"artist_name":parameter.artist_name,
				"email":parameter.email,
				"password":parameter.password,
				"password2": parameter.password2
			]
			let jsonData1 = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
			request.httpBody = jsonData1
			request.setValue("application/json", forHTTPHeaderField: "Content-type")
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			request.httpMethod = "POST"
		}catch{
		}
		return request
	}
}

struct UserDetailsRequest: ApiRequest {
	
	var urlRequest: URLRequest {
		let url: URL! = URL(string: BASE_URL + "/user")
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		request.httpMethod = "GET"
		return request
	}
}


struct ForgotPasswordRequest: ApiRequest {
	let parameter: ForgotPasswordParameter
	
	var urlRequest: URLRequest {
		let url: URL! = URL(string: BASE_URL + "/user/forgot-password")
		var request = URLRequest(url: url)
		do{
			let parameters : [String: Any] = [
				"email":parameter.email
			]
			let jsonData1 = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
			request.httpBody = jsonData1
			request.setValue("application/json", forHTTPHeaderField: "Content-type")
			request.setValue("application/json", forHTTPHeaderField: "Accept")
			request.httpMethod = "POST"
		}catch{
		}
		return request
	}
}
/*

/*request.setValue("HMAC-SHA1", forHTTPHeaderField: "oauth_signature_method")
request.setValue(String(Int(Date().timeIntervalSince1970)), forHTTPHeaderField: "oauth_timestamp")
request.setValue(NSUUID().uuidString, forHTTPHeaderField: "oauth_nonce")
request.setValue("", forHTTPHeaderField: "oauth_signature")
request.setValue("1.0", forHTTPHeaderField: "oauth_version")*/
*/
