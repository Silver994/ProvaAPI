//
//  ViewController.swift
//  ProvaAPI
//
//  Created by Gennaro Cotarella on 24/09/21.
//

import UIKit

protocol ViewControllerDelegate: class {
    func viewController(_ viewController: ViewController, stopAnimation: UIActivityIndicatorView)
}

class ViewController: UIViewController {
    
    private var postRequest: PostRequest<PostResource>?
    private var photoRequest: PhotoRequest<PhotoResource>?

    var postList = [Post]()
    var photoList = [Photo]()
    
//    weak var delegate: ViewControllerDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Posts"
        
        loadData()
//        PostRequest().load(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!) { (data: [Post]?) -> Void in
//            self.postList = data!
//            print(self.postList)
//        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! CustomTableViewCell
        
        cell.labelCell.text = postList[indexPath.row].title
        cell.indicatorViewImageCell.startAnimating()
        cell.imageViewCell.getImage(urlString: photoList[indexPath.row].url, indicator: cell.indicatorViewImageCell)
//        cell.config(with: postList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.delegate?.viewController(self, didTapOnPost: self.postList[indexPath.row])
//        let detailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        detailViewController.post = postList[indexPath.row]
//        self.present(detailViewController, animated: true)
//        self.navigationController?.pushViewController(detailViewController, animated: true)
                
//        let destinationVC = DetailViewController()
//        destinationVC.post = postToPass
//        destinationVC.bodyLabel.text = postToPass.body
        
        //Vado ad utilizzare il performSegue in quanto creo il ViewController via storyboard e quindi non avendo inizializzato i vari outlet all'interno del costruttore (viewDidLoad) del VC cui devo arrivare, li avrò tutti a nil. Mentre operando tramite il performSegue, le operazioni di istanza e riempimento degli outlet verrà fatto direttamente dal compilatore.
        
        performSegue(withIdentifier: "segueToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segueToDetail") {
            let indexPath = self.tableView.indexPathForSelectedRow!
            
            let tableViewDetail = segue.destination as? DetailViewController
            
            let selectedPost = postList[indexPath.row]
            let selectedPhoto = photoList[indexPath.row]
            
            tableViewDetail?.post = selectedPost
            tableViewDetail?.photos = selectedPhoto
            
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

extension ViewController {
    func loadData() {
        let postResourse = PostResource()
        let request = PostRequest(resource: postResourse)
        self.postRequest = request
        request.execute { posts in
            self.postList = posts!
        }
        
        let photoResource = PhotoResource()
        let request2 = PhotoRequest(resource: photoResource)
        self.photoRequest = request2
        request2.execute { photos in
            self.photoList = photos!
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
//        PostRequest().load(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!) { (data: [Post]?) -> Void in
//            self.postList = data!
//            self.tableView.reloadData()
//            print(self.postList)
//        }
//        PostRequest().load(url: URL(string: "https://jsonplaceholder.typicode.com/photos")!) { (data: [Photo]?) -> Void in
//            self.photoList = data!
//            print(self.photoList)
//            self.tableView.reloadData()
//        }
        
//        PostRequest().fetchImages { (results) in
//            switch results {
//            case.failure(let error):
//                print("Failed to fetch photos:", error)
//            case .success(let photos):
//                self.photoList = photos
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        }
    }
}

//extension ViewController: ViewControllerDelegate {
//    func viewController(_ viewController: ViewController, didTapOnPost post: Post) {
//        let detailViewController = DetailViewController()
//        detailViewController.bodyLabel.text = post.body
//        viewController.navigationController?.pushViewController(detailViewController, animated: true)
//    }
//}

//extension UIImageView {
//    func getImage(url: URL) {
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print("Failed to fetch photos:", error)
//                return
//            }
//            
//            guard let data = data else { return }
//            
//            let image = UIImage(data: data)
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }.resume()
//    }
//
//}
