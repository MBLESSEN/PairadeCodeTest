//
//  Router.swift
//  CodeTest
//
//  Created by max blessen on 4/20/16.
//  Copyright © 2016 IdeaHouse LLC. All rights reserved.
//

import Foundation
import SwiftyJSON

@objc class Router:NSObject {

    var gifArray = NSMutableArray()
    
    @objc func getGifs(numberOfGifs: Int, completion: (NSArray?,NSError?) -> Void) {
        let g = Giphy(apiKey: Giphy.PublicBetaAPIKey)

        g.search("funny", limit: UInt(numberOfGifs), offset: nil, rating: nil, completionHandler: { gifs, pagination, error in
            for var i = 0; i < numberOfGifs; i += 1 {
                let gif = JSON(gifs![i].json)
                let url = gif["images"]["original_still"]["url"].stringValue
                let gifUrl = gif["images"]["original"]["url"].stringValue
                let data = NSData(contentsOfURL: NSURL(string: url)!)
                let newMedia = media.newMedia(data, withGif: gifUrl)
                self.gifArray.addObject(newMedia)
            }
            completion(self.gifArray, nil)
            
        })
        
//        g.random("cute", rating: nil, completionHandler: { gif, error in
//            let gif = gif!.gifMetadataForType(.Original, still: false)
//            let gifURL = gif.URL
//            self.gifArray.addObject(gifURL)
//            completion(self.gifArray, nil)
//        })
    }
    
}