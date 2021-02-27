//
//  User.swift
//  Autolayout
//
//  Created by robot on 3/10/15.
//  Copyright (c) 2015 robot. All rights reserved.
//

import Foundation

struct User{
    let name: String;
    let company: String;
    let login: String;
    let password: String;
    
    static func login(login: String, password: String) -> User? {
        if let user = database[login] {
            if user.password == password {
                return user;
            }
        }
        return nil;
    }
    
    static let database: Dictionary<String, User> = {
        var theDatabase = Dictionary<String, User>();
        for user in [
        User(name: "John Appleseed", company: "Apple", login: "japple", password: "foo"),
        User(name: "Madison Bumgarner", company: "World Champion San Francisco Giants", login: "madbum", password: "foo"),
        User(name: "John Hennesy", company: "Stanford", login: "hennesy", password: "foo"),
        User(name: "Bad Guy", company: "Criminals, Inc.", login: "baddie", password: "foo")] {
            theDatabase[user.login] = user;
        }
        return theDatabase;
    }()
}
