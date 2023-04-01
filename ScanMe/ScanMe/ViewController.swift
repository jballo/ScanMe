//
//  ViewController.swift
//  ScanMe
//
//  Created by Jonathan Ballona on 3/28/23.
//

import UIKit
import AlamofireImage
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var SelectPhotoBttn: UIButton!
    
    
    @IBOutlet weak var GetTxtBttn: UIButton!
    
    
    @IBOutlet weak var ConvertedTxt: UILabel!
    
    
    
    var imgSelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func SelectPhoto(_ sender: Any) {
        print("We will take a photo and display it")
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
//        picker.sourceType = .camera
//        present(picker, animated: true)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            print("camera was available")
            picker.sourceType = .camera
//            picker.sourceType = .photoLibrary
            
        } else {
            print("camer was not available so .photoLibrary was used")
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
        imgSelected = true
        
    }
    @IBAction func ConvertText(_ sender: Any) {
        print("We will grab the text from the image and display it")
        if(imgSelected == false){
            print("No image is selected")
            return
        }else {
            conversion(inputImage: img.image)
        }
        print(imgSelected)
    }
    
    
    func conversion(inputImage: UIImage?){
        // convert image to cgImage
        guard let cgImage = inputImage?.cgImage else { return }
        
        // creating request with cgImage
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        // Vision provides its text-recognition capabilities through VNRecognizeTextRequest, an image-based request type that finds and extracts text in images.
        let request = VNRecognizeTextRequest {request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
             error == nil else {return}
            print("we are trying to get data")
             let text = observations.compactMap({
                 $0.topCandidates(1).first?.string
             }).joined(separator: ", ")
            
            DispatchQueue.main.async {
                var lorem = "qwertyuiopasdjfsadflsdjfxzcnvxz"
                self.ConvertedTxt.text = text
//                self.ConvertedTxt.text = lorem
            }
             //print(text) // text we get from image
        }
        
//        let request = VNRecognizeTextRequest { request, error in
//
//            guard let observations = request.results as
//                    [VNRecognizedTextObservation],
//                  error == nil else { return }
//            let text = observations.compactMap({
//                $0.topCandidates(1).first?.string
//            }).joined(separator: ", ")
//            print(text)
//
//        }
        
        request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
        do{
            try handler.perform([request])
        } catch {
            print(error)
        }

        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        img.image = scaledImage
        
        
        dismiss(animated: true, completion: nil)
        
    }

}

