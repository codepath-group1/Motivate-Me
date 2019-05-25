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

    
    @IBOutlet weak var QuoteLabel: UILabel!
    @IBOutlet weak var AuthorLabel: UILabel!
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    @IBOutlet weak var SwipeCard: UIView!
    
    var homeCardQuotes : [Quote] = []
   
    var quoteArrays: [String] = ["The Way Get Started Is To Quit Talking ANd Begin Doing.", "The Pessimist Sees Difficulty In Every Opportunity. The Optimist Sees Opportunity In Every Difficulty.", "Don't Let Yesterday Take Up Too Much Of Today.","You Learn More From Failure Than From Success. Don't Let It Stop You. Failure Builds Character.", "It's Not Whether You Get Knocked Down, It's Whether You Get Up." , "If You Are Working On Something That You Really Care About, You Don't Have To Be Pushed. The Vision Pulls You.", "People Who Are Crazy Enough To Think They Can Change The The World, Are The One Who Do. "]
    var authorArrays: [String] = ["- Walt Disney", "- Winston Churchill", "- Will Rogers", "- Unknown", "- Vince Lombardi", "- Steve Jobs", "- Rob Siltanen" ]
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dislikeImage.alpha = 0
        likeImage.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    @IBAction func HomeCardButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "HomeListViewSegue", sender: self)
        print("HomeListButtonClicked")
    }
    
    @IBAction func swipeGesture(_ sender: UIPanGestureRecognizer) {
        
        
        let SwipeCard = sender.view!
        let translationPoint = sender.translation(in: view)
        SwipeCard.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
        if sender.state == UIGestureRecognizer.State.ended {
            if SwipeCard.center.x < 20 { // Moved to left
                UIView.animate(withDuration: 0.3, animations: {
                    SwipeCard.center = CGPoint(x: SwipeCard.center.x-300, y: SwipeCard.center.y)
                })
                return
            }
            else if (SwipeCard.center.x > (view.frame.size.width-20)) { // Moved to right
                UIView.animate(withDuration: 0.3, animations: {
                    SwipeCard.center = CGPoint(x: SwipeCard.center.x+300, y: SwipeCard.center.y)
                })
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                SwipeCard.center = self.view.center
                self.likeImage.alpha = 0
                self.dislikeImage.alpha = 0
            })
        }
        let distanceMoved = SwipeCard.center.x - view.center.x
        if distanceMoved > 0 { // moved right side
            likeImage.alpha = abs(distanceMoved)/view.center.x
            dislikeImage.alpha = 0
        }
        else { // moved left side
            dislikeImage.alpha = abs(distanceMoved)/view.center.x
            likeImage.alpha = 0
        }
        SwipeCard.transform = CGAffineTransform(rotationAngle: 0.61)
        print(self.view.frame.size)
        let divisionParam = 448 / 0.61
        //let distanceMoved = SwipeCard.center.x - view.center.x
        SwipeCard.transform = CGAffineTransform(rotationAngle: distanceMoved/CGFloat(divisionParam))
        //SwipeCard.transform = .identity
    }
    
    @IBAction func undoButton(_ sender: Any) {
        SwipeCard.center = self.view.center
        self.dislikeImage.alpha = 0
        self.likeImage.alpha = 0
        SwipeCard.transform = .identity
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
