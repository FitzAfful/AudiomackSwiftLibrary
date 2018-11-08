//
//  File.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

public class AudiomackClient {
	
	private let authClient: AuthenticationClientImplementation
	private let artistClient: ArtistClientImplementation
	
	public init(consumerKey: String, consumerSecret: String, oauthToken: String, oauthTokenSecret: String, oauthTokenVerifier: String?) {
		authClient = AuthenticationClientImplementation(apiClient: ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,completionHandlerQueue: OperationQueue.main), oauthSignatureGenerator: OAuth1Swift(consumerKey: consumerKey, consumerSecret: consumerSecret))
		artistClient = ArtistClientImplementation(authClient: authClient)
	}
	
	public func registerUser(email: String, name: String, password: String, password2: String, completionHandler: @escaping RegisterUserCompletionHandler) {
		let parameter = RegisterUserParameter(email: email, artist_name: name, password: password, password2: password2)
		authClient.registerUser(parameter: parameter) { (result) in
			completionHandler(result)
		}
	}
	
	public func getArtistDetails(slug: String, completionHandler: @escaping GetArtistDetailsCompletionHandler) {
		artistClient.getArtistDetails(parameter: ArtistParameter(slug: slug)) { (result) in
			completionHandler(result)
		}
	}
	
	
}
