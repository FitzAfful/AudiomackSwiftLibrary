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
	
	func getTrendingPlaylists(completionHandler: @escaping GetPlaylistArrayCompletionHandler) {
		let url = BASE_URL + "playlist/trending"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getGenreTrendingPlaylists(genre: String, completionHandler: @escaping GetPlaylistArrayCompletionHandler) {
		let url = BASE_URL + "playlist/\(genre)/trending"
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


