//
//  AudiomackSearchClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation

public typealias SearchCompletionHandler = (_ response: Result<AudiomackSearchResponse>) -> Void
public typealias SearchAutoSuggestCompletionHandler = (_ response: Result<[String]>) -> Void

// Type of Search Results
public enum SearchMusicType : String {
	/// Search Music Type of only songs.
	case songs = "songs"
	/// Search Music Type of only albums.
	case albums = "albums"
	/// Search Music Type of only artists.
	case artists = "artists"
	/// Search Music Type of all forms - songs, albums and artists.
	case all = "all"
}

/// Sorting Type for Search Results
public enum SortType : String {
	/// Sorts results by relevance.
	case relevance = "relevance"
	/// Sorts results by recently uploaded.
	case recent = "recent"
	/// Sorts results by most popular.
	case popular = "popular"
}


protocol SearchClientProtocol {
	func search(searchText: String, resultType: SearchMusicType?, sortBy: SortType?, genre: String?, verified: Bool?, page: Int?, limit: Int?, completionHandler: @escaping SearchCompletionHandler)
	func searchAutosuggest(searchText: String, completionHandler: @escaping SearchAutoSuggestCompletionHandler)
}

class SearchClientImplementation: SearchClientProtocol {
	/** Search Audiomack for music, artists
	
		For more info,  https://www.audiomack.com/data-api/docs#search-songs
	
	- Parameters:
		-  searchText: String - text to search
	 	-  resultType: SearchMusicType -  (optional)
		-  sortBy: SortType -  slug of artist (optional)
		-  genre: String -  eg. rap, electronic (optional)
		-  verified: Bool -  verified results only? (optional)
	 	-  page: Int -  for pagination only (optional)
		-  limit: Int -  by default, only 20 results are returned. Adjust to suit your use (optional)
		-  completionHandler: The completion handler to call when the load request is complete.
			`response` - A response object, or `nil` if the request failed.
			`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackSearchResponse containing music, artists
	
	
	*/
	func search(searchText: String, resultType: SearchMusicType?  = .all , sortBy: SortType? = .relevance, genre: String?, verified: Bool?, page: Int?, limit: Int?, completionHandler: @escaping SearchCompletionHandler) {
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
	
	/** Get autosuggested words for search
	
	For more info,  https://www.audiomack.com/data-api/docs#search-autosuggest
	
	- Parameters:
	-  searchText: String - text to search
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns a String array of autosuggested words
	*/
	func searchAutosuggest(searchText: String, completionHandler: @escaping SearchAutoSuggestCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/search_autosuggest?q=\(searchText)", success: { (response) in
			let result_ = try! AudiomackSearchAutoSuggestResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	let authClient: AuthenticationClientImplementation
	
	init(authClient: AuthenticationClientImplementation) {
		self.authClient = authClient
	}
	
}


