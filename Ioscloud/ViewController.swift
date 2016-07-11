//
//  ViewController.swift
//  Ioscloud
//
//  Created by Roberto Carlos Callisaya Mamani on 7/1/16.
//  Copyright © 2016 Roberto Carlos Callisaya Mamani. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var coverpage: UIImageView!
    @IBOutlet weak var titulos: UILabel!
    @IBOutlet weak var autores: UILabel!
    @IBOutlet weak var portada: UILabel!
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
        do {
            let json  = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            
            let dataall = json as! NSDictionary
            let titulo = dataall["ISBN:"+isbn]!["title"] as! NSString as String
            let dataautores = dataall["ISBN:"+isbn]!["authors"] as! NSArray
            let coverpages = dataall["ISBN:"+isbn]!["cover"] as! NSDictionary
            var stringautores = ""
            for data in dataautores {
                let dataautor = data as! NSDictionary
                let dataautorname =  dataautor["name"] as! NSString as String
                print(dataautor)
                stringautores += dataautorname + "\n"
            
            }
            autores.text = stringautores;
            
            let imagenurl = coverpages["medium"] as! NSString as String
            
            
            
           print(coverpages)
            
            
            print(dataautores)
            
            titulos.text = titulo
            
            //let urlimage = NSURL(string: "https://covers.openlibrary.org/b/id/6890250-S.jpg")
            let urlimage = NSURL(string: imagenurl)
            let dataimage = NSData(contentsOfURL: urlimage!) //make sure your image in this url does exist, otherwise unwrap in a if let check
            coverpage.image = UIImage(data: dataimage!)
            
        }catch _ {
        }
    }

}

