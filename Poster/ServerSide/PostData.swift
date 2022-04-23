//
//  PostData.swift
//  Poster
//
//  Created by Akif Acar on 23.04.2022.
//

import Foundation

//singleton class used to store Posts
class PostData {
    
    //store the shared Instance of the singleton
    static let sharedInstance = PostData()
    
    //store the posts
    var posts: [Post] = [Post]()
}
