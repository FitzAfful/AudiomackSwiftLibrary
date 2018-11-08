//
//  File.swift
//  AudiomackSwiftLibrary
//
//  Created by Fitzgerald Afful on 31/10/2018.
//

import Foundation

public class AudiomackClient {
	
	private let authClient: AuthenticationClientImplementation
	private let artistClient: ArtistClientImplementation
	private let chartClient: ChartClientImplementation
	
	public init(consumerKey: String, consumerSecret: String, oauthToken: String, oauthTokenSecret: String, oauthTokenVerifier: String?) {
		authClient = AuthenticationClientImplementation(apiClient: ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,completionHandlerQueue: OperationQueue.main), oauthSignatureGenerator: OAuth1Swift(consumerKey: consumerKey, consumerSecret: consumerSecret))
		artistClient = ArtistClientImplementation(authClient: authClient)
		chartClient = ChartClientImplementation(authClient: authClient)
	}
	
	public func registerUser(email: String, name: String, password: String, password2: String, completionHandler: @escaping RegisterUserCompletionHandler) {
		let parameter = RegisterUserParameter(email: email, artist_name: name, password: password, password2: password2)
		authClient.registerUser(parameter: parameter) { (result) in
			completionHandler(result)
		}
	}
	
	public func getArtistDetails(slug: String, completionHandler: @escaping GetArtistDetailsCompletionHandler) {
		artistClient.getArtistDetails(parameter: ArtistParameter(slug: slug)) { (result) in
			completionHandler(result)
		}
	}
	
	public func getArtistUploads(slug: String, completionHandler: @escaping GetArtistUploadsCompletionHandler) {
		artistClient.getArtistUploads(parameter: ArtistParameter(slug: slug)) { (result) in
			completionHandler(result)
		}
		
	}
	
	func getArtistFavorites(slug: String, filter: AudioFilter?, completionHandler: @escaping GetArtistFavoritesCompletionHandler){
		artistClient.getArtistFavorites(parameter: ArtistParameter(slug:slug), filter: filter) { (result) in
			completionHandler(result)
		}
	}
	
	func getArtistPlaylists(slug: String, genre: String?, completionHandler: @escaping GetArtistPlaylistsCompletionHandler){
		artistClient.getArtistPlaylists(parameter: ArtistParameter(slug:slug), genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
	func searchArtistFavorites(slug: String, searchText: String, completionHandler: @escaping GetArtistFavoritesCompletionHandler){
		artistClient.searchArtistFavorites(parameter: ArtistParameter(slug:slug), searchText: searchText) { (result) in
			completionHandler(result)
		}
	}
	
	func getArtistFollowing(slug: String, completionHandler: @escaping GetArtistFollowingCompletionHandler){
		artistClient.getArtistFollowing(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	
	func getArtistFollowers(slug: String, completionHandler: @escaping GetArtistFollowersCompletionHandler){
		artistClient.getArtistFollowers(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	
	func getArtistFeed(slug: String, completionHandler: @escaping GetArtistFeedCompletionHandler){
		artistClient.getArtistFeed(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	
	//CHARTS
	func getChart(musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler) {
		chartClient.getChart(musicType: musicType, chartType: chartType) { (result) in
			completionHandler(result)
		}
	}
	
	func getGenreChart(genre: String, musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetGenreChartCompletionHandler) {
		chartClient.getGenreChart(genre: genre, musicType: musicType, chartType: chartType) { (result) in
			completionHandler(result)
		}
	}
}
