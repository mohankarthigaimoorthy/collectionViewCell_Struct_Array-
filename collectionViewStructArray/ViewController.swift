//
//  ViewController.swift
//  collectionViewStructArray
//
//  Created by Mohan K on 17/02/23.
//

import UIKit

struct Task {
    var id : Int
    var taskName : String
    var colour: UIColor
    var status: Int
    var priority: Int
}

class mycells: UICollectionViewCell {
    @IBOutlet weak var text1: UILabel!
    @IBOutlet weak var text2: UILabel!
    @IBOutlet weak var text3: UILabel!
    
    
    
}
class ViewController: UIViewController {

    var allTasks = [Task(id: 1, taskName: "do", colour: .lightGray, status: 1, priority: 1), Task(id: 2, taskName: "does", colour: .red, status: 2, priority: 2), Task(id: 3, taskName: "did", colour: .green, status: 3, priority: 3)]
    
    @IBOutlet weak var mycellCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        mycellCollection.contentInset = .zero
       }

    @objc private func keyboardWillShow(notification: NSNotification) {
           if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
               mycellCollection.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height , right: 0)
           }

    }

    @IBAction func updateBtn(_ sender: Any) {
        
        if let index = allTasks.firstIndex(where: {$0.id == 1})
        {
            allTasks[index].colour = .blue
            allTasks[index].taskName = "Done"
        }
        DispatchQueue.main.async {
            self.mycellCollection.reloadData()
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allTasks.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1\
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mycellCollection.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! mycells
        cell.text1.text = allTasks[indexPath.item].taskName
        cell.backgroundColor = allTasks[indexPath.item].colour
        cell.text2.text = "\(allTasks[indexPath.item].priority)"
        cell.text3.text = "\(allTasks[indexPath.item].status)"
        return cell
    }
}
