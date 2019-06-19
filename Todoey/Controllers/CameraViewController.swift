//
//  CameraViewController.swift
//  Todoey
//
//  Created by stone_1 on 11/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift
import SVProgressHUD
import Photos
import PhotosUI
import Toucan
import LocalAuthentication

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIApplicationDelegate {
    
    //MARK: - Variables
    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var imagePickerController: UIImagePickerController!
    var photoData: Data?
    var effect: UIVisualEffect!
    var projectName: String?
    var imgNo = 1
    var images : [UIImage] = []
    
    var categories: Results<Category>?
    var todoItems: Results<Item>?
    var PhotoVC: PhotosCollectionViewController = PhotosCollectionViewController()
    
    var selectedProject : Category?
//    {
//        didSet{
//            loadProjects()
//        }
//    }
    
    //MARK: - Constants
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let realm = try! Realm()
    
    @IBOutlet weak var capturedImageView: RoundedImageView!
    @IBOutlet weak var flippedTableView: RoundedImageView!
    @IBOutlet weak var clearBtn: RoundedShadowButton!
    @IBOutlet weak var thumbBtn: RoundedShadowButton!
    
    @IBOutlet weak var visualEffectedView: UIVisualEffectView!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var horizPopUpConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        locTouchId()

        
//        SVProgressHUD.dismiss()

        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        effect = visualEffectedView.effect
        visualEffectedView.effect = nil
        visualEffectedView.isHidden = true
        
        loadProjects()
        
        capturedImageView.isHidden = true
        thumbBtn.isHidden = true
        clearBtn.isHidden = true
        
        flippedTableView.isHidden = true
        
        view.addSubview(capturedImageView)
        view.addSubview(flippedTableView)
        
//        let fileManager = FileManager.default
//        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        do {
//            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
//        } catch {
//            print("Error whileenumerating files \(documentsURL.path): \(error.localizedDescription)")
//        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
        locTouchId()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapCameraView))
        tap.numberOfTapsRequired = 1
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            if captureSession.canAddInput(input) == true {
                captureSession.addInput(input)
            }
            
            cameraOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddOutput(cameraOutput) == true {
                captureSession.addOutput(cameraOutput!)
                
                previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                cameraView.layer.addSublayer(previewLayer!)
                cameraView.addGestureRecognizer(tap)
                captureSession.startRunning()
            }
        } catch {
            debugPrint(error)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if captureSession.isRunning == true {
            captureSession.stopRunning()
        }
    }
    
    @IBAction func showPopUp(_ sender: Any) {
        perform(#selector(flip), with: nil, afterDelay: 0)
        loadProjects()
        clearBtn.isHidden = true
    }
    
    @IBAction func ClearBttn(_ sender: Any) {
        animateOut()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            //self.flipTableView.isHidden = true
            self.visualEffectedView.isHidden = true
            self.capturedImageView.isHidden = true
            self.thumbBtn.isHidden = true
            self.clearBtn.isHidden = true
        }
    }
    
    @IBAction func savePhotosToCategory(_ sender: Any) {
        
        
        horizPopUpConstraint.constant = 600
        UIView.animate(withDuration: 0.2, animations: {self.view.layoutIfNeeded()})
        self.capturedImageView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.flippedTableView.isHidden = true
        }
        visualEffectedView.isHidden = true
        thumbBtn.isHidden = true
        clearBtn.isHidden = true
        
        
        if let currentCategory = self.selectedProject {
            
            do {
                
            try self.realm.write {
//            if let realm = try? Realm() {
            let image = self.capturedImageView.image
            let item = Item(image: image!)
            currentCategory.items.append(item)
            
//            try? realm.write {
//                realm.add(item)
            
//            do {
//                tryrealm.write {
//                    let newItem = Item()
//                    newItem.imageToURLString(image: self.capturedImageView.image!)
////                    image = self.capturedImageView.image
////                    newItem.imageToURLString(image: image)
//////                    newItem.title = textField.text!
////                    newItem.image
////                    currentCategory.items.append(newItem)
//                }
//            } catch {
//                print("Error saving new items, \(error)")
//            }
                
              }
           
            
            } catch {
                print("Error saving new items, \(error)")
            }
            
        }
        
