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
	private let searchClient: SearchClientImplementation
	private let musicClient: MusicClientImplementation
	private let playlistClient: PlaylistClientImplementation
	
	public init(consumerKey: String, consumerSecret: String) {
		authClient = AuthenticationClientImplementation(apiClient: ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,completionHandlerQueue: OperationQueue.main), oauthSignatureGenerator: OAuth1Swift(consumerKey: consumerKey, consumerSecret: consumerSecret))
		artistClient = ArtistClientImplementation(authClient: authClient)
		chartClient = ChartClientImplementation(authClient: authClient)
		searchClient = SearchClientImplementation(authClient: authClient)
		musicClient = MusicClientImplementation(authClient: authClient)
		playlistClient = PlaylistClientImplementation(authClient: authClient)
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
	
	public func getArtistFavorites(slug: String, filter: AudioFilter?, completionHandler: @escaping GetArtistFavoritesCompletionHandler){
		artistClient.getArtistFavorites(parameter: ArtistParameter(slug:slug), filter: filter) { (result) in
			completionHandler(result)
		}
	}
	
	public func getArtistPlaylists(slug: String, genre: String?, completionHandler: @escaping GetArtistPlaylistsCompletionHandler){
		artistClient.getArtistPlaylists(parameter: ArtistParameter(slug:slug), genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
	public func searchArtistFavorites(slug: String, searchText: String, completionHandler: @escaping GetArtistFavoritesCompletionHandler){
		artistClient.searchArtistFavorites(parameter: ArtistParameter(slug:slug), searchText: searchText) { (result) in
			completionHandler(result)
		}
	}
	
	public func getArtistFollowing(slug: String, completionHandler: @escaping GetArtistFollowingCompletionHandler){
		artistClient.getArtistFollowing(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	
	public func getArtistFollowers(slug: String, completionHandler: @escaping GetArtistFollowersCompletionHandler){
		artistClient.getArtistFollowers(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	
	public func getArtistFeed(slug: String, completionHandler: @escaping GetArtistFeedCompletionHandler){
		artistClient.getArtistFeed(parameter: ArtistParameter(slug:slug)) { (result) in
			completionHandler(result)
		}
	}
	
	//CHARTS
	public func getChart(musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetChartCompletionHandler) {
		chartClient.getChart(musicType: musicType, chartType: chartType) { (result) in
			completionHandler(result)
		}
	}
	
	public func getGenreChart(genre: String, musicType: MusicType, chartType: ChartType, completionHandler: @escaping GetGenreChartCompletionHandler) {
		chartClient.getGenreChart(genre: genre, musicType: musicType, chartType: chartType) { (result) in
			completionHandler(result)
		}
	}
	
	//SEARCH
	public func search(searchText: String, resultType: SearchMusicType?, sortBy: SortType?, genre: String?, verified: Bool?, page: Int?, limit: Int?, completionHandler: @escaping SearchCompletionHandler){
		
		searchClient.search(searchText: searchText, resultType: resultType, sortBy: sortBy, genre: genre, verified: verified, page: page, limit: limit) { (result) in
			completionHandler(result)
		}
	}
	
	public func searchAutosuggest(searchText: String, completionHandler: @escaping SearchAutoSuggestCompletionHandler){
		searchClient.searchAutosuggest(searchText: searchText) { (result) in
			completionHandler(result)
		}
	}
	
	func getMusic(id: String, completionHandler: @escaping GetMusicCompletionHandler){
		musicClient.getMusic(id: id) { (result) in
			completionHandler(result)
		}
	}
	
	
	//MUSIC
	
	func getMusic(id: String, key:String?, completionHandler: @escaping GetMusicCompletionHandler){
		musicClient.getMusic(id: id, key: key) { (result) in
			completionHandler(result)
		}
	}
	
	func getMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String, key:String?, completionHandler: @escaping GetMusicCompletionHandler){
		musicClient.getMusic(musicSlug: musicSlug, musicType: musicType, artistSlug: artistSlug, key: key) { (result) in
			completionHandler(result)
		}
	}
	
	func getMostRecentMusic(completionHandler: @escaping GetMusicArrayCompletionHandler){
		self.musicClient.getMostRecentMusic { (result) in
			completionHandler(result)
		}
	}
	
	func getGenreMostRecentMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler){
		self.musicClient.getGenreMostRecentMusic(genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
	func getTrendingMusic(completionHandler: @escaping GetMusicArrayCompletionHandler){
		self.musicClient.getTrendingMusic { (result) in
			completionHandler(result)
		}
	}
	
	func getGenreTrendingMusic(genre: String, completionHandler: @escaping GetMusicArrayCompletionHandler){
		self.musicClient.getGenreTrendingMusic(genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
	func playMusic(parameter: PlayMusicParameter, completionHandler: @escaping MusicStreamCompletionHandler){
		self.musicClient.playMusic(parameter: parameter) { (result) in
			completionHandler(result)
		}
	}
	
	func flagUnplayableMusic(musicSlug: String, musicType: GetMusicType, artistSlug: String,  completionHandler: @escaping FlagMusicCompletionHandler){
		self.musicClient.flagUnplayableMusic(musicSlug: musicSlug, musicType: musicType, artistSlug: artistSlug) { (result) in
			completionHandler(result)
		}
	}
	
	func trackAd(parameter: TrackAdParameter, completionHandler: @escaping TrackAdCompletionHandler){
		self.musicClient.trackAd(parameter: parameter) { (result) in
			completionHandler(result)
		}
	}
	
	
	// PLAYLISTS
	
	func getPlaylistInfo(id: String, fields: [String], completionHandler: @escaping GetPlaylistDetailsCompletionHandler){
		self.playlistClient.getPlaylistInfo(id: id, fields: fields) { (result) in
			completionHandler(result)
		}
	}
	
	func getPlaylistInfo(playlistSlug: String, artistSlug: String, fields: [String], completionHandler: @escaping GetPlaylistDetailsCompletionHandler){
		self.playlistClient.getPlaylistInfo(playlistSlug: playlistSlug, artistSlug: artistSlug, fields: fields) { (result) in
			completionHandler(result)
		}
	}
	
	func getTrendingPlaylists(completionHandler: @escaping GetPlaylistArrayCompletionHandler){
		self.playlistClient.getTrendingPlaylists { (result) in
			completionHandler(result)
		}
	}
	
	func getGenreTrendingPlaylists(genre: String, completionHandler: @escaping GetPlaylistArrayCompletionHandler){
		self.playlistClient.getGenreTrendingPlaylists(genre: genre) { (result) in
			completionHandler(result)
		}
	}
	
}
