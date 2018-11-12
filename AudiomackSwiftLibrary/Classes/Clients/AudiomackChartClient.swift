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
	
	/** Get songs on chart
	
	For more info,  https://www.audiomack.com/data-api/docs#chart-tracks
	
	- Parameters:
	-  musicType: MusicType - songs, albums, playlists
	-  chartType: ChartType - total, daily, weekly, monthly, yearly
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	
	
	*/
	func getChart(musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/chart/\(musicType)/\(chartType)", success: { (response) in
			let result_ = try! AudiomackMusicResponse(data: response.data)
			completionHandler(.success(result_.results))
		}) { (error) in
			completionHandler(.failure(error))
		}
	}
	
	/** Get songs on chart by genre
	
	For more info,  https://www.audiomack.com/data-api/docs#charts-genre-specific
	
	- Parameters:
	-  genre: String - rap, electronic
	-  musicType: MusicType - songs, albums, playlists
	-  chartType: ChartType - total, daily, weekly, monthly, yearly
	-  genre: String -  eg. rap, electronic (optional)
	-  verified: Bool -  verified results only? (optional)
	-  page: Int -  for pagination only (optional)
	-  limit: Int -  by default, only 20 results are returned. Adjust to suit your use (optional)
	-  completionHandler: The completion handler to call when the load request is complete.
	`response` - A response object, or `nil` if the request failed.
	`error` - An error object that indicates why the request failed, or `nil` if the request was successful. On failed execution, `error` may contain an `AudiomackError` with `errorcode` and `message`
	
	- Returns: If successful, returns an array of AudiomackMusic objects
	*/
	func getGenreChart(genre: String, musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetGenreChartCompletionHandler) {
		_ = authClient.oauthGenerator.client.get(BASE_URL + "/\(genre.trimmingCharacters(in: .whitespaces))/chart/\(musicType)/\(chartType)", success: { (response) in
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


