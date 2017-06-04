//
//  ThemeManager.swift
//  Feet
//
//  Created by 王振宇 on 7/18/16.
//  Copyright © 2016 王振宇. All rights reserved.
//

import Foundation

class ThemeManager: NSObject {
    static let shareInstance = ThemeManager()
    var themeImage = UIImage(named: "summmer")
    
    
    fileprivate override init() {
        
    }
    
    func getThemeImage() -> UIImage {
      return themeImage!
    }
    
    func themeImagesPath() -> [String]{
        let folderPath = documentPath + "/ThemeImages"
        let fileManager = FileManager.default
        var fileList: [String] = []
        do {
            let files = try fileManager.contentsOfDirectory(atPath: folderPath)
            for file in files {
                debugPrint("file ====== \(folderPath + "/" + file)")
                fileList.append("\(folderPath + "/" + file)")
            }
        } catch {
            debugPrint("文件读取失败")
        }
 
        return fileList
    }
    
    func changeThemeImage(_ imagePath: String) {
        themeImage = UIImage(contentsOfFile: imagePath)
    }
}