//        tableView.reloadData()

    }
    
    

    @IBAction func clearedSave(_ sender: Any) {
        perform(#selector(flipBack), with: nil, afterDelay: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.clearBtn.isHidden = false
        }
    }
    

    
    @objc func didTapCameraView() {
        let settings = AVCapturePhotoSettings()
        settings.previewPhotoFormat = settings.embeddedThumbnailPhotoFormat
        cameraOutput.capturePhoto(with: settings, delegate: self)
    }
    
    
    //MARK: - Objective C Functions
    @objc func saveImage() {
        

//        if let indexPath = tableView.indexPathForSelectedRow {
//            let parentCat = categories[indexPath.row].name
//        }
        
        
        
//        saveImagesToContext()
        

        
    }
    
    
    @IBAction func segueToProjects(_ sender: Any) {
        performSegue(withIdentifier: "camToPro", sender: self)
    }
    
    @objc func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: capturedImageView, duration: 0.3, options: transitionOptions, animations: {
            self.capturedImageView.isHidden = true
        }, completion: nil)
        
        UIView.transition(with: flippedTableView, duration: 0.3, options: transitionOptions, animations: {
            self.flippedTableView.isHidden = false
        }, completion: nil)
    }
    
    @objc func flipBack() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
        UIView.transition(with: flippedTableView, duration: 0.5, options: transitionOptions, animations: {
            self.flippedTableView.isHidden = true
        }, completion: nil)
        
        UIView.transition(with: capturedImageView, duration: 0.5, options: transitionOptions, animations: {
            self.capturedImageView.isHidden = false
        }, completion: nil)
        
        
    }
    
    
    //MARK: - Functions
    func animateIn() {
        //self.view.addSubview(captureImageView)
        self.capturedImageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.capturedImageView.alpha = 0
        self.capturedImageView.isHidden = false
        self.visualEffectedView.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.visualEffectedView.effect = self.effect
            self.capturedImageView.alpha = 1
            self.capturedImageView.transform = CGAffineTransform.identity
        }
        
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.2, animations: {
            self.capturedImageView.transform = CGAffineTransform.init(scaleX: 1.3, y:1.3)
            self.capturedImageView.alpha = 0
            self.visualEffectedView.effect = nil
            
        })

    }
    
    func saveImagesToContext() {
//        do {
//            try context.save()
//        } catch {
//            print("Error saving project \(error)")
//        }
        
//        self.PhotoVC.collectionView?.reloadData()
        
    }
    
    func loadProjects() {
        
        
        
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
        //MARK: - Core Data
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//
//        do {
//            categories = try context.fetch(request)
//        } catch {
//            print("Error saving project \(error)")
//        }
//
//        tableView.reloadData()
        
        
        
        
        
        
        
        
    }
    
    func locTouchId() {
        let context: LAContext = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Stick your finger on it!") { (wasSuccessful, error) in
                if wasSuccessful {
                    print ("was a success")
                } else {
                    print ("you are not logged in")
                }
            }
        }
    }
    
//    func applicationDidBecomeActive(_ application: UIApplication) {
//        locTouchId()
//    }
    
    //MARK: - TableView setup
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flippedProjectCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories Added Yet"

        cell.textLabel?.font = UIFont(name: "Helvetica Neue Light", size: 18.0)
        //cell.detailTextLabel?.text = ""
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//                let projectName = proj[indexPath.row]
        if let indexPath = tableView.indexPathForSelectedRow {
            self.selectedProject = categories?[indexPath.row]
//            print(selectedProject!)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! PhotosCollectionViewController
//        
//        
//    }
    
    
}


//MARK: - Extension
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        
        
//        if photoData != nil {

            if let error = error {
                debugPrint(error)
            } else {
                photoData = photo.fileDataRepresentation()

                let image = UIImage(data: photoData!)
                self.capturedImageView.image = image
                

                //            captureImageView.isHidden = false
                animateIn()
                thumbBtn.isHidden = false
                clearBtn.isHidden = false
                horizPopUpConstraint.constant = -50

            }
//
//
//
//        } else {

//            guard error != nil else { print("Error capturing photo: \(error!)"); return }

        
            
        //}
    
    }

    
}
