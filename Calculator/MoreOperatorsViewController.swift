//
//  MoreOperatorsViewController.swift
//  MoreOperatorsViewController
//
//  Created by Jared Kozar on 9/10/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoreOperatorsViewController: UICollectionViewController {
    let operators = ["(", ")", "^", "%", "√"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        let nib = UINib(nibName: "operatorCellView", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "operatorCellView")
        
        // Register cell classes

        title = "More Operators"
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return operators.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "operatorCellView", for: indexPath) as! operatorCellView
        cell.cellLabel.text = operators[indexPath.row]
        
        // Configure the cell
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let opCell = collectionView.cellForItem(at: indexPath) as! operatorCellView
        selectedSpecialOp = opCell.cellLabel.text!
        NotificationCenter.default.post(name: Notification.Name( "updateText"), object: nil)
        
    }
}
