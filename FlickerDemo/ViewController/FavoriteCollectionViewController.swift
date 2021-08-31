//
//  FavoriteCollectionViewController.swift
//  FlickerDemo
//
//  Created by YA on 2021/8/30.
//

import UIKit
import CoreData


class FavoriteCollectionViewController: UICollectionViewController {
    
    var favorite = [FavoriteData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let screenWidth = UIScreen.main.bounds.size.width
        let itemSpace: CGFloat = 10
        let columnCount: CGFloat = 2
        let width = floor((screenWidth - itemSpace * (columnCount-1)) / columnCount)

        layout?.itemSize = CGSize(width: width-10, height: width + 80)
        layout?.estimatedItemSize = .zero
        layout?.minimumInteritemSpacing = itemSpace
        layout?.minimumLineSpacing = itemSpace
    }

    override func viewWillAppear(_ animated: Bool) {
        readResults()
    }

    func readResults(){
        let context = container.viewContext
        let request: NSFetchRequest<FavoriteData> = FavoriteData.fetchRequest()
        do {
            favorite = try context.fetch(request)
            DispatchQueue.main.async {
                self.collectionView.reloadData()

            }
        } catch {
            
        }
        
        
       
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return favorite.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
    
        let photo = favorite[indexPath.item]
        cell.titleLabel.text = photo.title
        cell.photoImageView.kf.setImage(with: URL(string: photo.imageUrl!))
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
