//
//  PhotoRequest.swift
//  ProvaAPI
//
//  Created by Gennaro Cotarella on 27/10/21.
//

import Foundation

class PhotoRequest<Resource: APIResource> {
    let resource: Resource
    
    init(resource: Resource) {
        self.resource = resource
    }
}

extension PhotoRequest: NetworkRequest {
    func decode(_ data: Data) -> [Photo]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let photos = try? decoder.decode([Photo].self, from: data)
        return photos
    }
    
    func execute(withCompetion completion: @escaping ([Photo]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
    
    typealias ModelType = [Photo]
    
    
}
