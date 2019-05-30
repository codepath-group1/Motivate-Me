//
//  QuoteListPickerViewController.swift
//  Motivate Me CP
//
//  Created by Kazutaka Homma on 5/24/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit

protocol QuoteListPickerViewControllerDelegate {
    func quoteListPickerViewControllerWillDisappear(quoteList : QuoteList);
}

class QuoteListPickerViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let quoteLists : [String] = ["Random", "My Favorite"]
    private var lastIndex : Int!
    var delegate : QuoteListPickerViewControllerDelegate?
    var quoteList : QuoteList! {
        didSet {
            lastIndex = quoteLists.firstIndex(of: quoteList)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if isMovingFromParent {
            if let delegate = delegate {
                delegate.quoteListPickerViewControllerWillDisappear(quoteList: quoteList)
            }
        }
    }

}

extension QuoteListPickerViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteListPickerCell", for: indexPath)
        cell.textLabel?.text = quoteLists[indexPath.row]
        if lastIndex == indexPath.row {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

extension QuoteListPickerViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row != lastIndex {
            let lastCell = tableView.cellForRow(at: IndexPath(row: lastIndex, section: 0))
            let newCell = tableView.cellForRow(at: indexPath)
            lastCell?.accessoryType = .none
            newCell?.accessoryType = .checkmark
            lastIndex = indexPath.row
            quoteList = quoteLists[indexPath.row]
        }
    }
}
