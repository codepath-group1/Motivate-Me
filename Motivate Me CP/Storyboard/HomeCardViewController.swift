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

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    @IBOutlet weak var swipeCard: UIView!
    
    var homeCardQuotes : [Quote] = []
    var cardFrame : CGRect? = nil
    var quotes : [Quote] = []
    var quoteIndex:Int = 0
    var swipedRight : Bool? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        dislikeImage.alpha = 0
        likeImage.alpha = 0
        loadQuotes()
        updateUIWith(quotes[quoteIndex])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var quoteToShow = quotes[quoteIndex]
        let id = UserDefaults.standard.integer(forKey: "quoteId")
        if id > 0 {
            for quote in quotes {
                if quote.id == id {
                    quoteToShow = quote
                    break
                }
            }
        }
        updateUIWith(quoteToShow)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let _ = cardFrame else {
            cardFrame = swipeCard.frame
            return
        }
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
    
    func updateUIWith(_ quote : Quote) {
        quoteLabel.text = quote.text
        authorLabel.text = quote.source?.title
    }
    
    @IBAction func listButtonTapped(_ sender: Any) {
        if let navController = self.navigationController {
            let newVC = (storyboard?.instantiateViewController(withIdentifier: "HomeViewController"))!
            
            var stack = navController.viewControllers
            stack.remove(at: stack.count - 1)       // remove current VC
            stack.insert(newVC, at: stack.count) // add the new one
            navController.setViewControllers(stack, animated: true) // boom!
        }
    }
    
    @IBAction func swipeGesture(_ sender: UIPanGestureRecognizer) {
        
        let swipeCard = sender.view!
        let translationPoint = sender.translation(in: view)
        swipeCard.center = CGPoint(x: view.center.x+translationPoint.x, y: view.center.y+translationPoint.y)
        if sender.state == UIGestureRecognizer.State.ended {
            if swipeCard.center.x < 20 { // Moved to left
                UIView.animate(withDuration: 0.3, animations: {
                    swipeCard.center = CGPoint(x: swipeCard.center.x-300, y: swipeCard.center.y)
                }) { (_) in
                    self.genNewCard()
                }
                swipedRight = false
                return
            }
            else if (swipeCard.center.x > (view.frame.size.width-20)) { // Moved to right
                UIView.animate(withDuration: 0.3, animations: {
                    swipeCard.center = CGPoint(x: swipeCard.center.x+300, y: swipeCard.center.y)
                }) { (_) in
                    self.genNewCard()
                }
                quotes[quoteIndex].isFavorited = true
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                swipedRight = true
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                swipeCard.transform = .identity
                swipeCard.frame = self.cardFrame!
                self.likeImage.alpha = 0
                self.dislikeImage.alpha = 0
            })
        }
        let distanceMoved = swipeCard.center.x - view.center.x
        if distanceMoved > 0 { // moved right side
            likeImage.alpha = abs(distanceMoved)/view.center.x
            dislikeImage.alpha = 0
        }
        else { // moved left side
            dislikeImage.alpha = abs(distanceMoved)/view.center.x
            likeImage.alpha = 0
        }
        swipeCard.transform = CGAffineTransform(rotationAngle: 0.61)
        let divisionParam = 448 / 0.61
        swipeCard.transform = CGAffineTransform(rotationAngle: distanceMoved/CGFloat(divisionParam))
        
    }
    
    func genNewCard() {
        swipeCard.transform = .identity
        swipeCard.frame = cardFrame!
        swipeCard.alpha = 0
        dislikeImage.alpha = 0
        likeImage.alpha = 0
        quoteIndex += 1
        if quoteIndex >= quotes.count { quoteIndex = 0 }
        updateUIWith(quotes[quoteIndex])
        swipeCard.layoutIfNeeded()
        UIView.animate(withDuration: 0.3, animations: {
            self.swipeCard.alpha = 1
            
        })
    }
    
    @IBAction func undoButton(_ sender: Any) {
        guard let swipedRight = swipedRight,
              quoteIndex > 0 else {
            return 
        }
        self.dislikeImage.alpha = 0
        self.likeImage.alpha = 0
        swipeCard.transform = .identity
        
        quoteIndex -= 1
        updateUIWith(quotes[quoteIndex])
        if swipedRight {
            swipeCard.center = CGPoint(x: swipeCard.center.x+300, y: swipeCard.center.y)
            quotes[quoteIndex].isFavorited = false
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        } else {
            swipeCard.center = CGPoint(x: swipeCard.center.x-300, y: swipeCard.center.y)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.swipeCard.frame = self.cardFrame!
        }
    }

}

