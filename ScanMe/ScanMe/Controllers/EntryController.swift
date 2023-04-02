//
//  EntryController.swift
//  ScanMe
//
//  Created by Jonathan Ballona on 4/2/23.
//

import UIKit
import AlamofireImage
import Vision

class EntryController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var CompanyCameraBttn: UIButton!
    @IBOutlet weak var ModelNoCameraBttn: UIButton!
    @IBOutlet weak var SerialNoCameraBttn: UIButton!
    @IBOutlet weak var LocationCameraBttn: UIButton!
    
    // adding a flag to keep track of which button was tapped
    var currentBttn: UIButton? = nil
    
    @IBOutlet weak var AddEntryBttn: UIButton!
    
    
    @IBOutlet weak var CompanyTextField: UITextField!
    @IBOutlet weak var ModelNoTextField: UITextField!
    @IBOutlet weak var SerialNoTextField: UITextField!
    @IBOutlet weak var LocationTextField: UITextField!

    var companyPhoto: UIImage? = nil
    var modelNoPhoto: UIImage? = nil
    var serialNoPhoto: UIImage? = nil
    var locationPhoto: UIImage? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddCompanyName(_ sender: Any) {
//        var companyName: String = "Some COmpany Name"
        
        // set the flag tot he current button
        currentBttn = CompanyCameraBttn
        
        
        // create picker for image selection
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        
        // check for photo source availability
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        // will present the image picker (either camera or photolibrary)
        // will also select the which photo to use
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func AddModelNumber(_ sender: Any) {
        var modelNumber: String = "M0D3L-NUM"
        
        currentBttn = ModelNoCameraBttn
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // check for photo source availability
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        // will present the image picker (either camera or photolibrary)
        // will also select the which photo to use
        present(picker, animated: true, completion: nil)
    }
    
    
    @IBAction func AddSerialNumber(_ sender: Any) {
        var serialNumber: String = "S3R1@L-NUM"
        
        currentBttn = SerialNoCameraBttn
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // check for photo source availability
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        // will present the image picker (either camera or photolibrary)
        // will also select the which photo to use
        present(picker, animated: true, completion: nil)
    }
    
    
    
    @IBAction func AddLocation(_ sender: Any) {
//        var location: String = "R@ND-L0C@T10N"
//
//        location = convertImgToTxt(inputImg: locationPhoto)
//
//        self.LocationTextField.text = location
        
        
        currentBttn = LocationCameraBttn
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        // check for photo source availability
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        // will present the image picker (either camera or photolibrary)
        // will also select the which photo to use
        present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func AddEntry(_ sender: Any) {
        let comp: String = CompanyTextField.text!
        let model: String = ModelNoTextField.text!
        let serial: String = SerialNoTextField.text!
        let location: String = LocationTextField.text!
        
        if ((comp == "Not Processed" || comp == "")
            || (model == "Not Processed" || model == "")
            || (serial == "Not Processed" || serial == "")
            || (location == "Not Processed" || location == "")
        ){
            print("Missing Required Fields")
        }
        
        
    }
    
    
    
    
    func convertImgToTxt(inputImg: UIImage?) -> String {
        if(inputImg == nil){
            return "Not Processed"
        }
        var recognizedTxt: String = ""
        
        // convert input image to cgImage (easier to manipulate)
        guard let cgImage = inputImg?.cgImage else { return "Not Processed" }
        
        // createing request with cgImage
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Vision provides its text-recognition capabilities through VNRecognizeTextRequest, an image-based request type that finds and extracts text in images
        let request = VNRecognizeTextRequest { request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else { return }
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ", ")
            
            print(text)
            
            recognizedTxt = text
                    
        }
        // Set recongition level of request to accurate which takes more time but is more comprehensive
        // set to .fast if a faster response is wanted but at the cost of accuracy
        request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
        
        //execute request
        do {
            try handler.perform([request])
        } catch {
            // uncomment to see error in terminal
//            print(error)
            
            // if request failed, return a failed response
            return "Not Processed"
            
        }
        
        return recognizedTxt
    }
    
    func setTextField(){
        var companyName = ""
        if currentBttn == CompanyCameraBttn{
            companyName = self.convertImgToTxt(inputImg: self.companyPhoto)
            if (companyName == "Not Processed" || companyName == ""){
                print("error")
                return
            }else {
                self.CompanyTextField.text = companyName
            }
        } else if (currentBttn == ModelNoCameraBttn) {
            companyName = self.convertImgToTxt(inputImg: self.modelNoPhoto)
            if (companyName == "Not Processed" || companyName == ""){
                print("error")
                return
            }else {
                self.ModelNoTextField.text = companyName
            }
        } else if (currentBttn == SerialNoCameraBttn) {
            companyName = self.convertImgToTxt(inputImg: self.serialNoPhoto)
            if (companyName == "Not Processed" || companyName == ""){
                print("error")
                return
            }else {
                self.SerialNoTextField.text = companyName
            }
        }  else if (currentBttn == LocationCameraBttn) {
            companyName = self.convertImgToTxt(inputImg: self.locationPhoto)
            if (companyName == "Not Processed" || companyName == ""){
                print("error")
                return
            }else {
                self.LocationTextField.text = companyName
            }
        }
        
    }
    
    
    // function to give data to photo selected
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 3000, height: 3000)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        if currentBttn == CompanyCameraBttn{
            companyPhoto = scaledImage
        } else if (currentBttn == ModelNoCameraBttn) {
            modelNoPhoto = scaledImage
        } else if (currentBttn == SerialNoCameraBttn) {
            serialNoPhoto = scaledImage
        } else if (currentBttn == LocationCameraBttn) {
            locationPhoto = scaledImage
        }
        
        dismiss(animated: true) {
            self.setTextField()
            self.currentBttn = nil
        }
//        dismiss(animated: true, completion: nil)
    }
    

}
