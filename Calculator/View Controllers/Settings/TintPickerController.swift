import UIKit
import Foundation
import Communicator

class TintPickerController: UITableViewController, UIColorPickerViewControllerDelegate {

    let nc = NotificationCenter.default
    var checkmark: Int = 0
    
    override func viewDidLoad() {
        //sets the correct tint color when the view is loaded
        super.viewDidLoad()
        
        title = "Tint Color"
        listofthemes = listofthemes.load()

        NotificationCenter.default.addObserver(self, selector: #selector(newThemeAdded(_:)), name: NSNotification.Name( "newThemeAdded"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .done, target: self, action: #selector(addNewTheme))
        
    }

    @objc func newThemeAdded(_ notification: Notification) {
        listofthemes.save()
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listofthemes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //finds the first instance of the currently selected tint color in the themes array. If the index.row value equals the place of the currently selected tint color value in the array, that row is given a checkmark accessory
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tintColorCell", for: indexPath)
        cell.textLabel?.text = listofthemes[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

     
        
        //sets selectedColor to the label of the selected table cell, and calls the tintColor function in GlobalSettings. The navigation bar is updated with the UIColor that is returned.
        currenttheme = listofthemes[indexPath.row]
        currenttheme.savecurrenttheme()
        view.tintColor = currenttheme.regularcolor
        navigationController?.navigationBar.tintColor = view.tintColor
        
        if matchPhoneTint == true {
            let regularcolorasstring = StringFromUIColor(color: currenttheme.regularcolor)
            let operatorcolorasstring = StringFromUIColor(color: currenttheme.operatorcolor)
            
             let message = ImmediateMessage(identifier: "message", content: ["regularColor": regularcolorasstring, "operatorColor": operatorcolorasstring, "matchPhoneTintStatus": matchPhoneTint])
             
             Communicator.shared.send(message) { error in
                 print("Error sending immediate message", error)
             }
        }
       
    
        
        NotificationCenter.default.post(name: Notification.Name( "updateSettingsText"), object: nil)
        navigationController?.popViewController(animated: true)

        NotificationCenter.default.post(name: Notification.Name( "updateTint"), object: nil)

    }

    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let selectedtheme = listofthemes[indexPath.row]
        //saves the row the user bought the context menu appear on in row
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in

            let  editThemeAction = UIAction(title: "Edit Theme", image: UIImage(systemName: "pencil")) { [self] _ in
                UserDefaults.standard.set(indexPath.row, forKey: "row")
                isCurrentlyEditingTheme = true

                showNewThemeScreen(index: indexPath.row)
            }
            
            let deleteThemeAction = UIAction(
                //deletes the current cell
              title: "Delete",
              image: UIImage(systemName: "trash"),
                attributes: .destructive) { [self] _ in
                
                    listofthemes.remove(at: indexPath.row)
                    listofthemes.save()
                    self.tableView.reloadData()

            }
            
            return UIMenu(title: "", children: [editThemeAction, deleteThemeAction])
        }
    }
    
    @objc func addNewTheme() {
        showNewThemeScreen(index: nil)
    }
    
    func showNewThemeScreen(index: Int?) {
        let vc = NewThemeController()
        let navigationController = UINavigationController(rootViewController: vc)

        vc.index = index
        if let picker = navigationController.presentationController as? UISheetPresentationController {
            picker.detents = [.medium()]
            picker.prefersGrabberVisible = true
            picker.preferredCornerRadius = 5.0
        }
        
        self.present(navigationController, animated: true)
    }
}


