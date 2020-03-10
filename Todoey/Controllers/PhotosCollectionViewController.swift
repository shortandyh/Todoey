//
//  PhotosCollectionViewController.swift
//  Todoey
//
//  Created by stone_1 on 12/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit
import RealmSwift
import Hero

private let reuseIdentifier = "photoCell"

class PhotosCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var infoView: UIView!
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var infoNameLabel: UILabel!
    
    var todoItems: Results<Item>?
    let realm = try! Realm()
    
//    let myCells = PhotoCell()
    
     var selectedCategory : Category? {
        didSet{
//            getPictures()
            loadItems()
            print(todoItems!)
        }
    }
    
    //    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")

        
        
        
        // Do any additional setup after loading the view.
//        loadItems()
        
//        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
//        _ = NSBatchDeleteRequest(fetchRequest: fetch)
//        getPictures()
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return todoItems?.count ?? 1
//        if let images = self.todoItems {
//            return images.count
//        }
//        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell {
//        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell {
    
//            return cell
            
            
            if let picture = todoItems?[indexPath.row] {
                    cell.savedPhotoView.image = picture.thumbnailImage()
                    cell.photoLabel.text = picture.title
                    cell.photoLabel.isHidden = true
                    cell.savedPhotoView.hero.id = picture.title
                
            }
            return cell
            
        }
        
        return UICollectionViewCell()

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = todoItems?[indexPath.row]
        {
        performSegue(withIdentifier: "toFullImage", sender: item)
//            collectionView.hero.modifiers = [.duration(0.8)]
        }
        
        
        
//  block for displaying subview
        
//        infoImage.image = item?.fullImage()
//        infoNameLabel.text = item?.title
//        infoView.center = view.center
//        
//        view.addSubview(infoView)
//        
//        infoView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//        
//        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: [], animations: {
//            self.collectionView?.alpha = 0.5
//            self.infoView.transform = .identity
//        })
//        
//        navigationController?.setNavigationBarHidden(true, animated: false)
        
        
        
        
        
        
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let item = sender as? Item {
            if let destinationVC = segue.destination as? ImageViewController {
                destinationVC.todoItems = item
            }

        }
        
    }
//
////        if let indexPath = collectionView?.indexPathsForSelectedItems {
////            if let picture = todoItems?[indexPath] {
////                destinationVC.fullImage.image = picture.thumbnailImage()
////                cell.photoLabel.text = picture.title
////                cell.photoLabel.isHidden = true
////            }
////            destinationVC.fullImage.image =
//////            print(destinationVC.selectedCategory?.name)
////        }
//    }

    
    
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
    
//    func saveItems() {
    
//        do {
//            try context.save()
//        } catch {
//            print("Error saving category \(error)")
//        }
//
//        collectionView?.reloadData()
//    }
    
    
    
    func getPictures() {
        if let realm = try? Realm() {
            todoItems = realm.objects(Item.self)
            collectionView?.reloadData()
        }
    }
    
    @IBAction func closeInfoPopup(_ sender: RoundButtonView) {
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.infoView.transform = CGAffineTransform.init(scaleX: 1.3, y:1.3)
            self.infoView.alpha = 0
            self.collectionView?.alpha = 1
            self.infoView.removeFromSuperview()
//            self.infoView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
//            self.infoView.transform = .identity
//            self.visualEffectedView.effect = nil
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self.infoView.alpha = 1

            }
            
        })
        

        
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
//            self.collectionView?.alpha = 1
//            self.infoView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)

    }
    
    
    
    
    
    
    
    
    func loadItems() {

        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
//        todoItems = selectedCategory?.items
//        .sorted(byKeyPath: "title", ascending: true)

//        self.collectionView?.reloadData()

//        if let indexPath = collectionView?.indexPathsForSelectedItems {
//            self.selectedCategory = itemArray[indexPath.]
//        }
//        let newPic = Item(context: self.context)
//        let image = capturedImageView.image
//        let data = UIImageJPEGRepresentation(image!, 1) as Data?
//        newPic.itemImage = data
//        newPic.title = projectName
//        newPic.parentCategory = self.selectedProject
//        //        newPic.parentProject = CameraSnappedVC.selectedProject
//        self.itemArray.append(newPic)


        collectionView?.reloadData()

    }
    
    
    
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
    
    
    
    
//}

// MARK: - Core Data
extension PhotosCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        collectionView?.reloadData()

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }

}

}


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
