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
    
    //testing code (making quote array to test out cell working) 
    var quoteArrays: [String] = ["The Way Get Started Is To Quit Talking ANd Begin Doing.", "The Pessimist Sees Difficulty In Every Opportunity. The Optimist Sees Opportunity In Every Difficulty.", "Don't Let Yesterday Take Up Too Much Of Today.","You Learn More From Failure Than From Success. Don't Let It Stop You. Failure Builds Character.", "It's Not Whether You Get Knocked Down, It's Whether You Get Up." , "If You Are Working On Something That You Really Care About, You Don't Have To Be Pushed. The Vision Pulls You.", "People Who Are Crazy Enough To Think They Can Change The The World, Are The One Who Do. "]
    var authorArrays: [String] = ["- Walt Disney", "- Winston Churchill", "- Will Rogers", "- Unknown", "- Vince Lombardi", "- Steve Jobs", "- Rob Siltanen" ]
    var count:Int = 0
    //var homeListQuotes : [Quote] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //updating TableView (testing code)
        TableView.dataSource = self
        TableView.delegate = self
        self.TableView.reloadData()
        //loadHomeListQuote()
    }
    //clicked homeCard or HomeList Button change
    @IBAction func HomeCardButClicked(_ sender: Any) {
        print("HomeCardButPressed")
        self.performSegue(withIdentifier:"HomeCardViewSegue", sender: self)
    }
    @IBAction func HomeListButClicked(_ sender: Any) {
        print("HomeListButPressed")
    }
    
    /*func loadHomeListQuote(){
        let fetchRequest: NSFetchRequest<QuoteData> = QuoteData.fetchRequest()
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let moc = delegate.persistentContainer.viewContext
        
        do {
            let quoteDatas = try moc.fetch(fetchRequest)
            // TODO: extract only favorited quotes
            if let results = quoteDatas[0].results as? Set<Quote> {
                homeListQuotes = Array(results)
            }
        } catch {
            fatalError("There was an error fetching the list of favorited quotes!")
        }
    }
}*/
/*
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homeListQuotes.count
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteListCell", for: indexPath) as!QuoteListCell
    cell.quoteLabel = homeListQuotes[indexPath.row]
    return cell
    
}*/
    //asking for number of row
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //testing return array.count
        return quoteArrays.count
       // return HomeListQuotes.count
    }
    //asking the number of cells in the specific row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //testing code
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteListCell") as! QuoteListCell
        if count < (quoteArrays.count - 1) {
              count += 1
        }
        cell.quoteLabel.text = quoteArrays[count]
        cell.authorLabel.text = authorArrays[count]
        return cell
        
    
    }

}

