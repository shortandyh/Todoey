//
//  PhotosCollectionViewController.swift
//  Todoey
//
//  Created by stone_1 on 12/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "PhotosCell"

class PhotosCollectionViewController: UICollectionViewController {
    
    
    
    var itemArray = [Item]()
    let realm = try! Realm()
    
//    let myCells = PhotoCell()
    
    public var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
    


    
    
    //    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")

        // Do any additional setup after loading the view.
//        loadItems()
        
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        _ = NSBatchDeleteRequest(fetchRequest: fetch)
        
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return itemArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotoCell {
    
        let polaroid = itemArray[indexPath.row]
            cell.updateViews(item: polaroid)
            return cell
            
        }
        
        return UICollectionViewCell()
        
        // Configure the cell
//        let imageFromIndex = itemArray[indexPath.row].itemImage
//        let titleForIndex = itemArray[indexPath.row].title
//        let image: UIImage = UIImage(data: imageFromIndex! as Data)!
//        cell.savedPhotoView.image = image
//        cell.photoLabel.text = titleForIndex
        
        
//        let image = UIImageJPEGRepresentation(imageFromIndex!, 1) as Data!
//        let imageView = UIImageView(image: image)
//        cell.addSubview(imageView)
        
//        working
//        let item = itemArray[indexPath.row]
//            cell.updateViews(item: item)
        
        
        
//        let image: UIImage = UIImage(data: item.itemImage! as Data)!
//        myCells.savedPhotoView.image = image
//        myCells.photoLabel.text = item.title
    
    
//        return cell
            
//        }
        
//        return UICollectionViewCell()
    
    }

    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //        let newItem = Item()
//        //        newItem.title = "Find Mike"
//        //        itemArray.append(newItem)
//        //
//        //        let newItem2 = Item()
//        //        newItem2.title = "Buy Eggos"
//        //        itemArray.append(newItem2)
//        //
//        //        let newItem3 = Item()
//        //        newItem3.title = "Destroy Demogorgan"
//        //        itemArray.append(newItem3)
//
//
//
//
//        //        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
//        //            itemArray = items
//        //        }
//
//    }
    
    func saveItems() {
        
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        collectionView?.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //MARK: - Core Data
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//
//        if let additionalPredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate!])
////
////                request.predicate = compoundPredicate
//
//
//        do{
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error loading categories \(error)")
//        }
//
//        print(itemArray)
//
////        self.collectionView?.reloadData()
//
////        if let indexPath = collectionView?.indexPathsForSelectedItems {
////            self.selectedCategory = itemArray[indexPath.]
////        }
////        let newPic = Item(context: self.context)
////        let image = capturedImageView.image
////        let data = UIImageJPEGRepresentation(image!, 1) as Data?
////        newPic.itemImage = data
////        newPic.title = projectName
////        newPic.parentCategory = self.selectedProject
////        //        newPic.parentProject = CameraSnappedVC.selectedProject
////        self.itemArray.append(newPic)
//
//
////        collectionView?.reloadData()
//
//    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
//
//
//        do{
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error loading categories \(error)")
//        }
//
//
//    }
    
    
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemArray.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
//
//        let item = itemArray[indexPath.row]
//        let image: UIImage = UIImage(data: item.itemImage! as Data)!
//        self.savedPhotoView.image = image
//        self.photoLabel.text = item.title
//        //cell.textLabel?.text = item.title
//
//        //cell.accessoryType = item.done ? .checkmark : .none
//
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //print(itemArray[indexPath.row])
//
//        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//
//        tableView.reloadData()
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
//    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
//        
//        var textField = UITextField()
//        
//        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
//        
//        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
//            
//            let newItem = Item(context: self.context)
//            newItem.title = textField.text!
//            //newItem.done = false
//            newItem.parentCategory = self.selectedCategory
//            self.itemArray.append(newItem)
//            
//            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
//            
//            self.tableView.reloadData()
//            
//        }
//        
//        alert.addTextField { (alertTextField) in
//            alertTextField.placeholder = "Create New Item"
//            textField = alertTextField
//            
//        }
//        
//        alert.addAction(action)
//        
//        present(alert, animated: true, completion: nil)
//    }
    
    
    
    
}

// MARK: - Core Data
//extension PhotosCollectionViewController: UISearchBarDelegate {
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//
//}
