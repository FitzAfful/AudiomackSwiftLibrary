//
//  AudiomackStat.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//


import Foundation


public struct AudiomackStat: InitializableWithData, InitializableWithJson {
	
	public var pageviews: String
	public var plays_raw: String
	public var plays: String
	public var downloads_raw: String
	public var downloads: String
	public var embedviews: String
	public var track_dls: String
	public var favorites_raw: String
	public var favorites: String
	public var reposts_raw: String
	public var reposts: String
	public var playlists_raw: String
	public var playlists: String
	
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	init(json: [String : Any]) throws {
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
