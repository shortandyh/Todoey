//
//  CategoryViewController.swift
//  Todoey
//
//  Created by stone_1 on 09/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit
import RealmSwift
import SVProgressHUD


class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
//    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.dismiss()
        loadCategories()

       
    }


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        tableView.rowHeight = 90
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 34.0)
        cell.textLabel?.textColor = #colorLiteral(red: 0.6456218274, green: 0.1673866657, blue: 0.002206729275, alpha: 1)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            
            if let category = categories?[indexPath.row] {
                do {
                    try realm.write {
                        realm.delete(category)
                        
                    }
                } catch {
                    print("Error deleting table row, \(error)")
                }
            }
            
            tableView.reloadData()
//            context.delete(categories[indexPath.row])
            
            
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            self.saveInRealm(category: <#T##Category#>)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPhotos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotosCollectionViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
            print(destinationVC.selectedCategory?.name)
        }
    }
    
    func deleteRow(category: Category) {
        
    }
    
    func saveInRealm(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
        //MARK: - Core Data
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do{
//            categories = try context.fetch(request)
//        } catch {
//            print("Error loading categories \(error)")
//        }

        
//        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
//        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
//
//        do {
//            let items = try context.fetch(fetchRequest)
//            for item in items {
//                context.delete(item)
//            }
//            try context.save()
//        } catch _ {
//            // error handling
//        }
        
        
        
    }

    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            
            
            
            //MARK: - Core Data
//            self.categories.append(newCategory)
            
            self.saveInRealm(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a New Category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}
