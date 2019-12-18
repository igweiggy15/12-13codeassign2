//
//  CoverManager.swift
//  codingassign2
//
//  Created by Igwe Onumah on 12/17/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import Foundation
import UIKit
import CoreData

typealias CoverHandler = ([Cover]) -> Void

final class CoverManager {
    
    static let shared = CoverManager()
    

    private init()
    {
        
    }

    func getCover(completion: @escaping CoverHandler)
    {
        guard let qurl = URL(string: "https://jsonplaceholder.typicode.com/photos") else { completion([])
            return }
       
        var  cover = [Cover]()

        URLSession.shared.dataTask(with: qurl) { (dat, _, err) in
            DispatchQueue.main.async {
                if let _ = err{
                    completion([])
                    return
                }
            
                if let data = dat{
                    do{
                        let jsonResp = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                        
                  
                        for dict in jsonResp
                        {
                            guard let albumid = dict["albumId"] as? Int,
                            let title = dict["title"] as? String,
                            let track = dict["id"] as? Int,
                            let thumbnail = dict["thumbnailUrl"] as? String,
                            let url = dict["url"] as? String else { continue }
                            let cove = Cover(title: title, albumid: albumid, thumbnail: thumbnail, img: url, trackid: track)
                            
                            cover.append(cove)
                        }
                        
                        completion(cover)
                    }catch{
                        print("Error JSON: \(error.localizedDescription)")
                        completion([])
                        return
                    }

                }
            }
        }.resume()
    }
}
