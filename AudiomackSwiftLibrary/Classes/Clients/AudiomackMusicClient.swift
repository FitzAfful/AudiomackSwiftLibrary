//
//  AudiomackMusicClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 09/11/2018.
//

import Foundation

public typealias GetMusicCompletionHandler = (_ response: Result<AudiomackMusic>) -> Void
public typealias GetMusicArrayCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void
public typealias MusicStreamCompletionHandler = (_ response: Result<String>) -> Void
public typealias FlagMusicCompletionHandler = (_ response: Result<EmptyResponse>) -> Void
public typealias TrackAdCompletionHandler = (_ response: Result<EmptyResponse>) -> Void
public typealias FavoriteMusicCompletionHandler = (_ response: Result<EmptyResponse>) -> Void
public typealias RepostMusicCompletionHandler = (_ response: Result<EmptyResponse>) -> Void

public enum GetMusicType : String {
	case song = "song"
	case album = "album"
}

struct PlayMusicParameter {
	var id : String
	var session : String?
	var album_id : String?
	var playlist_id : String?
	var hq : String?
	var key : String?
	
	init(id: String) {
		self.id = id
		self.session = String.init(describing: UUID().uuid)
		self.album_id = nil
		self.playlist_id = nil
		self.hq = nil
		self.key = nil
	}
	
	init(id: String, album_id: String) {
		self.id = id
		self.album_id = album_id
		self.session = nil
		self.playlist_id = nil
		self.hq = nil
		self.key = nil
	}
	
	init(id: String, playlist_id: String) {
		self.id = id
		self.playlist_id = playlist_id
		self.album_id = nil
		self.session = String.init(describing: UUID().uuid)
		self.hq = nil
		self.key = nil
	}
	
	init(id: String, session: String?, album_id: String?, playlist_id:String?, hq: String?, key: String?) {
		self.id = id
		self.session = session
		self.album_id = album_id
		self.playlist_id = playlist_id
		self.hq = hq
		self.key = key
	}
	
	func items()-> [String:String?]{
		var items : [String:String?] = [:]
		items["id"] = self.id
		items["session"] = self.session
		items["album_id"] = self.album_id
		items["playlist_id"] = self.playlist_id
		items["hq"] = self.hq
		items["key"] = self.key
		return items
	}
}

struct TrackAdParameter {
	var id : String
	var status : TrackAdStatus
	
	func items()-> [String:String]{
		var items : [String:String] = [:]
		items["id"] = self.id
		items["status"] = self.status.rawValue
		return items
	}
}

public enum TrackAdStatus : String {
	case requested = "requested"
	case loaded = "loaded"
	case started = "started"
	case skipped = "skipped"
	case completed = "completed"
	case error = "error"
}

protocol MusicClientProtocol {
	func getMusic(id: String, key:String?, completionHandler: @escaping GetMusicCompletionHandler)
	func getMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String, key:String?, completionHandler: @escaping GetMusicCompletionHandler)
	func getMostRecentMusic(completionHandler: @escaping GetMusicArrayCompletionHandler)
	func getGenreMostRecentMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler)
	func getTrendingMusic(completionHandler: @escaping GetMusicArrayCompletionHandler)
	func getGenreTrendingMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler)
	func playMusic(parameter: PlayMusicParameter, completionHandler: @escaping MusicStreamCompletionHandler)
	func flagUnplayableMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String, status:String, completionHandler: @escaping FlagMusicCompletionHandler)
	func trackAd(parameter: TrackAdParameter, completionHandler: @escaping TrackAdCompletionHandler)
}

class MusicClientImplementation: MusicClientProtocol {
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
		let url = BASE_URL + "music/\(genre)/trending"
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


