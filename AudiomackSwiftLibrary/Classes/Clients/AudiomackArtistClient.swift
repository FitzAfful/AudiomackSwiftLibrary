//
//  AudiomackArtistClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 06/11/2018.
//

import Foundation

public typealias GetArtistDetailsCompletionHandler = (_ response: Result<AudiomackUser>) -> Void
public typealias GetArtistUploadsCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void
public typealias GetArtistFavoritesCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void
public typealias GetArtistPlaylistsCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void
public typealias GetArtistFollowingCompletionHandler = (_ response: Result<[AudiomackUser]>) -> Void
public typealias GetArtistFollowersCompletionHandler = (_ response: Result<[AudiomackUser]>) -> Void
public typealias GetArtistFeedCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void


struct ArtistParameter {
	var slug: String
}


public enum AudioFilter : String {
	case all = "all"
	case music = "music"
	case song = "song"
	case album = "album"
	case playlist = "playlist"
}


protocol ArtistClientProtocol {
	func getArtistDetails(parameter: ArtistParameter, completionHandler: @escaping GetArtistDetailsCompletionHandler)
	func getArtistUploads(parameter: ArtistParameter, completionHandler: @escaping GetArtistUploadsCompletionHandler)
	func getArtistFavorites(parameter: ArtistParameter, filter: AudioFilter?, completionHandler: @escaping GetArtistFavoritesCompletionHandler)
	func getArtistPlaylists(parameter: ArtistParameter, genre: String?, completionHandler: @escaping GetArtistPlaylistsCompletionHandler)
	func searchArtistFavorites(parameter: ArtistParameter, searchText: String, completionHandler: @escaping GetArtistFavoritesCompletionHandler)
	func getArtistFollowing(parameter: ArtistParameter, completionHandler: @escaping GetArtistFollowingCompletionHandler)
	func getArtistFollowers(parameter: ArtistParameter, completionHandler: @escaping GetArtistFollowersCompletionHandler)
	func getArtistFeed(parameter: ArtistParameter, completionHandler: @escaping GetArtistFeedCompletionHandler)
}

class ArtistClientImplementation: ArtistClientProtocol {
	func getArtistFollowing(parameter: ArtistParameter, completionHandler: @escaping GetArtistFollowingCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))/following", success: { (response) in
			let result_ = try! AudiomackUsersResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getArtistFollowers(parameter: ArtistParameter, completionHandler: @escaping GetArtistFollowersCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))/follows", success: { (response) in
			let result_ = try! AudiomackUsersResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getArtistFeed(parameter: ArtistParameter, completionHandler: @escaping GetArtistFeedCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))/feed", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getArtistPlaylists(parameter: ArtistParameter, genre: String?, completionHandler: @escaping GetArtistPlaylistsCompletionHandler) {
		var musicGenre = ""
		if(genre != nil){
			musicGenre = genre!
		}
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))/playlists?genre=\(musicGenre)", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func searchArtistFavorites(parameter: ArtistParameter, searchText: String, completionHandler: @escaping GetArtistFavoritesCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))/favorites/search?q=\(searchText)", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getArtistFavorites(parameter: ArtistParameter, filter: AudioFilter?, completionHandler: @escaping GetArtistFavoritesCompletionHandler) {
		var audiofilter = AudioFilter.all
		if(filter != nil){
			audiofilter = filter!
		}
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))/favorites?show=\(audiofilter)", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getArtistFavorites(parameter: ArtistParameter, completionHandler: @escaping GetArtistFavoritesCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))/favorites", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getArtistUploads(parameter: ArtistParameter, completionHandler: @escaping GetArtistUploadsCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))/uploads", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	func getArtistDetails(parameter: ArtistParameter, completionHandler: @escaping GetArtistDetailsCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/artist/\(parameter.slug.trimmingCharacters(in: .whitespaces))", success: { (response) in
			let result_ = try! AudiomackUserResponse(data: response.data)
			completionHandler(.success(result_.result))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	let authClient: AuthenticationClientImplementation
	
	init(authClient: AuthenticationClientImplementation) {
		self.authClient = authClient
	}
	
}

