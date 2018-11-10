//
//  AudiomackPlaylistClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 09/11/2018.
//

import Foundation


public typealias GetPlaylistDetailsCompletionHandler = (_ response: Result<AudiomackMusic>) -> Void
public typealias GetPlaylistInfoCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void


protocol PlaylistClientProtocol {
	func getPlaylistInfo(id: String, key:String?, completionHandler: @escaping GetMusicCompletionHandler)
	func getPlaylistDetails(musicSlug: String, musicType: GetMusicType, artistSlug: String, key:String?, completionHandler: @escaping GetMusicCompletionHandler)
	func getMostRecentMusic(completionHandler: @escaping GetMusicArrayCompletionHandler)
	func getGenreMostRecentMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler)
	func getTrendingMusic(completionHandler: @escaping GetMusicArrayCompletionHandler)
	func getGenreTrendingMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler)
	func playMusic(parameter: PlayMusicParameter, completionHandler: @escaping MusicStreamCompletionHandler)
	func flagUnplayableMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String, status:String, completionHandler: @escaping FlagMusicCompletionHandler)
	func trackAd(parameter: TrackAdParameter, completionHandler: @escaping TrackAdCompletionHandler)
}

class PlaylistClientImplementation: MusicClientProtocol {
	func playMusic(parameter: PlayMusicParameter, completionHandler: @escaping MusicStreamCompletionHandler) {
		var parameters : [String:Any] = [:]
		for item in parameter.items(){
			if(item.value != nil){
				parameters[item.key] = item.value!
			}
		}
		_ = authClient.oauthGenerator.client.post(BASE_URL + "/music/\(parameter.id)/play", parameters: parameters, headers: nil, body: nil, success: { (response) in
			let result = String(decoding: response.data, as: UTF8.self)
			completionHandler(.success(result))
		}, failure: { (error) in
			completionHandler(.failure(error))
		})
	}
	
	func flagUnplayableMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String, status: String = "unplayable", completionHandler: @escaping FlagMusicCompletionHandler) {
		let url = BASE_URL + "/\(musicType.rawValue.trimmingCharacters(in: CharacterSet.whitespaces))/\(artistSlug.trimmingCharacters(in: CharacterSet.whitespaces))/\(musicSlug.trimmingCharacters(in: CharacterSet.whitespaces))"
		let parameters: [String: Any] = ["status":status]
		_ = authClient.oauthGenerator.client.patch(url, parameters: parameters, headers: nil, success: { (response) in
			let result = try! EmptyResponse(data: response.data)
			completionHandler(.success(result))
		}, failure: { (error) in
			completionHandler(.failure(error))
		})
	}
	
	func trackAd(parameter: TrackAdParameter, completionHandler: @escaping TrackAdCompletionHandler) {
		var parameters : [String:Any] = [:]
		for item in parameter.items(){
			parameters[item.key] = item.value
		}
		_ = authClient.oauthGenerator.client.post(BASE_URL + "/music/\(parameter.id)/ads", parameters: parameters, headers: nil, body: nil, success: { (response) in
			let result = try! EmptyResponse(data: response.data)
			completionHandler(.success(result))
		}, failure: { (error) in
			completionHandler(.failure(error))
		})
	}
	
	func getMostRecentMusic(completionHandler: @escaping GetMusicArrayCompletionHandler) {
		let url = BASE_URL + "/music/recent"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getGenreMostRecentMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler) {
		let url = BASE_URL + "music/\(genre)/recent"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getTrendingMusic(completionHandler: @escaping GetMusicArrayCompletionHandler) {
		let url = BASE_URL + "music/trending"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getGenreTrendingMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler) {
		let url = BASE_URL + "music/\(genre)/recent"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getMusic(id: String, key:String? = nil, completionHandler: @escaping GetMusicCompletionHandler) {
		var url = BASE_URL + "/music/\(id)"
		if key != nil {
			url.append("?key=\(key!)")
		}
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results.first!))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String, key: String?,  completionHandler: @escaping GetMusicCompletionHandler) {
		var url = BASE_URL + "/\(musicType.rawValue.trimmingCharacters(in: CharacterSet.whitespaces))/\(artistSlug.trimmingCharacters(in: CharacterSet.whitespaces))/\(musicSlug.trimmingCharacters(in: CharacterSet.whitespaces))"
		if key != nil {
			url.append("?key=\(key!)")
		}
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results.first!))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	private let authClient: AuthenticationClientImplementation
	
	init(authClient: AuthenticationClientImplementation) {
		self.authClient = authClient
	}
	
}


