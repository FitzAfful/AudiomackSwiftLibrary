//
//  AudiomackSearchClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation

public typealias SearchCompletionHandler = (_ response: Result<AudiomackSearchResponse>) -> Void
public typealias SearchAutoSuggestCompletionHandler = (_ response: Result<AudiomackSearchResponse>) -> Void

public enum SearchMusicType : String {
	case songs = "songs"
	case albums = "albums"
	case artists = "artists"
}

public enum SortType : String {
	case relevance = "relevance"
	case recent = "recent"
	case popular = "popular"
}

protocol SearchClientProtocol {
	func search(searchText: String, resultType: SearchMusicType?, sortBy: SortType?, genre: String?, verified: Bool?, page: Int?, limit: Int?, completionHandler: @escaping SearchCompletionHandler)
	func searchAutosuggest(searchText: String, completionHandler: @escaping SearchAutoSuggestCompletionHandler)
}

class SearchClientImplementation: SearchClientProtocol {
	func search(searchText: String, resultType: SearchMusicType?, sortBy: SortType?, genre: String?, verified: Bool?, page: Int?, limit: Int?, completionHandler: @escaping SearchCompletionHandler) {
		var urlComponents = URLComponents(string: BASE_URL + "search")!
		
		if(resultType != nil){
			urlComponents.queryItems?.append(URLQueryItem(name: "show", value: resultType!.rawValue))
		}
		
		if(sortBy != nil){
			urlComponents.queryItems?.append(URLQueryItem(name: "sort", value: sortBy!.rawValue))
		}
		
		if(page != nil){
			urlComponents.queryItems?.append(URLQueryItem(name: "page", value: "\(page!)"))
		}
		
		if(limit != nil){
			urlComponents.queryItems?.append(URLQueryItem(name: "limit", value: "\(limit!)"))
		}
		
		if(genre != nil){
			urlComponents.queryItems?.append(URLQueryItem(name: "genre", value: genre!))
		}
		
		if(verified != nil){
			urlComponents.queryItems?.append(URLQueryItem(name: "verified", value: "\(verified!)"))
		}
		
		_ = authClient.oauthGenerator.client.get(urlComponents.url!.absoluteString, success: { (response) in
			let result_ = try! AudiomackSearchResponse(data: response.data)
			completionHandler(.success(result_))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func searchAutosuggest(searchText: String, completionHandler: @escaping SearchAutoSuggestCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/search_autosuggest?q=\(searchText)", success: { (response) in
			let result_ = try! AudiomackSearchResponse(data: response.data)
			completionHandler(.success(result_))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	let authClient: AuthenticationClientImplementation
	
	init(authClient: AuthenticationClientImplementation) {
		self.authClient = authClient
	}
	
}


