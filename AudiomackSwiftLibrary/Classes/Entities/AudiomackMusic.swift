//
//  AudiomackMusic.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation


public struct AudiomackMusic: InitializableWithData, InitializableWithJson {
	
	public var id: String = ""
	public var stream_only: String = ""
	public var url_slug: String = ""
	public var image: String = ""
	public var buy_link: String = ""
	public var title: String = ""
	public var producer: String = ""
	public var description: String = ""
	public var genre: String = ""
	public var type: String = ""
	public var streaming_url: String = ""
	public var streaming_url_timeout: Int = 0
	public var live: Int = 0
	public var updated: String = ""
	public var uploaded: String = ""
	public var isPrivate: String = ""
	public var time_ago: String = ""
	public var status: String = ""
	public var duration: String = ""
	public var artist: String = ""
	public var released: String = ""
	public var featuring: String = ""
	public var album: String = ""
	public var uploader: AudiomackUser
	public var stats: AudiomackStat?
	public var tracks: [AudiomackMusic]?
	
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	init(json: [String : Any]) throws {
		
		if (!(json["id"] != nil)) {
			if (!(json["song_id"] != nil)) {
				throw NSError.createParseError()
			}else{
				self.id = String.init(describing: json["song_id"]!)
			}
		}else{
			self.id = String.init(describing: json["id"]!)
		}
		
		if let title_ = json["title"] as? String{
			self.title = title_
		}
		
		if let buy_link_ = json["buy_link"] as? String{
			self.buy_link = buy_link_
		}
		
		if let description_ = json["description"] as? String{
			self.description = description_
		}
		
		if let stream_only_ = json["stream_only"] as? String{
			self.stream_only = stream_only_
		}
		
		if let url_slug_ = json["url_slug"] as? String{
			self.url_slug = url_slug_
		}
		
		if let image_ = json["image"] as? String{
			self.image = image_
		}
		
		if let duration_ = json["duration"] as? String{
			self.duration = duration_
		}
		
		if let producer_ = json["producer"] as? String{
			self.producer = producer_
		}
		
		if let genre_ = json["genre"] as? String{
			self.genre = genre_
		}
		
		if let type_ = json["type"] as? String{
			self.type = type_
		}
		
		if let streaming_url_ = json["streaming_url"] as? String {
			self.streaming_url = streaming_url_
		}
		
		if let streaming_url_timeout_ = json["streaming_url_timeout"] as? Int {
			self.streaming_url_timeout = streaming_url_timeout_
		}
		
		if let live_ = json["live"] as? Int {
			self.live = live_
		}
		
		if let uploaded_ = json["uploaded"] as? String{
			self.uploaded = uploaded_
		}
		
		if let updated_ = json["updated"] as? String{
			self.updated = updated_
		}
		
		if let time_ago_ = json["time_ago"] as? String{
			self.time_ago = time_ago_
		}
		
		if let status_ = json["status"] as? String{
			self.status = status_
		}
		
		if let artist_ = json["artist"] as? String{
			self.artist = artist_
		}
		
		if let private_ = json["private"] as? String{
			self.isPrivate = private_
		}
		
		if let released_ = json["released"] as? String{
			self.released = released_
		}
		
		if let featuring_ = json["featuring"] as? String{
			self.featuring = featuring_
		}
		
		if let album_ = json["album"] as? String{
			self.album = album_
		}
		
		if let uploader_ = json["uploader"] as? [String: Any]{
			self.uploader = try! AudiomackUser(json: uploader_)
		}else if let uploader_ = json["artist"] as? [String: Any]{
			self.uploader = try! AudiomackUser(json: uploader_)
		}else {
			throw NSError.createParseError()
		}
		
		if let stat_ = json["stats"] as? [String: Any]{
			self.stats = try! AudiomackStat(json: stat_)
		}
		
		if let tracks_ = json["tracks"] as? NSArray {
			
			
			var myTracks: [AudiomackMusic] = []
			for item_ in tracks_ {
				let item = item_ as! [String: Any]
				myTracks.append(try! AudiomackMusic(json: item, uploader_: self.uploader))
			}
		}
	}
	
