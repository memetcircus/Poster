//
//  UserData.swift
//  Poster
//
//  Created by Akif Acar on 21.04.2022.
//

import Foundation
import UIKit

struct UsersData {
    
    //to store three dummy users
    var users = [User(name: "John", userName: "@dragon",profileImageName:"dragon"),
                 User(name: "Ally", userName: "@kitty", profileImageName:"kitty"),
                 User(name: "Susan", userName: "@suzzy",profileImageName: "suzzy")]
    
    /**
    This method is used to get the User given userName
    - Parameter userName: 'String' the userName that is chosen from the dropdownMenu
    - Returns: 'User'
    */
    func getUser(userName: String) -> User {
        
        var desiredUser =  User(name: "", userName: "", profileImageName: "")
        
        for user in users {
            if user.userName == userName {
                desiredUser = user
            }
        }
        
        return desiredUser
        
    }
    
    /**
    This method is used to populate the dropdownmenu that is used to choose the user.
    - Returns: Array of 'String' that contain all the userNames
    */
    func getUserNames() -> [String] {
        
        var usernames = [String]()
        
        for user in users {
            usernames.append(user.userName)
        }
        
        return usernames
    }
    
}


        






