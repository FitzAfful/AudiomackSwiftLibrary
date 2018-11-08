//
//  AudiomackSearchResponse.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation


public struct AudiomackSearchResponse: InitializableWithData, InitializableWithJson {
	var songs: [AudiomackMusic] = []
	var artists: [AudiomackUser] = []
	var albums: [AudiomackMusic] = []
	var playlists: [AudiomackMusic] = []
	var verified_artists: [AudiomackUser] = []
	
	var song_count: String
	var album_count: String
	var artist_count: String
	var playlist_count: String
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	
	
	init(json: [String : Any]) throws {
		
		guard let song_count = json["song_count"] as? String,
			let album_count = json["album_count"] as? String,
			let artist_count = json["artist_count"] as? String,
			let playlist_count = json["playlist_count"] as? String else {
				throw NSError.createParseError()
		}
		
		if let verified = json["verified_artist"] as? [String:Any]{
			let artist = try AudiomackUser(json: verified)
			verified_artists.append(artist)
			if artists.filter({ $0.id == artist.id }).first != nil {
			} else {
				artists.append(artist)
			}
		}
		
		if let results_: NSArray = json["results"] as? NSArray{
			for item in results_ {
				let searchItem = item as? [String : Any]
				do {
					let audiomackMusicItem = try AudiomackMusic(json: searchItem!)
					if(audiomackMusicItem.type.contains("album")){
						albums.append(audiomackMusicItem)
					}else if(audiomackMusicItem.type.contains("song")){
						songs.append(audiomackMusicItem)
					}else if(audiomackMusicItem.type.contains("playlist")){
						playlists.append(audiomackMusicItem)
					}
				} catch {
					do {
						let audiomackUserItem = try AudiomackUser(json: searchItem!)
						if artists.filter({ $0.id == audiomackUserItem.id }).first != nil {
						} else {
							artists.append(audiomackUserItem)
						}
					} catch {
						throw NSError.createParseError()
					}
				}
			}
		}else {
			throw NSError.createParseError()
		}
		
		self.song_count = song_count
		self.album_count = album_count
		self.artist_count = artist_count
		self.playlist_count = playlist_count
	}
}
