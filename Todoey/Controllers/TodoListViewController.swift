////
////  ViewController.swift
////  Todoey
////
////  Created by stone_1 on 07/10/2018.
////  Copyright © 2018 stone1. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class TodoListViewController: UITableViewController {
//    
//    var itemArray = [Item]()
//    
//    var selectedCategory : Category? {
//        didSet{
//            loadItems()
//        }
//    }
//    
//    @IBOutlet weak var savedPhotoView: UIImageView!
//    @IBOutlet weak var photoLabel: UILabel!
//    
//    
////    let defaults = UserDefaults.standard
//
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
////        let newItem = Item()
////        newItem.title = "Find Mike"
////        itemArray.append(newItem)
////
////        let newItem2 = Item()
////        newItem2.title = "Buy Eggos"
////        itemArray.append(newItem2)
////
////        let newItem3 = Item()
////        newItem3.title = "Destroy Demogorgan"
////        itemArray.append(newItem3)
//        
//        
//
//        
////        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
////            itemArray = items
////        }
//
//    }
//    
//    func saveItems() {
//        
//        do {
//            try context.save()
//        } catch {
//            print("Error saving category \(error)")
//        }
//        
//        tableView.reloadData()
//    }
//    
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
////        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
////
////        request.predicate = compoundPredicate
//
//        
//        do{
//            itemArray = try context.fetch(request)
//        } catch {
//            print("Error loading categories \(error)")
//        }
//        
//        
//        
//        
//    }
//    
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
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //print(itemArray[indexPath.row])
//        
//        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//        
//        tableView.reloadData()
//        
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
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
//    
//
//    
//
//}
//
//extension TodoListViewController: UISearchBarDelegate {
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
//




// Spare code

//        let image = self.captureImageView.image
//        let data = UIImageJPEGRepresentation(image!, 1) as NSData?

//        let image = UIImage(data: photoData!)
//        let data = UIImageJPEGRepresentation(image!, 1) as Data?


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

//self.saveImage()

//        do {
//            try context.save()
//        } catch {
//            print("Error saving project \(error)")
//        }


//
//fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)

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


//        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
//        cell.textLabel?.text = project[indexPath.row].name


//        { (success: Bool) in
//            //self.captureImageView.removeFromSuperview()
//
//        }


//                    do {
//
//                        }
//                    } catch {
//                        print("Error Saving Image, \(error)")
//                    }

//                try self.realm.write {
//                    let newPic = Item()
//                    let image = capturedImageView.image
//                    let data = UIImageJPEGRepresentation(image!, 1) as! Data
//                    newPic.itemImage = data
//                    newPic.title = selectedProject!.name
//                    currentCategory.items.append(newPic)



//        print(selectedProject!.name)
//        newPic.parentProject = CameraSnappedVC.selectedProject
//
//        do {
//            try context.save()
//            SVProgressHUD.setDefaultStyle(.dark)
//            SVProgressHUD.setDefaultMaskType(.gradient)
//            SVProgressHUD.showSuccess(withStatus: "Image Saved")
//            SVProgressHUD.dismiss(withDelay: 1)
//        } catch {
//            print("Error saving project \(error)")
//        }

//MARK: - Core Data

//        let newPic = Item(context: self.context)
//        let image = capturedImageView.image
//        let data = UIImageJPEGRepresentation(image!, 1) as Data?
//        newPic.itemImage = data
//        newPic.title = selectedProject?.name
//        newPic.parentCategory = selectedProject
//        print(selectedProject!.name!)
//        //        newPic.parentProject = CameraSnappedVC.selectedProject
//        self.itemArray.append(newPic)
//
//        do {
//            try context.save()
//            SVProgressHUD.setDefaultStyle(.dark)
//            SVProgressHUD.setDefaultMaskType(.gradient)
//            SVProgressHUD.showSuccess(withStatus: "Image Saved")
//            SVProgressHUD.dismiss(withDelay: 1)
//        } catch {
//            print("Error saving project \(error)")
//        }
//







//        let newPic = Item(context: self.context)
//        newPic.itemImage = photoData
//        newPic.title = projectName
//        newPic.parentCategory = PhotoVC.selectedCategory
//        //        newPic.parentProject = CameraSnappedVC.selectedProject
//        self.itemArray.append(newPic)

//        saveImage()



//        if let realm = try? Realm() {
//            let category = Category()
//            category.name = (selectedProject?.name)!
//            for image in images {
//                let item = Item(image: image)
//                category.items.append(item)
//                item.parentCategory = category
//            }
//        }

//        if let chosenImage = self.capturedImageView.image {
//            images.append(chosenImage)
//        }

//        let fileManager = FileManager.default
//
//        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
//        print("documentsURL: \(documentsURL)")
//
//        let documentPath = documentsURL.path
//        print("documentPath: \(documentPath)")




//        if let currentCategory = self.selectedProject {
//
//            let filePath = documentsURL.appendingPathComponent("\(String(describing: currentCategory))\(String(describing: imgNo)).png")
//
//            let image = capturedImageView.image
//
//            do {
//                let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
//
//                for file in files {
//
//                    if "\(documentPath)/\(file)" == filePath.path {
//                        imgNo += 1
//                        if let pngImageData = UIImagePNGRepresentation(image!) {
//                            try pngImageData.write(to: filePath, options: .atomic)
//
//                            if let realm = try? Realm(){
//                                let category = Category()
//                                category.name = currentCategory.name
//                                for image in images {
//                                    let item = Item(image: image)
//                                    category.items.append(item)
////                                    item.parentCategory = category
//                                }
//
//                                try? realm.write {
//                                    realm.add(category)
//                                }
//                                dismiss(animated: true, completion: nil)
//                            }
////                        try fileManager.removeItem(atPath: filePath.path)
//                    }
//                    }
//                }
//            } catch {
//                print("Error Saving Image, \(error)")
//            }
//        }
