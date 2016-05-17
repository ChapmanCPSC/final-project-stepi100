//
//  RecipeTableViewController.swift
//  Weather
//
//  Created by Andrew Stepien on 5/16/16.
//  Copyright © 2016 Burns, Ryan Thomas. All rights reserved.
//

import UIKit
import SafariServices

class RecipeTableViewController: UITableViewController,SFSafariViewControllerDelegate {
    

    @IBOutlet weak var backbutton: UIBarButtonItem!
    
    var recipeNames = [String]()
    var urlnames = [String]()
    var numCells : Int = 0
    var search : String!
    var json : [String:AnyObject]!
    
    
    @IBOutlet weak var toolbar1: UIToolbar!
    
    @IBAction func back(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let endpoint = "http://food2fork.com/api/search"
        let key = "?key=6a4f90dd24f42dfdde435691e2b63b8f&q="
        let urlString = "\(endpoint)\(key)\(search)"
        
        
        
        let url = NSURL(string: urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, request, error) -> Void in
            
            if let e = error
            {
                print(e)
            }
            else
            {
                self.json = try! NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String:AnyObject]
                print(self.json)
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    self.numCells = self.json["count"] as! Int
                    
                    for i in 0...(self.numCells-1){
                        
                       self.recipeNames.append((self.json["recipes"]![i]["title"] as? String)!)
                        self.urlnames.append((self.json["recipes"]![i]["source_url"] as? String)!)
                      
                    }
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                    print(self.numCells)
                    print(self.recipeNames)
                    print(self.urlnames)
                    

                    
                    
                })
                
                
                
            }
            
        }
        task.resume()
       
        
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selected = urlnames[indexPath.row]
        let selectedurl = NSURL(string: selected)
        
        let svc = SFSafariViewController(URL: selectedurl!)
        svc.delegate = self
        presentViewController(svc, animated: true, completion: nil)
    }
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numCells
    }


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCellWithIdentifier("ReuseIdentifier", forIndexPath: indexPath)
        let cell = UITableViewCell()
      
        cell.textLabel?.text = recipeNames[indexPath.row]
        
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
