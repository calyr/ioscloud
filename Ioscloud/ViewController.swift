//
//  ViewController.swift
//  Ioscloud
//
//  Created by Roberto Carlos Callisaya Mamani on 7/1/16.
//  Copyright © 2016 Roberto Carlos Callisaya Mamani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtIsbn: UITextField!
    @IBOutlet weak var txtResult: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtIsbn.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sincrono(txtIsbn.text!)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressEnter(sender: UITextField) {
    print("Imprimir el valor \(txtIsbn.text)")
    }
    
    func sincrono(isbn:String){
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"+isbn
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        let texto = NSString( data: datos!, encoding: NSUTF8StringEncoding)
        txtResult.text = String(texto)
    }

}

