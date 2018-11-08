//
//  AudiomackMusic.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation


public struct AudiomackMusic: InitializableWithData, InitializableWithJson {
	
	var id: String
	var stream_only: String
	var url_slug: String
	var image: String
	var buy_link: String
	var title: String
	var producer: String
	var description: String
	var genre: String
	var type: String
	var streaming_url: String
	var streaming_url_timeout: Int
	var live: Int
	var updated: String
	var uploaded: String
	var isPrivate: String
	var time_ago: String
	var status: String
	var duration: String
	var artist: String
	var released: String
	var featuring: String
	var album: String
	var uploader: AudiomackUser
	var stats: AudiomackStat
	
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	init(json: [String : Any]) throws {
		guard let id =  json["id"] as? String,
			let title = json["title"] as? String,
			let description = json["description"] as? String,
			let buy_link = json["buy_link"] as? String,
			let stream_only = json["stream_only"] as? String,
			let url_slug = json["url_slug"] as? String,
			let image = json["image"] as? String,
			let duration = json["duration"] as? String,
			let producer = json["producer"] as? String,
			let genre = json["genre"] as? String,
			let type = json["type"] as? String,
			let streaming_url = json["streaming_url"] as? String,
			let streaming_url_timeout = json["streaming_url_timeout"] as? Int,
			let live = json["live"] as? Int,
			let uploaded = json["uploaded"] as? String,
			let updated = json["updated"] as? String,
			let time_ago = json["time_ago"] as? String,
			let status = json["status"] as? String,
			let artist = json["artist"] as? String,
			let isPrivate = json["private"] as? String,
			let released = json["released"] as? String,
			let featuring = json["featuring"] as? String,
			let album = json["album"] as? String else {
				
				throw NSError.createParseError()
		}
		
		if let uploader_ = json["uploader"] as? [String: Any]{
			self.uploader = try! AudiomackUser(json: uploader_)
		}else {
			throw NSError.createParseError()
		}
		
		if let stat_ = json["stats"] as? [String: Any]{
			self.stats = try! AudiomackStat(json: stat_)
		}else {
			throw NSError.createParseError()
		}
		
		self.id = id
		self.title = title
		self.url_slug = url_slug
		self.image = image
		self.description = description
		self.stream_only = stream_only
		self.url_slug = url_slug
		self.producer = producer
		self.type = type
		self.streaming_url = streaming_url
		self.buy_link = buy_link
		self.streaming_url_timeout = streaming_url_timeout
		self.genre = genre
		self.live = live
		self.uploaded = uploaded
		self.updated = updated
		self.status = status
		self.released = released
		self.featuring = featuring
		self.album = album
		self.time_ago = time_ago
		self.isPrivate = isPrivate
		self.artist = artist
		self.duration = duration
	}
}


public struct AudiomackMusicResponse: InitializableWithData, InitializableWithJson {
	var results: [AudiomackMusic] = []
	
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
		}else {
			throw NSError.createParseError()
		}
		
	}
}
