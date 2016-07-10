//
//  TMDBConfig.swift
//  MovieViewer
//
//  Created by Dang Quoc Huy on 6/30/16.
//  Copyright © 2016 Dang Quoc Huy. All rights reserved.
//

import Foundation

enum PosterSize: String {
    
    case W92 = "w92", W154 = "w154", W185 = "w185", W342 = "w342", W500 = "w500", W780 = "w780", Original = "original"
}

struct TMDBClient {
    
    static let ApiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let BaseImageUrl = "http://image.tmdb.org/t/p/"
    static let MovieNowPlaying = "http://api.themoviedb.org/3/movie/now_playing?api_key=\(ApiKey)"
    static let MovieTopRated = "http://api.themoviedb.org/3/movie/top_rated?api_key=\(ApiKey)"
    
    // fetch movies from input url
    static func fetchMovies(urlString: String, page: Int?, language: String?, complete: ((movies: [Movie]?, error: NSError?) -> Void) ) {
        
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue())
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) in
            
            guard error == nil else {
                complete(movies: nil, error: error)
                return
            }
            
            if let data = data {
                do {
                    if let responseDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? NSDictionary {
                        var movies = [Movie]()
                        if let dictionaries = responseDictionary["results"] as? [NSDictionary] {
                            for dictionary in dictionaries {
                                movies.append(Movie(dictionary: dictionary))
                            }
                        }
                        complete(movies: movies, error: error)
                    }
                } catch let error as NSError {
                    
                    complete(movies: nil, error: error)
                }
            }
        }
        task.resume()
    }
}