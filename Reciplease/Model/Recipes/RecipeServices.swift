//
//  Recipe.swift
//  Reciplease
//
//  Created by Laurent Debeaujon on 04/11/2020.
//

import Foundation
import Alamofire

class RecipeService: Alamofire {
    static let shared = RecipeService()

    private let edamamUrl = URL(string: "https://api.edamam.com/search?")!

    private var session = URLSession(configuration: .default)

    private var task: [Location: URLSessionDataTask?] = [:]

    private var appKey = "app_key"
    private var appId = "app_id"

    init(recipeSession: URLSession = URLSession(configuration: .default),
         apiId: String = "app_id", appKey: String = "app_key" ) {
        self.session = recipeSession
        self.apiKey = apiKey
        super.init()
    }
/*
    ///Entry point for data importation  of weather module
    func getWeather(place: Location, callback: @escaping (Utilities.ManageError?, OpenWeather?) -> Void) {

        guard let keyOpenWeathermap = Utilities.getValueForAPIKey(named: apiKey )
            else {
                callback(Utilities.ManageError.apiKeyError, nil)
                return
        }

        let query = buildQueryItems(place: place, apiKey: keyOpenWeathermap)
        let request = createRequest(url: openWeathermapUrl, queryItems: query)

        if let currentTask = task[place] {
            // prevent two identical tasks
            currentTask?.cancel()
        }

        task[place] = session.dataTask(with: request) { [weak self] (data, response, error) in
            DispatchQueue.main.async {
                self?.carryOutData(
                    OpenWeather?.self,
                    data, response, error,
                    completionHandler: {(weather, errorCode) in
                        callback(errorCode, weather)
                })
            }
        }

        if let currentTask = task[place] {
            currentTask?.resume()
        }
    }

    /// adapt the query according to the type of localization ( town or coordonate )
    private func buildQueryItems(place: Location, apiKey: String) -> [URLQueryItem] {

        var query = [
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "lang", value: "fr"),
            URLQueryItem(name: "units", value: "metric")
        ]

        switch place {
        case .coord(let coordinatePlace):
            query.append(URLQueryItem(name: "lat", value: String(coordinatePlace.lat)))
            query.append(URLQueryItem(name: "lon", value: String(coordinatePlace.lon)))
        case .town( let townName, let countryName):
            query.append(URLQueryItem(name: "q", value: "\(townName),\(countryName)"))
        }
        return query
    }*/
}
