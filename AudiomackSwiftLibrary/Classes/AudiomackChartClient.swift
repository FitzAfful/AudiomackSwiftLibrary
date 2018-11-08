//
//  AudiomackChartClient.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 08/11/2018.
//

import Foundation

public typealias GetChartCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void
public typealias GetGenreChartCompletionHandler = (_ response: Result<[AudiomackMusic]>) -> Void

public enum ChartType : String {
	case total = "total"
	case daily = "daily"
	case weekly = "weekly"
	case monthly = "monthly"
	case yearly = "yearly"
}

public enum MusicType : String {
	case songs = "songs"
	case albums = "albums"
	case playlists = "playlists"
}


protocol ChartClientProtocol {
	func getChart(musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler)
	func getGenreChart(genre: String, musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetGenreChartCompletionHandler)
}

class ChartClientImplementation: ChartClientProtocol {
	func getChart(musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/chart/\(musicType)/\(chartType)", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	func getGenreChart(genre: String, musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetGenreChartCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "\(genre.trimmingCharacters(in: .whitespaces))/chart/\(musicType)/\(chartType)", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	
	let authClient: AuthenticationClientImplementation
	
	init(authClient: AuthenticationClientImplementation) {
		self.authClient = authClient
	}
	
}


