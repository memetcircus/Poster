//
//  Post.swift
//  Poster
//
//  Created by Akif Acar on 21.04.2022.
//

import Foundation
import UIKit

//define Post fields
struct Post {
    
    //store the userName of whom the Post is created
    let senderUserName: String
    
    //store a post's text
    let body: String
    
    //store a post's image
    let postImage: UIImage
}
