//
//  ViewController.swift
//  ScanMe
//
//  Created by Jonathan Ballona on 3/28/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var SelectPhotoBttn: UIButton!
    
    
    @IBOutlet weak var GetTxtBttn: UIButton!
    
    
    @IBOutlet weak var ConvertedTxt: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func SelectPhoto(_ sender: Any) {
        print("We will take a photo and display it")
    }
    @IBAction func ConvertText(_ sender: Any) {
        print("We will grab the text from the image and display it")
    }
    

}

