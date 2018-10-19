//
//  CategoryViewController.swift
//  Todoey
//
//  Created by stone_1 on 09/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    var itemArray = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

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
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            context.delete(categories[indexPath.row])
            categories.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveCategories()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPhotos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! PhotosCollectionViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    func saveCategories() {
        
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()

        do{
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }

        
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
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categories.append(newCategory)
            
            self.saveCategories()
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a New Category"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
}
