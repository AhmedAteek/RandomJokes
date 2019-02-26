//
//  SearchJokeVC.swift
//  RandomJokes
//
//  Created by Ahmed Ateek on 2/25/19.
//  Copyright © 2019 Ahmed-Ateek. All rights reserved.
//

import UIKit

class SearchJokeVC: UIViewController {
    @IBOutlet weak var SearchTxt:UITextField!
    @IBOutlet weak var ResultTB:UITableView!
    @IBOutlet weak var Loading: UIActivityIndicatorView!
    var JokeResult = [SearchJokesModel.Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Jokes"
        Loading.hidesWhenStopped = true
    }
    
    
    func SearchJokesAndCheckConnection(SearchWord keyWord :String){
        if Reachability.isConnectedToNetwork(){
            let urlString = "https://icanhazdadjoke.com/search?term=" + keyWord 
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
                    let JokesResult = try JSONDecoder().decode(SearchJokesModel.self, from: data)
                    
                    //Get back to the main queue
                    DispatchQueue.main.async {
                        print(JokesResult)
                        self.JokeResult = JokesResult.results
                        self.ResultTB.reloadData()
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
    @IBAction func SearchBtn(_ sender:UIButton){
        self.Loading.startAnimating()
        
        let TextInSearch = SearchTxt.text
        SearchJokesAndCheckConnection(SearchWord: TextInSearch ?? "" )
        
    }
    
}



extension SearchJokeVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JokeResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeachJokeCell", for: indexPath) as! SeachJokeCell
        cell.jokeslbl.text = JokeResult[indexPath.row].joke
        return cell
    }
    
    
}
