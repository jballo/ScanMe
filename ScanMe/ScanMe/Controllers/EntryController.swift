//
//  EntryController.swift
//  ScanMe
//
//  Created by Jonathan Ballona on 4/2/23.
//

import UIKit

class EntryController: UIViewController {

    @IBOutlet weak var CompanyCameraBttn: UIButton!
    @IBOutlet weak var ModelNoCameraBttn: UIButton!
    @IBOutlet weak var SerialNoCameraBttn: UIButton!
    @IBOutlet weak var LocationCameraBttn: UIButton!
    @IBOutlet weak var AddEntryBttn: UIButton!
    
    
    @IBOutlet weak var CompanyTextField: UITextField!
    @IBOutlet weak var ModelNoTextField: UITextField!
    @IBOutlet weak var SerialNoTextField: UITextField!
    @IBOutlet weak var LocationTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddCompanyName(_ sender: Any) {
        self.CompanyTextField.text = "Some COmpany Name"
    }
    
    @IBAction func AddModelNumber(_ sender: Any) {
        self.ModelNoTextField.text = "M0D3L-NUM"
    }
    
    
    @IBAction func AddSerialNumber(_ sender: Any) {
        self.SerialNoTextField.text = "S3R1@L-NUM"
    }
    
    @IBAction func AddLocation(_ sender: Any) {
        self.LocationTextField.text = "R@ND-L0C@T10N"
    }
    
    @IBAction func AddEntry(_ sender: Any) {
        let comp: String = CompanyTextField.text!
        let model: String = ModelNoTextField.text!
        let serial: String = SerialNoTextField.text!
        let location: String = LocationTextField.text!
        
        
        print(comp)
        print(model)
        print(serial)
        print(location)
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