	init(json: [String : Any], uploader_: AudiomackUser) throws {
		
		if (!(json["id"] != nil)) {
			if (!(json["song_id"] != nil)) {
				throw NSError.createParseError()
			}else{
				self.id = String.init(describing: json["song_id"]!)
			}
		}else{
			self.id = String.init(describing: json["id"]!)
		}
		
		if let title_ = json["title"] as? String{
			self.title = title_
		}
		
		if let buy_link_ = json["buy_link"] as? String{
			self.buy_link = buy_link_
		}
		
		if let description_ = json["description"] as? String{
			self.description = description_
		}
		
		if let stream_only_ = json["stream_only"] as? String{
			self.stream_only = stream_only_
		}
		
		if let url_slug_ = json["url_slug"] as? String{
			self.url_slug = url_slug_
		}
		
		if let image_ = json["image"] as? String{
			self.image = image_
		}
		
		if let duration_ = json["duration"] as? String{
			self.duration = duration_
		}
		
		if let producer_ = json["producer"] as? String{
			self.producer = producer_
		}
		
		if let genre_ = json["genre"] as? String{
			self.genre = genre_
		}
		
		if let type_ = json["type"] as? String{
			self.type = type_
		}
		
		if let streaming_url_ = json["streaming_url"] as? String {
			self.streaming_url = streaming_url_
		}
		
		if let streaming_url_timeout_ = json["streaming_url_timeout"] as? Int {
			self.streaming_url_timeout = streaming_url_timeout_
		}
		
		if let live_ = json["live"] as? Int {
			self.live = live_
		}
		
		if let uploaded_ = json["uploaded"] as? String{
			self.uploaded = uploaded_
		}
		
		if let updated_ = json["updated"] as? String{
			self.updated = updated_
		}
		
		if let time_ago_ = json["time_ago"] as? String{
			self.time_ago = time_ago_
		}
		
		if let status_ = json["status"] as? String{
			self.status = status_
		}
		
		if let artist_ = json["artist"] as? String{
			self.artist = artist_
		}
		
		if let private_ = json["private"] as? String{
			self.isPrivate = private_
		}
		
		if let released_ = json["released"] as? String{
			self.released = released_
		}
		
		if let featuring_ = json["featuring"] as? String{
			self.featuring = featuring_
		}
		
		if let album_ = json["album"] as? String{
			self.album = album_
		}
		
		if let uploader_ = json["uploader"] as? [String: Any]{
			self.uploader = try! AudiomackUser(json: uploader_)
		}else if let uploader_ = json["artist"] as? [String: Any]{
			self.uploader = try! AudiomackUser(json: uploader_)
		}else {
			self.uploader = uploader_
		}
		
		if let stat_ = json["stats"] as? [String: Any]{
			self.stats = try! AudiomackStat(json: stat_)
		}
		
		if let tracks_ = json["tracks"] as? NSArray {
			var myTracks: [AudiomackMusic] = []
			for item_ in tracks_ {
				let item = item_ as! [String: Any]
				myTracks.append(try! AudiomackMusic(json: item))
			}
		}
	}
}


public struct AudiomackMusicResponse: InitializableWithData, InitializableWithJson {
	public var results: [AudiomackMusic] = []
	
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
				let music = item as? [String : Any]
				let audiomackMusicItem = try AudiomackMusic(json: music!)
				results.append(audiomackMusicItem)
			}
		}else if let results_ = json["results"] as? [String : Any]{
			let audiomackMusicItem = try AudiomackMusic(json: results_)
			results.append(audiomackMusicItem)
		}else{
			throw NSError.createParseError()
		}
		
	}
}


public struct AudiomackSingleMusicResponse: InitializableWithData, InitializableWithJson {
	public var result: AudiomackMusic!
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	
	
	init(json: [String : Any]) throws {
		if let results_ = json["results"] as? [String : Any]{
			result = try AudiomackMusic(json: results_)
		} else{
			throw NSError.createParseError()
		}
		
	}
}
