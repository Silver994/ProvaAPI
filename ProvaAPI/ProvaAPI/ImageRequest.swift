//
//  ImageRequest.swift
//  ProvaAPI
//
//  Created by Gennaro Cotarella on 27/10/21.
//

import Foundation
import UIKit

class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: NetworkRequest {
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
    func execute(withCompetion completion: @escaping (UIImage?) -> Void) {
        load(url, withCompletion: completion)
    }
}
