//
//  HomeViewController.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 4/30/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var homeListButton: UIButton!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var homeCardButton: UIBarButtonItem!
    
    var quotes : [Quote] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //updating TableView (testing code)
        TableView.dataSource = self
        loadQuotes()
        self.TableView.reloadData()
        
    }
    
    func loadQuotes() {
        let fetchRequest: NSFetchRequest<QuoteData> = QuoteData.fetchRequest()
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let moc = delegate.persistentContainer.viewContext
        
        do {
            let quoteDatas = try moc.fetch(fetchRequest)
            // TODO: extract only favorited quotes
            if let results = quoteDatas[0].results as? Set<Quote> {
                quotes = Array(results)
            }
        } catch {
            fatalError("There was an error fetching the list of favorited quotes!")
        }
    }
    
    @IBAction func cardButtonTapped(_ sender: Any) {
        if let navController = self.navigationController {
            let newVC = (storyboard?.instantiateViewController(withIdentifier: "HomeCardViewController"))!
            var stack = navController.viewControllers
            stack.remove(at: stack.count - 1)       // remove current VC
            stack.insert(newVC, at: stack.count) // add the new one
            navController.setViewControllers(stack, animated: true) // boom!
        }
    }
}

extension HomeViewController : UITableViewDataSource {
    //asking for number of row
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteListCell") as! QuoteListCell
        cell.quoteLabel.text = quotes[indexPath.row].text
        cell.authorLabel.text = quotes[indexPath.row].source?.title ?? "No Name"
        return cell
    }
}
