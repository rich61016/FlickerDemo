//
//  ViewController.swift
//  FlickerDemo
//
//  Created by YA on 2021/8/28.
//

import UIKit
import CoreData

let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
var container: NSPersistentContainer!

class ViewController: UIViewController {

    @IBOutlet weak var text: UITextField!
    
    @IBOutlet weak var qty: UITextField!
    
    @IBOutlet weak var search: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search.isEnabled = false;
        text.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        qty.addTarget(self, action:  #selector(textFieldDidChange(_:)),  for:.editingChanged )
        
        container = appDelegate.persistentContainer
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        if text.text == "" || qty.text == "" {
            search.isEnabled = false
        }else{
            search.backgroundColor = UIColor.blue
             search.isEnabled = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       

       let dvc = segue.destination as! MainTabbarViewController
        dvc.navtitle = text.text!
        let vc = dvc.viewControllers![0] as! FlickrSearchCollectionViewController
        vc.text = text.text!
        vc.qty = qty.text!
        
        
    }
    

}
