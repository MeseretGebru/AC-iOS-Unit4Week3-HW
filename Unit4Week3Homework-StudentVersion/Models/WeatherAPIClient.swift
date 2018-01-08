//
//  WeatherAPIClient.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/8/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
//struct WeatherAPIClient {
//    private init() {}
//    static let manager = WeatherAPIClient()
//    private let key = "Settings"
//    private let defaults = UserDefaults.standard
//    
//    func setSetting(_ catIndex: Int){
//        defaults.set(catIndex,forKey: key)
//    }
//    func getSetting() -> Int? {
//        if let catIndex = defaults.value(forKey: key) as? Int {
//            return catIndex
//        }
//        return nil
//    }
//    
//    func getBooks(from str: String,
//                  completionHandler: @escaping ([Book]) -> Void,
//                  errorHandler: @escaping (Error) -> Void) {
//        let APIKey = "9a1042e2af724b02ac4d47f74426442a"
//        let urlStr = str + APIKey
//        guard let url = URL(string: urlStr) else {return}
//        let parseDataIntoImageArr = {(data: Data) in
//            do {
//                let onlineBooks = try JSONDecoder().decode(AllInfo.self, from: data)
//                if let result = onlineBooks.results {
//                    completionHandler(result)
//                } else if let result = onlineBooks.items {
//                    completionHandler(result)
//                }
//            }
//            catch let error {
//                errorHandler(AppError.couldNotParseJSON(rawError: error))
//            }
//        }
//        NetworkHelper.manager.performDataTask(with: url, completionHandler: parseDataIntoImageArr, errorHandler: errorHandler)
//    }
//    
//    func getImage(from urlStr: String,
//                  completionHandler: @escaping (UIImage) -> Void,
//                  errorHandler: @escaping (Error) -> Void) {
//        guard let url = URL(string: urlStr) else {
//            errorHandler(AppError.badURL)
//            return
//        }
//        let completion: (Data) -> Void = {(data: Data) in
//            guard let onlineImage = UIImage(data: data) else {
//                errorHandler(AppError.notAnImage)
//                return
//            }
//            completionHandler(onlineImage)
//        }
//        NetworkHelper.manager.performDataTask(with: url,
//                                              completionHandler: completion,
//                                              errorHandler: errorHandler)
//    }
//}

