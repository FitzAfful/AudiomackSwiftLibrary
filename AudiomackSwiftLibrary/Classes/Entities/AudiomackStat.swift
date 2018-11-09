//
//  AudiomackStat.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//


import Foundation


public struct AudiomackStat: InitializableWithData, InitializableWithJson {
	
	var pageviews: String
	var plays_raw: String
	var plays: String
	var downloads_raw: String
	var downloads: String
	var embedviews: String
	var track_dls: String
	var favorites_raw: String
	var favorites: String
	var reposts_raw: String
	var reposts: String
	var playlists_raw: String
	var playlists: String
	
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	init(json: [String : Any]) throws {
		print(json)
		self.pageviews = String.init(describing: json["pageviews"]!)
		self.plays_raw = String.init(describing: json["plays-raw"]!)
		self.plays = String.init(describing:  json["plays"]!)
		self.downloads_raw = String.init(describing:  json["downloads-raw"]!)
		self.downloads = String.init(describing:  json["downloads"]!)
		self.embedviews = String.init(describing:  json["embedviews"]!)
		self.track_dls = String.init(describing:  json["track_dls"]!)
		self.favorites_raw = String.init(describing:  json["favorites-raw"]!)
		self.favorites = String.init(describing: json["favorites"]!)
		self.reposts_raw = String.init(describing: json["reposts-raw"]!)
		self.reposts = String.init(describing: json["reposts"]!)
		self.playlists_raw = String.init(describing: json["playlists-raw"]!)
		self.playlists = String.init(describing: json["playlists"]!)
	
		
	}
}
