//
//  ArtistRequests.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 06/11/2018.
//

import Foundation


struct ArtistDetailsRequest: ApiRequest {
	let parameter: ArtistParameter
	var urlRequest: URLRequest {
		let url: URL! = URL(string: BASE_URL + "/artist/\(parameter.slug)")
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		request.httpMethod = "GET"
		return request
	}
}
