//
//  HomeCardViewController.swift
//  Motivate Me CP
//
//  Created by Joy_Wang on 5/24/19.
//  Copyright © 2019 Kazutaka Homma. All rights reserved.
//

import UIKit
import CoreData

class HomeCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func HomeCardButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "HomeListViewSegue", sender: self)
        print("HomeListButtonClicked")
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
