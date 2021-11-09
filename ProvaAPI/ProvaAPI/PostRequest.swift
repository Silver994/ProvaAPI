//
//  PostRequest.swift
//  ProvaAPI
//
//  Created by Gennaro Cotarella on 14/10/21.
//

import Foundation
import UIKit

class PostRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension PostRequest: NetworkRequest {
    func decode(_ data: Data) -> [Post]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let posts = try? decoder.decode([Post].self, from: data)
        return posts
    }
    
    func execute(withCompetion completion: @escaping ([Post]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
    
    typealias ModelType = [Post]
    
    
}

protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var filter: String? { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://jsonplaceholder.typicode.com")!
        components.path = methodPath
//        components.queryItems = [
//        URLQueryItem(name: "site", value: "stackoverflow"),
//        URLQueryItem(name: "order", value: "desc"),
//        URLQueryItem(name: "sort", value: "votes"),
//        URLQueryItem(name: "tagged", value: "swiftui"),
//        URLQueryItem(name: "pagesize", value: "10")
//        ]
//
        if let filter = filter {
            components.queryItems?.append(URLQueryItem(name: "filter", value: filter))
        }
        
        return components.url!
    }
}



//    func load(_ url: URL, withCompletion completion: @escaping (Post?) -> Void) {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) -> Void in
//            guard let data = data, let value = self?.decode(data) else {
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                print("Error Decode")
//                return
//            }
//            DispatchQueue.main.async {
//                completion(value)
//            }
//        }
//        task.resume()
//    }
//
//    func decode(_ data: Data) -> Post? {
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .secondsSince1970
//        let wrapper = try? decoder.decode(Post.self, from: data)
//        print(wrapper)
//        return wrapper
//    }
    
    
    // MARK: Load an array of Posts
//    func loadPost(withCompletion completion: @escaping ([Post]?) -> Void) {
//        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
//        let task = URLSession.shared.dataTask(with: url) { (data, _, _) -> Void in
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                print("Error decode")
//                return
//            }
//            let postList = try? JSONDecoder().decode([Post].self, from: data)
//            DispatchQueue.main.async {
//                completion(postList)
//            }
//        }
//        task.resume()
//    }
    
    
//    func load<T>(url: URL, withCompletion completion: @escaping (T?) -> Void) {
//        let task = URLSession.shared.dataTask(with: url) { (data, _, _) -> Void in
//            guard let data = data else {
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//                print("Error decode")
//                return
//            }
//            switch T.self {
//            case is String.Type:
//                DispatchQueue.main.async {
//                    completion(String(data: data, encoding: .utf8) as? T)
//                }
//            case is Post.Type:
//                let post = try? JSONDecoder().decode(Post.self, from: data)
//                DispatchQueue.main.async {
//                    completion(post as? T)
//                }
//            case is [Post].Type:
//                let post = try? JSONDecoder().decode([Post].self, from: data)
//                DispatchQueue.main.async {
//                    completion(post as? T)
//                }
//            case is [Photo].Type:
//                let photo = try? JSONDecoder().decode([Photo].self, from: data)
//                DispatchQueue.main.async {
//                    completion(photo as? T)
//                }
//            default: break
//            }
//        }
//        task.resume()
//    }
    
    //Per le immagini, dopo aver scaricato il JSON, va fatta un'ulteriore chiamata per scaricare l'immagine
    
//    func fetchImages(completion: @escaping (Result<[Photo], Error>) -> ()) {
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Failed to fetch photos:", error)
//                return
//            }
//
//            guard let data = data else { return }
//
//            do {
//                let photos = try JSONDecoder().decode([Photo].self, from: data)
//                completion(.success(photos))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
