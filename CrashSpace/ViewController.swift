//
//  ViewController.swift
//  CrashSpace
//
//  Created by Kevin Jordan on 10/11/15.
//  Copyright © 2015 NetKruzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var userDefaults = UserDefaults.standard
    
    

    // Url to get the current status
    // and to send updates to
    let url = "https://crashspacela.com/sign/"
    @IBOutlet weak var slider: UISlider!
    
    // variables that connect to items on the storyboard
    @IBOutlet weak var sliderMins: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var message: UITextField!
    
    /*
        Function to update screen with the freshest web data
    */
    @IBAction func refreshWeb(_ sender: AnyObject) {
       self.loadWebView("")
    }
    
    /*
        Update the slider value's label to reflect where the slider is currently positioned
    */
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        
        sliderMins.text = "\(currentValue)"
    }
    
    /*
        Quick function to load a url into the main webview
    */
    
    func loadWebView(_ urlParameters: String){
        let requestURL = URL(string:url)
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }
    /*
        load up the webView with the crashspace URL
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Loads the user and message to local memory from past load.
        // needs to be fixed to work correctly
        if let userText: AnyObject = userDefaults.value(forKey: "userName") as AnyObject {
            user.text = userText.string
        }
        if let messageText: AnyObject = userDefaults.value(forKey: "message") as AnyObject {
            message.text = messageText.string
        }

        
        
        //call the updateWebView url
        self.loadWebView("")
    }
    /*
        On reappear of the screen, update the webview
    */
    override func viewDidAppear(_ animated: Bool) {
        self.loadWebView("")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    /*
     * Send request to the big button
     *   url format: http://crashspacela.com/sign/?id=Kevin&msg=test!&type=iOS&diff_mins_max=1
     *
     */

    @IBAction func checkIn(_ sender: AnyObject) {
        var userText = NSString()
        var messageText = NSString()
        
        if(user.text != nil){
            userText = user.text! as NSString
        }
        else{
            userText = " "
        }
        if(message.text != nil){
            messageText = message.text! as NSString
        }
        else{
            messageText = " "
        }
        let urlString =  "\(url)?id=\(userText)&msg=\(messageText)&type=iOS&diff_mins_max=\(sliderMins.text!)&debug=1"
        
        let requestURL = URL(string:urlString)
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
        
        
        // Save the user and message to local memory for next load.
        // needs to be fixed to work correctly
        if(user.text != nil){
            userDefaults.setValue(user.text, forKey: "userName")
            userDefaults.synchronize()
        }
        
        if(message.text != nil){
            userDefaults.setValue(message.text, forKey: "message")
            userDefaults.synchronize()
        }
    }
    
    

}

