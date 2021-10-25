//
//  AltIconPickerController.swift
//  AltIconPickerController
//
//  Created by JaredKozar on 10/16/21.
//

import UIKit

class AltIconPickerController: UICollectionViewController {

    let icons = [["Green", "Red", "Blue", "Dark Blue", "Orange", "Pink", "Gray", "Yellow"], ["Green (Dark bg)", "Red (Dark bg)", "Blue (Dark bg)", "Dark Blue (Dark bg)", "Orange (Dark bg)", "Pink (Dark bg)", "Gray (Dark bg)", "Yellow (Dark bg)"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        title = "Alternate App Icons"
        
        // Register cell classes
        let nib = UINib(nibName: "AltIconCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "AltIconCell")
        
        collectionView.register(IconCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader , withReuseIdentifier: IconCollectionReusableView.identifier)
        // Do any additional setup after loading the view.
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
        return icons.count
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return icons[section].count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AltIconCell", for: indexPath) as! AltIconCell
        
        cell.appIcon.image = UIImage(named: icons[indexPath.section][indexPath.item])
        cell.appIcon.layer.cornerRadius = 9.0
        // Configure the cell
    
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIApplication.shared.setAlternateIconName(icons[indexPath.section][indexPath.item])
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: IconCollectionReusableView.identifier, for: indexPath) as! IconCollectionReusableView
        
        header.configure()
   
        if indexPath.section == 1 {
            header.label.text = " Dark icons"
        } else {
            header.label.text = " Light icons"
        }
        view.addSubview(header)
        return header
    }
}
