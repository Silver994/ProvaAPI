//
//  DetailViewController.swift
//  ProvaAPI
//
//  Created by Gennaro Cotarella on 15/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    
    var post: Post!
    var photos: Photo!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Post n.\(post.id)"
        
        titleLabel.text = post.title
        idLabel.text = "\(post.id)"
        bodyLabel.text = post.body
        detailImageView.getImage(urlString: photos.url, indicator: nil)

        // Do any additional setup after loading the view.
    }
    
}

extension UIImageView {
    func getImage(urlString: String, indicator: UIActivityIndicatorView?) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print("Failed to fetch photos:", error)
                return
            }
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                self.image = image
                indicator?.stopAnimating()
                indicator?.isHidden = true
//                indicatorView.stopAnimating()
            }
        }.resume()
    }

}
