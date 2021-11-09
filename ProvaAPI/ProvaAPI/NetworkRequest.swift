//
//  NetworkRequest.swift
//  ProvaAPI
//
//  Created by Gennaro Cotarella on 24/09/21.
//
//
import Foundation
import UIKit
//
//protocol NetworkRequest: AnyObject {
//    associatedtype ModelType: Decodable
//    func decode(_ data: Data) -> ModelType?
//    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
//}
//
//extension NetworkRequest {
//    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
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
//}
//
//protocol APIResource {
//    associatedtype ModelType: Codable
//    var methodPath: String { get }
//    var filter: String? { get }
//}
//
//class APIRequest<Resource: APIResource> {
//    let resource: Resource
//
//    init(resource: Resource) {
//        self.resource = resource
//    }
//}
//
//extension APIRequest: NetworkRequest {
//
//    func decode(_ data: Data) -> [Resource.ModelType]? {
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = .secondsSince1970
//        let wrapper = try? decoder.decode([Resource.ModelType].self, from: data)
//        print(wrapper)
//        return wrapper
//    }
//
//    func execute(withCompletion completion: @escaping (Array<Resource.ModelType>?) -> Void) {
//        load(resource.url, withCompletion: completion)
//    }
//
//}
//
//extension APIResource {
//    var url: URL {
//        var components = URLComponents(string: "https://jsonplaceholder.typicode.com/posts")
//
//        return (components?.url)!
//    }
//}

protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompetion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequest {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) -> Void in
            guard let data = data, let value = self?.decode(data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(value)
            }
        }
        task.resume()
    }
}
