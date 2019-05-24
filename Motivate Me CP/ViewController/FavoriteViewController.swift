//
//  FavoriteViewController.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/2/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController {

    var favoritedQuotes : [Quote] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadFavoritedQuote()
    }
    
    func loadFavoritedQuote() {
        let fetchRequest: NSFetchRequest<QuoteData> = QuoteData.fetchRequest()
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let moc = delegate.persistentContainer.viewContext
        
        do {
            let quoteDatas = try moc.fetch(fetchRequest)
            // TODO: extract only favorited quotes
            if let results = quoteDatas[0].results as? Set<Quote> {
                favoritedQuotes = Array(results)
            }
        } catch {
            fatalError("There was an error fetching the list of favorited quotes!")
        }
    }
    
}
extension FavoriteViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritedQuotes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        cell.quote = favoritedQuotes[indexPath.row]
        return cell
    }
}
