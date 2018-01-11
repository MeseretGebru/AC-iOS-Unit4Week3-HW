//
//  FileManagerHelper.swift
//  Unit4Week3Homework-StudentVersion
//
//  Created by C4Q on 1/11/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FileManagerHelper {
    private init() {}
    let FavoriteImagePath = "Favorite.plist"
    static let manager = FileManagerHelper()
    
    //Saving Images To Disk
    func saveImage(with urlStr: String, image: UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        let imagePathName = urlStr.components(separatedBy: "/").last!
        let url = dataFilePath(withPathName: imagePathName)
        do {
            try imageData?.write(to: url)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getImage(with urlStr: String) -> UIImage? {
        do {
            let imagePathName = urlStr.components(separatedBy: "/").last!
            let url = dataFilePath(withPathName: imagePathName)
            let data = try Data(contentsOf: url)
            return UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    private var pictureArr = [Favorite]() {
        didSet {

            removeDupes()
            saveImages()
        }
    }
    
    func removeDupes() {
        var imageURLSet = Set<String>()
        var noDupeArr = [Favorite]()
        for image in pictureArr {
            let (inserted, _) = imageURLSet.insert(image.pictureName!)
            if inserted {
                noDupeArr.append(image)
            }
        }
        if pictureArr.count != noDupeArr.count { pictureArr = noDupeArr }
    }
    
    func addNew(newPicture: Favorite) {
        pictureArr.append(newPicture)
    }
    
    func getAllPictures() -> [Favorite] {
        return pictureArr
    }
    
    private func saveImages() {
        let propertyListEncoder = PropertyListEncoder()
        do {
            let encodedData = try propertyListEncoder.encode(pictureArr)
            let imageURL = dataFilePath(withPathName: FavoriteImagePath)
            try encodedData.write(to: imageURL, options: .atomic)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func loadImages() {
        let propertyListDecoder = PropertyListDecoder()
        do {
            let imageURL = dataFilePath(withPathName: FavoriteImagePath)
            let encodedData = try Data(contentsOf: imageURL)
            let savedImages = try propertyListDecoder.decode([Favorite].self, from: encodedData)
            pictureArr = savedImages
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    //USE THIS ONE
    private func dataFilePath(withPathName path: String) -> URL {
        return FileManagerHelper.manager.documentsDirectory().appendingPathComponent(path)
    }
    
    //THIS IS ONLY FOR THE ABOVE METHOD
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
