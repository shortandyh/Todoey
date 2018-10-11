//
//  CameraViewController.swift
//  Todoey
//
//  Created by stone_1 on 11/10/2018.
//  Copyright © 2018 stone1. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Variables
    var captureSession: AVCaptureSession!
    var cameraOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var imagePickerController: UIImagePickerController!
    var photoData: Data?
    var effect: UIVisualEffect!
    var projectName: String?
    
    var categories = [Category]()
    var itemArray = [Item]()
    
    //    var CameraSnappedVC : SnappedVC = SnappedVC()
    
    var selectedProject : Category? {
        didSet{
            loadProjects()
        }
    }
    
    //MARK: - Constants
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer.frame = cameraView.bounds
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
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
                previewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
                previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
                
                cameraView.layer.addSublayer(previewLayer!)
                cameraView.addGestureRecognizer(tap)
                captureSession.startRunning()
            }
        } catch {
            debugPrint(error)
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
        
        saveImage()
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
        
        //        let image = self.captureImageView.image
        //        let data = UIImageJPEGRepresentation(image!, 1) as NSData?
        let image = UIImage(data: photoData!)
        let data = UIImageJPEGRepresentation(image!, 1) as Data?
        let newPic = ProjectImage(context: self.context)
        newPic.sImage = data
        newPic.sName = projectName
        //        newPic.parentProject = CameraSnappedVC.selectedProject
        self.itemArray.append(newPic)
        
        self.saveImage()
        
        //        do {
        //            try context.save()
        //        } catch {
        //            print("Error saving project \(error)")
        //        }
        
        
        //
        //fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
        
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
        //        { (success: Bool) in
        //            //self.captureImageView.removeFromSuperview()
        //
        //        }
    }
    
    func saveProjects() {
        do {
            try context.save()
        } catch {
            print("Error saving project \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadProjects() {
        
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error saving project \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    //MARK: - TableView setup
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flippedProjectCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        //        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        //        cell.textLabel?.text = project[indexPath.row].name
        cell.textLabel?.font = UIFont(name: "Helvetica Neue Light", size: 18.0)
        //cell.detailTextLabel?.text = ""
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let self.projectName = project[indexPath.row]
        if let indexPath = tableView.indexPathForSelectedRow {
            self.projectName = categories[indexPath.row].name
        }
    }
    
    
}

//MARK: - Extension
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
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
        
    }
    
    
    
}

