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
public typealias FlagMusicCompletionHandler = (_ response: Result<VoidResponse>) -> Void
public typealias TrackAdCompletionHandler = (_ response: Result<VoidResponse>) -> Void
public typealias FavoriteMusicCompletionHandler = (_ response: Result<VoidResponse>) -> Void
public typealias RepostMusicCompletionHandler = (_ response: Result<VoidResponse>) -> Void




/**
`GetMusicType.song`
Returns only song results.

`GetMusicType.album`
Returns only Album results
*/
public enum GetMusicType : String {
	case song = "song"
	case album = "album"
}

/**
`PlayMusicParameter` - Parameter Object for API request that plays music.
Only required value is ID.

session - (optional) unique user session identifier
album_id - (optional) album that the track belongs to
playlist_id - (optional) playlists that the track belongs to
hq - (optional) retrieve the highest quality streaming source
key (optional) promotional key for private tracks

For more Info: https://www.audiomack.com/data-api/docs#endpoint-play-track
*/

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

/**
`TrackAdParameter` - Parameter Object for API request that tracks ad.
id - id of music
status - (required) one of the following: requested, loaded, started, skipped, completed, error - (AS SHOWN IN TrackAdStatus)

For more Info: https://www.audiomack.com/data-api/docs#endpoint-track-ad
*/

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

/**
Status required for TrackAdParameter - Should be one of the following: requested, loaded, started, skipped, completed, error -

For more Info: https://www.audiomack.com/data-api/docs#endpoint-track-ad
*/
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
	
	
	/** Play Music / Get Streaming URL for music
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-play-track
	
	- Parameters:
	-  parameter: PlayMusicParameter object containing ID, session, album_id, playlist_id, hq, key
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns A url to stream for Music item.
	*/
	
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
	
	
	/** Flag Music as unplayable
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-flagging
	
	- Parameters:
	-  musicSlug: Url slug of music
	-  musicType: Music Type - song, album
	-  artistSlug: URL slug of artist (owner of music)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: A void response with 204 http code.
	
	
	*/
	
	func flagUnplayableMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String, status: String = "unplayable", completionHandler: @escaping FlagMusicCompletionHandler) {
		let url = BASE_URL + "/\(musicType.rawValue.trimmingCharacters(in: CharacterSet.whitespaces))/\(artistSlug.trimmingCharacters(in: CharacterSet.whitespaces))/\(musicSlug.trimmingCharacters(in: CharacterSet.whitespaces))"
		let parameters: [String: Any] = ["status":status]
		_ = authClient.oauthGenerator.client.patch(url, parameters: parameters, headers: nil, success: { (response) in
			let result = try! VoidResponse(data: response.data)
			completionHandler(.success(result))
		}, failure: { (error) in
			completionHandler(.failure(error))
		})
	}
	
	
	/** Track Ad
	
	For more info,  https://www.audiomack.com/data-api/docs#endpoint-track-ad
	
	- Parameters:
	-  parameter: TrackAdParameter containing id and status
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, A void response with 204 http code
	*/
	func trackAd(parameter: TrackAdParameter, completionHandler: @escaping TrackAdCompletionHandler) {
		var parameters : [String:Any] = [:]
		for item in parameter.items(){
			parameters[item.key] = item.value
		}
		_ = authClient.oauthGenerator.client.post(BASE_URL + "/music/\(parameter.id)/ads", parameters: parameters, headers: nil, body: nil, success: { (response) in
			let result = try! VoidResponse(data: response.data)
			completionHandler(.success(result))
		}, failure: { (error) in
			completionHandler(.failure(error))
		})
	}
	
	
	/** Get most recent Music
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-most-recent
	
	- Parameters:
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	
	*/
	func getMostRecentMusic(completionHandler: @escaping GetMusicArrayCompletionHandler) {
		let url = BASE_URL + "/music/recent"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	/** Get most recent music by Genre
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-genre-most-recent
	
	- Parameters:
	-  genre: Music Genre ( eg. rap, electronic)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	
	
	*/
	func getGenreMostRecentMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler) {
		let url = BASE_URL + "music/\(genre)/recent"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	/** Get trending music
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-trending
	
	- Parameters:
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	
	
	*/
	func getTrendingMusic(completionHandler: @escaping GetMusicArrayCompletionHandler) {
		let url = BASE_URL + "music/trending"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	/** Get trending music by Genre
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-genre-trending
	
	- Parameters:
	-  genre: genre of music
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	
	
	*/
	func getGenreTrendingMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler) {
		let url = BASE_URL + "music/\(genre)/trending"
		_ = authClient.oauthGenerator.client.get(url, success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	/** Get Music Information
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-song-album-info
	
	- Parameters:
	-  id: Music Id
	-  key: (optional) promotional key for private tracks
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic object
	
	
	*/
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
	
	
	/** Search Audiomack for music, artists
	
	For more info,
	https://www.audiomack.com/data-api/docs#endpoint-song-album-info
	
	- Parameters:
	-  musicSlug: Url slug of music
	-  musicType: Music Type - song, album
	-  artistSlug: URL slug of artist (owner of music)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns AudiomackMusic object
	
	
	*/
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


