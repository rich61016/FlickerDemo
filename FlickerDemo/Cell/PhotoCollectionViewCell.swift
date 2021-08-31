

import UIKit
import CoreData

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var imageURL: URL!
    
    @IBOutlet weak var addFavoriteBtn: UIButton!
    
    
    @IBAction func addFavorite(_ sender: UIButton) {
       
        if self.isSelected {
            self.isSelected = false
            addFavoriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            delete(imageUrl: String(describing: imageURL!))
        }else {
            self.isSelected = true
            addFavoriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            add(title: titleLabel.text!, imageUrl: String(describing: imageURL!) )
        }
        
    }
    
    func add(title: String, imageUrl: String){
        
        let context = container.viewContext
        let favorite = FavoriteData(context: context)
        favorite.imageUrl = imageUrl
        favorite.title = title
           do {

               try context.save()

            print("儲存成功")

            }catch let error{

    print("context can't save!, Error:\(error)")

            }
            
    }
    
    func delete(imageUrl: String){
        let context = container.viewContext
        let request: NSFetchRequest<FavoriteData> = FavoriteData.fetchRequest()
        request.predicate = NSPredicate(format: "imageUrl = '\(imageUrl)'")
        do {
            let requests = try context.fetch(request)
            for request in requests {
                context.delete(request)
                print("刪除成功")
                }
        } catch {
            fatalError("\(error)")
        }
    
        
    }
    
}
