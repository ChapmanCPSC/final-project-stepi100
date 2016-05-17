//
//  ViewController.swift
//  Weather
//
//  Created by Burns, Ryan Thomas on 5/9/16.
//  Copyright © 2016 Burns, Ryan Thomas. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    var names = [String]()
    var amount : Int!
    var zip : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func submit(sender: AnyObject) {
        
         self.zip = self.zipTextField.text!
       
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRecipe"{
            
            let vc = segue.destinationViewController as! RecipeTableViewController
            let test = zipTextField.text!
            //let test2 = test.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharactersSet())
            vc.search = test
            presentViewController(vc, animated: true, completion: nil)
            
            
        
        }
            
    }
    
    
    
}

