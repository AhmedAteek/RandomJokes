//
//  ViewController.swift
//  RandomJokes
//
//  Created by Ahmed Ateek on 2/24/19.
//  Copyright © 2019 Ahmed-Ateek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var showJoke:UILabel!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loading.hidesWhenStopped = true
    }
     
    //Mark: add this func here that check the status of network here
    // because no need to add it in app deleget its just work when user pressed the button
    
    func fetchJokesAndCheckConnection(){
        if Reachability.isConnectedToNetwork(){
            let urlString = "https://icanhazdadjoke.com/" 
            print(urlString)
            guard let url = NSURL(string: urlString) else {
                
                Loading.stopAnimating()
                return}
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "GET"
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                //Implement JSON decoding and parsing
                do {
                    //Decode retrived data with JSONDecoder and assing type of Jokes object
                    let JokesData = try JSONDecoder().decode(JokesModel.self, from: data)
                    
                    //Get back to the main queue
                    DispatchQueue.main.async {
                        print(JokesData)
                        self.showJoke.text = JokesData.joke
                        self.Loading.stopAnimating()
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
                
                
                }; task.resume()
        }else{
            self.alertUser(title: "Alert", message: "No Internet Connection")
            
        }
    }
    
    
    
    
    @IBAction func getJoke(_ sender:UIButton){
        Loading.startAnimating()
        fetchJokesAndCheckConnection()
    }
}

