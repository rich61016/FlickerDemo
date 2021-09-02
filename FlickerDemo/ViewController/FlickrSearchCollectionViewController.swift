

import UIKit
import Kingfisher




class FlickrSearchCollectionViewController: UICollectionViewController {

    var photos = [Photo]()
    
    var text:String!
    var qty:String!
    let refreshControl = UIRefreshControl()
    
    var rowCount = 0
    
    
    @objc  func fetchData() {
    
        if let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=e01d33b46cb13164b273fca2ed0031d4&text=\(text!)&per_page=\(qty!)&format=json&nojsoncallback=1") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let searchData = try? JSONDecoder().decode(SearchData.self, from: data) {

                    self.photos = searchData.photos.photo
                    
                    self.rowCount = self.photos.count
                     
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.refreshControl.endRefreshing()
                    }
                   
                }

            }

            task.resume()
        }
        }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.navigationItem.title = "搜尋結果 \(text!)"
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let screenWidth = UIScreen.main.bounds.size.width
        let itemSpace: CGFloat = 10
        let columnCount: CGFloat = 2
        let width = floor((screenWidth - itemSpace * (columnCount-1)) / columnCount)

        layout?.itemSize = CGSize(width: width-10, height: width + 80)
        layout?.estimatedItemSize = .zero
        layout?.minimumInteritemSpacing = itemSpace
        layout?.minimumLineSpacing = itemSpace
        fetchData()
        
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshControl.attributedTitle = NSAttributedString(string: " ", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(fetchData), for: UIControl.Event.valueChanged)
        collectionView.refreshControl = refreshControl
        collectionView.isPagingEnabled = true

    }

   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return rowCount
    }

  
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
    
        let photo = photos[indexPath.item]
        cell.titleLabel.text = photo.title
        cell.imageURL = photo.imageUrl
        cell.photoImageView.kf.setImage(with: photo.imageUrl)
       
       
        return cell
    }

    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
              let contentHeight = scrollView.contentSize.height

              if offsetY > contentHeight - scrollView.frame.size.height {
                rowCount += Int(qty)!
                photos += photos
                 self.collectionView.reloadData()
              }
    }
}

