//
//  AudiomackUser
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

struct AudiomackUser: InitializableWithData, InitializableWithJson {
	var id: String
	var name: String
	var url_slug: String
	var image: String
	var hometown: String
	var bio: String
	var twitter: String
	var facebook: String
	var instagram: String
	var label: String
	var url: String
	var genre: String
	var verified: String
	var updated: String
	var created: String
	var status: String
	var video_ads: String
	var follow_download: String
	var favorite_music: [String]
	var favorite_playlists: [String]
	var playlists: [String]
	var following: [String]
	
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
			let name = json["name"] as? String,
			let url_slug = json["url_slug"] as? String,
			let image = json["image"] as? String,
			let hometown = json["hometown"] as? String,
			let bio = json["bio"] as? String,
			let twitter = json["twitter"] as? String,
			let facebook = json["facebook"] as? String,
			let instagram = json["instagram"] as? String,
			let label = json["label"] as? String,
			let url = json["url"] as? String,
			let genre = json["genre"] as? String,
			let verified = json["verified"] as? String,
			let updated = json["updated"] as? String,
			let created = json["created"] as? String,
			let status = json["status"] as? String,
			let video_ads = json["video_ads"] as? String,
			let follow_download = json["follow_download"] as? String,
			let favorite_music = json["favorite_music"] as? [String],
			let favorite_playlists = json["favorite_playlists"] as? [String],
			let playlists = json["playlists"] as? [String],
			let following = json["following"] as? [String] else {
				
				throw NSError.createParseError()
		}
		
		
		self.id = id
		self.name = name
		self.url_slug = url_slug
		self.image = image
		self.hometown = hometown
		self.bio = bio
		self.twitter = twitter
		self.facebook = facebook
		self.instagram = instagram
		self.label = label
		self.url = url
		self.genre = genre
		self.verified = verified
		self.updated = updated
		self.created = created
		self.status = status
		self.video_ads = video_ads
		self.follow_download = follow_download
		self.favorite_music = favorite_music
		self.favorite_playlists = favorite_playlists
		self.playlists = playlists
		self.following = following
	}
}

