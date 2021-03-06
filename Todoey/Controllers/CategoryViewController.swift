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


class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    @IBOutlet weak var tableView: RoundedTableView!
    @IBOutlet weak var menuBtn: UIButton!
    //    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor?.withAlphaComponent(0.5)
        
        tableView.dataSource = self
        tableView.delegate = self
//
//        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
//        revealViewController().frontViewController.view.isOpaque = true
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        SVProgressHUD.dismiss()
        loadCategories()
       
        navigationController?.setNavigationBarHidden(true, animated: false)

       
    }


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories?.count ?? 1
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        tableView.rowHeight = 90
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 34.0)
        cell.textLabel?.textColor = #colorLiteral(red: 0.6456218274, green: 0.1673866657, blue: 0.002206729275, alpha: 1)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToPhotos", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? PhotosCollectionViewController {
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
//            print(destinationVC.selectedCategory?.name)
        }
        }
//        if let destinationViewController = segue.destination as? CameraViewController {
//            destinationViewController.transitioningDelegate = self
//            destinationViewController.interactor = interactor
//        }
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
    
//    let interactor = Interactor()
//
//    @IBAction func openMenu(_ sender: Any) {
//        performSegue(withIdentifier: "openMenu", sender: nil)
//    }
//
//    @IBAction func edgePanGesture(sender: UIScreenEdgePanGestureRecognizer) {
//        let translation = sender.translation(in: view)
//
//        let progress = MenuHelper.calculateProgress(translationInView: translation, viewBounds: view.bounds, direction: .Right)
//        MenuHelper.mapGestureStateToInteractor(gestureState: sender.state, progress: progress, interactor: interactor){
//            self.performSegue(withIdentifier: "openMenu", sender: nil)
//        }
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//    }

}

extension CategoryViewController: UIViewControllerTransitioningDelegate {
    
//        func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//            return PresentMenuAnimator()
//        }
//
//        func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//            return DismissMenuAnimator()
//        }
//
//        func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//            return interactor.hasStarted ? interactor : nil
//        }
//
//        func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//            return interactor.hasStarted ? interactor : nil
//    }
}
