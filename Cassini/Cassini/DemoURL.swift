//
//  URL.swift
//
//  Created by CS193p Instructor.
//  Copyright (c) 2017 Stanford University. All rights reserved.
//

import Foundation

struct DemoURL
{
    static let stanford = URL(string: "https://visit.stanford.edu/assets/cardinal/images/tours/freedom/freedom_canvas2.jpg") //"http://stanford.edu/about/images/intro_about.jpg")

    static var NASA: Dictionary<String,URL> = {
         let NASAURLStrings = [
            "Cassini" : "https://www.nasa.gov/sites/default/files/styles/full_width_feature/public/thumbnails/image/pia12567-1600.jpg",
            "Earth" : "https://www.nasa.gov/centers/goddard/images/content/638831main_globe_east_2048.jpg",
            "Saturn" : "https://www.nasa.gov/sites/default/files/thumbnails/image/stsci-h-p1943a-f-2076x1484.png"
        ]
        var urls = Dictionary<String,URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
