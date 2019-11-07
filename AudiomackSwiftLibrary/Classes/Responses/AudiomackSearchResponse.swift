//
//  AudiomackSearchResponse.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation


public struct AudiomackSearchResponse: InitializableWithData, InitializableWithJson {
	public var songs: [AudiomackMusic] = []
	public var artists: [AudiomackUser] = []
	public var albums: [AudiomackMusic] = []
	public var playlists: [AudiomackMusic] = []
	public var verified_artists: [AudiomackUser] = []
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	public init(songs:[AudiomackMusic], artists: [AudiomackUser], albums: [AudiomackMusic], playlists: [AudiomackMusic], verified_artists: [AudiomackUser]) {
		self.songs = songs
		self.albums = albums
		self.artists = artists
		self.playlists = playlists
		self.verified_artists = verified_artists
	}
	
	
	init(json: [String : Any]) throws {
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
		
	}
}

public struct AudiomackSearchAutoSuggestResponse: InitializableWithData, InitializableWithJson {
	var results: [String] = []
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	
	
	init(json: [String : Any]) throws {
		
		
		if let results_: NSArray = json["results"] as? NSArray{
			for item in results_ {
				let searchItem = item as! String
				results.append(searchItem)
			}
		}else {
			throw NSError.createParseError()
		}
		
	}
}
