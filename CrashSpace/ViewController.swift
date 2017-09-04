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
    
    var settings : Settings = Settings()
    
    
    // Url to get the current status
    // and to send updates to
    //let url = "https://crashspacela.com/sign/"
    let testurl = "https://crashspacela.com/sign-tst/?debug=true"  // careful, only one ? mark!
    @IBOutlet weak var slider: UISlider!
    
    // variables that connect to items on the storyboard
    @IBOutlet weak var sliderMins: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var message: UITextField!
    

    // MARK: - Life Cycle
    
    /*
     load up the webView with the crashspace URL
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load user and message from Settings (User Defaults)
        loadSettings()
        
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
    
    // MARK: - Helper functions
    /*
     Quick function to load a url into the main webview
     */
    
    func loadWebView(_ urlParameters: String){
        let requestURL = URL(string:testurl)
        let request = URLRequest(url: requestURL!)
        webView.loadRequest(request)
    }
    
    /*
     load user and message from Settings (User Defaults)
     */
    func loadSettings() {
        if let userText = Settings.userName {
            user.text = userText
        }
        if let messageText = Settings.message {
            message.text = messageText
        }
    }
    

    // MARK: - UI Actions
    /**
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
            userText = "iostestuser"
        }
        if(message.text != nil){
            messageText = message.text! as NSString
        }
        else{
            messageText = "test"
        }
        
        // Save the user and message to User Defaults for next load.
        saveSettings()
        
        let urlString =  "\(testurl)&id=\(userText)&msg=\(messageText)&type=iOS&diff_mins_max=\(sliderMins.text!)"    //&debug=1"
        //let urlString =  "\(url)?id=\(userText)&msg=\(messageText)&type=iOS&diff_mins_max=\(sliderMins.text!)&debug=1"

        print("this is an url string? >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> \(urlString)")
        // https://crashspacela.com/sign-tst/?debug=true&id=iostestuser&msg=iostest&type=iOS&diff_mins_max=2
        
        
        if let requestURL = URL(string:urlString) {
            let request = URLRequest(url: requestURL)
            webView.loadRequest(request)
        } else {
            
            print("problem with requestURL!!!")
        }

    }
    
    func saveSettings() {
        if(user.text != nil){
            Settings.userName = user.text
        }
        
        if(message.text != nil){
            Settings.message = message.text
        }
    }
    
    
    /*
     Function to update screen with the freshest web data
     */
    @IBAction func refreshWeb(_ sender: AnyObject) {
        // we can now update our settings without sending checkin to web page (for testing mostly)
        saveSettings()
        self.loadWebView("")
    }
    
    /*
     Update the slider value's label to reflect where the slider is currently positioned
     */
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
        sliderMins.text = "\(currentValue)"
    }
    
    
    
}

