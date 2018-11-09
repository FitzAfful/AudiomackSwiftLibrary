//
//  AudiomackUser
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

struct AudiomackRegisteredUser: InitializableWithData, InitializableWithJson {
	var screen_name: String
	var url_slug: String
	
	
	init(data: Data?) throws {
		guard let data = data,
			let jsonObject = try? JSONSerialization.jsonObject(with: data),
			let json = jsonObject as? [String: Any] else {
				throw NSError.createParseError()
		}
		try self.init(json: json)
		
	}
	
	init(json: [String : Any]) throws {
		guard let screen_name =  json["screen_name"] as? String,
			let url_slug = json["url_slug"] as? String else {
				throw NSError.createParseError()
		}
		
		
		self.screen_name = screen_name
		self.url_slug = url_slug
	}
}

