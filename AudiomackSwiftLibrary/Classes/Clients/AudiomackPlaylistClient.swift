//
//  AudiomackPlaylistClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 09/11/2018.
//

import Foundation


public typealias GetPlaylistDetailsCompletionHandler = (_ response: Result<AudiomackMusic>) -> Void
public typealias GetPlaylistArrayCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void


protocol PlaylistClientProtocol {
	func getPlaylistInfo(id: String, fields: [String], completionHandler: @escaping GetPlaylistDetailsCompletionHandler)
	func getPlaylistInfo(playlistSlug: String, artistSlug: String, fields: [String], completionHandler: @escaping GetPlaylistDetailsCompletionHandler)
	func getTrendingPlaylists(completionHandler: @escaping GetPlaylistArrayCompletionHandler)
	func getGenreTrendingPlaylists(genre: String, completionHandler: @escaping GetPlaylistArrayCompletionHandler)
}

class PlaylistClientImplementation: PlaylistClientProtocol {
	
	
	
	/** Get Playlist Info
	
	
	- Parameters:
	-  id: The id of playlist
	-  fields: Fields you want in the response. eg url_slug
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic
	*/

	func getPlaylistInfo(id: String, fields: [String], completionHandler: @escaping GetPlaylistDetailsCompletionHandler) {
		var url = BASE_URL + "/playlist/\(id)"
		var fieldString = "?fields="
		for item in fields {
			if(fields.last! == item){
				fieldString.append("\(item)")
				url.append(fieldString)
			}else{
				fieldString.append("\(item),")
			}
		}
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusic(data: response.data)
			completionHandler(.success(result_))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	
	/** Get Playlist Info
	
	Get details of a playlist
	
	- Parameters:
	-  playlistSlug:    The url slug of playlist.
	-  artistSlug:    The url slug of artist who own's the playlist.
	-  fields:     Fields you want in the response. eg url_slug
	-  fields: Fields you want in the response. eg url_slug
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic
	*/
	
	func getPlaylistInfo(playlistSlug: String, artistSlug: String, fields: [String],  completionHandler: @escaping GetPlaylistDetailsCompletionHandler) {
		var url = BASE_URL + "/playlist/\(artistSlug.trimmingCharacters(in: CharacterSet.whitespaces))/\(playlistSlug.trimmingCharacters(in: CharacterSet.whitespaces))"

		var fieldString = "?fields="
		for item in fields {
			if(fields.last! == item){
				fieldString.append("\(item)")
				url.append(fieldString)
			}else{
				fieldString.append("\(item),")
			}
		}
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusic(data: response.data)
			completionHandler(.success(result_))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	/** Get trending playlists
	
	
	- Parameters:
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns array of AudiomackMusic object
	*/
	
	func getTrendingPlaylists(completionHandler: @escaping GetPlaylistArrayCompletionHandler) {
		let url = BASE_URL + "/playlist/trending"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	/** Get trending playlists by genre
	
	
	- Parameters:
	-  genre: Particular genre you want the trending playlists from
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, an array of AudiomackMusic object
	*/
	func getGenreTrendingPlaylists(genre: String, completionHandler: @escaping GetPlaylistArrayCompletionHandler) {
		let url = BASE_URL + "/playlist/\(genre)/trending"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	
	private let authClient: AuthenticationClientImplementation
	
	init(authClient: AuthenticationClientImplementation) {
		self.authClient = authClient
	}
	
}


