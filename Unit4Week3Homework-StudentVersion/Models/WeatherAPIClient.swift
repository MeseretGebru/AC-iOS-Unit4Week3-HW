//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
struct WeatherAPIClient {
    private init() {}
    static let manager = WeatherAPIClient()
    private let key = "ZipCode"
    private let defaults = UserDefaults.standard
    
    func saveZipcode(_ zipcode: String){
        defaults.set(zipcode,forKey: key)
    }
    func getZipcode() -> String {
        if let zipcode = defaults.value(forKey: key) as? String {
            return zipcode
        }
        return "N/A"
    }
    
    func getWeather(from str: String,
                  completionHandler: @escaping ([Weather]) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        let accessId = "huRgH6wGT9gKzHPt8POHa"
        let secretKey = "5R6IhxhcTZLX36oO0iYTAMXRUULmXs6ps8Aft3BW"
        let urlStr = str + "client_id=\(accessId)&client_secret=\(secretKey)"
        guard let url = URL(string: urlStr) else {return}
        let parseDataIntoImageArr = {(data: Data) in
            do {
                let onlineWeather = try JSONDecoder().decode(WeatherAllInfo.self, from: data)
                if let result = onlineWeather.response.first {
                    completionHandler(result.periods)
                }
            }
            catch let error {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: parseDataIntoImageArr, errorHandler: errorHandler)
    }
    
    func getImage(from urlStr: String,
                  completionHandler: @escaping (UIImage) -> Void,
                  errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {
            errorHandler(AppError.badURL)
            return
        }
        let completion: (Data) -> Void = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {
                errorHandler(AppError.notAnImage)
                return
            }
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: url,
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
    
    func getImagefromPixbay(from str: String,
                    completionHandler: @escaping (Pictures) -> Void,
                    errorHandler: @escaping (Error) -> Void) {

        let key = "7289999-27d8716686d599947ed35246c"
        let urlStr = str + "&key=\(key)"
        guard let url = URL(string: urlStr) else {return}
        let parseDataIntoImageArr = {(data: Data) in
            do {
                let onlinePictures = try JSONDecoder().decode(AllPictures.self, from: data)
                if let result = onlinePictures.hits.first {
                    completionHandler(result)
                }
            }
            catch let error {
                errorHandler(AppError.couldNotParseJSON(rawError: error))
            }
        }
        NetworkHelper.manager.performDataTask(with: url, completionHandler: parseDataIntoImageArr, errorHandler: errorHandler)
    }
}




