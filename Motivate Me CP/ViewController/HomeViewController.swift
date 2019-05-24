//
//  HomeViewController.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 4/30/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit
import CoreData
class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var homeListButton: UIButton!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var homeCardButton: UIBarButtonItem!
    
    
    var quoteArrays: [String] = ["The Way Get Started Is To Quit Talking ANd Begin Doing.", "The Pessimist Sees Difficulty In Every Opportunity. The Optimist Sees Opportunity In Every Difficulty.", "Don't Let Yesterday Take Up Too Much Of Today.","You Learn More From Failure Than From Success. Don't Let It Stop You. Failure Builds Character.", "It's Not Whether You Get Knocked Down, It's Whether You Get Up." , "If You Are Working On Something That You Really Care About, You Don't Have To Be Pushed. The Vision Pulls You.", "People Who Are Crazy Enough To Think They Can Change The The World, Are The One Who Do. "]
    var authorArrays: [String] = ["- Walt Disney", "- Winston Churchill", "- Will Rogers", "- Unknown", "- Vince Lombardi", "- Steve Jobs", "- Rob Siltanen" ]
   var count:Int = 0
    var favoriteQuotes : [Quote] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //updating TableView
        TableView.dataSource = self
        TableView.delegate = self
        self.TableView.reloadData()
        //loadFavoriteQuote()
        //self.navigationItem.title = "Home"
        // Do any additional setup after loading the view.
    }
    //asking for number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteArrays.count
        //return 0
    }
    //asking the number of cells in the specific row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteListCell") as! QuoteListCell
        if count < (quoteArrays.count - 1) {
              count += 1
        }
        cell.quoteLabel.text = quoteArrays[count]
        cell.authorLabel.text = authorArrays[count]
        return cell
        
        //tutorial
        //movies is an array dictionary
        //let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        //let movie = movies[indexPath.row]
        //let title = movie["title"] as! String
        //let synopsis = movie["overview"] as! String
        //cell.titleLabel!.text = title
        //cell.synopsisLabel.text = synopsis
    
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
