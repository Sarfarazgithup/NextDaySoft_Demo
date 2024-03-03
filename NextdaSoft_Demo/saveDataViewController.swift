//
//  saveDataViewController.swift
//  NextdaSoft_Demo
//
//  Created by Sarfaraz Ali on 02/03/24.
//

import UIKit
struct Item:Codable {
    let batchNumber: String
    let name: String
    let image: Data
    
   
}
class saveDataViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    @IBOutlet weak var setImage: UIButton!
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var imageTxt: UITextField!
    
    @IBOutlet weak var batchTxt: UITextField!
    
    
    @IBOutlet weak var DataTableView: UITableView!
    let imagePickerController = UIImagePickerController()
    var DataArray:[[Item]] = []
    var imagePath = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage.layer.cornerRadius = 6
        saveBtn.layer.cornerRadius = 16
        DataTableView.dataSource = self
        DataTableView.delegate = self
        imagePickerController.delegate = self
        DataTableView.register(UINib(nibName: "saveDataTableViewCell", bundle: nil), forCellReuseIdentifier: "saveDataTableViewCell")
        setData()
        gradientColor()
       
     
    }
    
    func gradientColor(){
        let gradientLayer = CAGradientLayer()
                gradientLayer.frame = view.bounds
                gradientLayer.colors = [UIColor.blue.cgColor,UIColor.red.cgColor]
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 1, y: 1)
                view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func setImage(_ sender: Any) {
        
        let ac = UIAlertController(title: "Select Image", message: "Select image from?", preferredStyle: .actionSheet)
            
            let cameraBtn = UIAlertAction(title: "Camera", style: .default) { [weak self] (_) in
                self?.showImagePicker(selectedSource: .camera)
            }
            
            let libraryBtn = UIAlertAction(title: "Library", style: .default) { [weak self] (_) in
                self?.showImagePicker(selectedSource: .photoLibrary)
            }
            
            let cancelBtn = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            ac.addAction(cameraBtn)
            ac.addAction(libraryBtn)
            ac.addAction(cancelBtn)
            
            self.present(ac, animated: true, completion: nil)
        }

        func showImagePicker(selectedSource: UIImagePickerController.SourceType) {
            guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
                print("Selected Source not available")
                return
            }
            
            imagePickerController.sourceType = selectedSource
            imagePickerController.allowsEditing = false
            
            self.present(imagePickerController, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            
            let data = selectedImage.jpegData(compressionQuality: 0.5)!
            let encoded = try! PropertyListEncoder ().encode (data)
            imagePath = encoded
            print("image->>>", selectedImage)


        } else {
            print("Image not found->>>")
        }
       
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveBtnAction(_ sender: Any) {
     
        let alertTitle = "Saving!"
        let message = "Data Has Been Added Successfully In Table"
        let alertBox = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) {_ in
            if let name = self.nameTxt.text,let batchNo = self.batchTxt.text, !name.isEmpty, !batchNo.isEmpty {
                let data1:[Item] = [.init(batchNumber: self.batchTxt.text ?? "", name: self.nameTxt.text ?? "", image: self.imagePath)]
                self.DataArray.append(data1)
                if let encodedData = try? JSONEncoder().encode(self.DataArray) {
                    UserDefaults.standard.set(encodedData, forKey: "DataArray")
                }
                self.setData()
            }
        }
        alertBox.addAction(alertAction)
        present(alertBox,animated: true,completion: nil)
       
    }
    
    func setData() {
        if let savedData = UserDefaults.standard.data(forKey: "DataArray"),
           let decodedData = try? JSONDecoder().decode([[Item]].self, from: savedData) {
            DataArray = decodedData
        }
        DataTableView.reloadData()
        print("data->>>",DataArray)
    }

    
}

extension saveDataViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DataTableView.dequeueReusableCell(withIdentifier: "saveDataTableViewCell", for: indexPath) as! saveDataTableViewCell
        if let imagePath = DataArray[indexPath.row].first?.image {
            print("iffff",imagePath)
            let decoded = try! PropertyListDecoder().decode(Data.self, from: imagePath)
            let image = UIImage(data: decoded)
            cell.myImage.image = image
        }
        cell.name.text = "\(DataArray[indexPath.row].first?.name ?? "")"
        cell.batchNo.text = "\(DataArray[indexPath.row].first?.batchNumber ?? "")"
        
        return cell
    }
    
}

