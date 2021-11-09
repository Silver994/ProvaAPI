//
//  Struct.swift
//  ProvaAPI
//
//  Created by Gennaro Cotarella on 24/09/21.
//

import Foundation
import UIKit

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct Comment: Codable {
    let postId: String
    let id: String
    let name: String
    let email: String
    let body: String
}

struct Photo: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

struct PostResource: APIResource {
    typealias ModelType = Post
    
    var methodPath: String {
        return "/posts"
    }
    
    var filter: String?
}

struct PhotoResource: APIResource {
    typealias ModelType = Photo
    
    var methodPath: String {
        return "/photos"
    }
    
    var filter: String?
}

struct CommentResource: APIResource {
    typealias ModelType = Comment
    
    var methodPath: String {
        return "/comments"
    }
    
    var filter: String?
}

struct Resource<T> {
    let url: URL
}
