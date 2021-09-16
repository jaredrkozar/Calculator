import UIKit

class HistoryClassController: UITableViewController {
    var historyCalcNums: String = ""
    
    @IBOutlet var clearButton: UIBarButtonItem!
    @IBOutlet var noHistory: UILabel!
    
    override func viewDidLoad() {
        //sets up the HistoryClassController by applying the current tint color, and if the user didn't perform any claculations, displays a message onscreen explaining the function of this screen
        super.viewDidLoad()
        
        view.tintColor = currenttheme.regularcolor

        navigationController?.navigationBar.tintColor = view.tintColor
        
        checkHistory()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyNums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //sets the text label to elements of the historyNumsList array, and since this screen uses dynamic prototype cells, gives it the cell idetifier so it can properly dequeue the cells in the History screen.
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        cell.textLabel?.text = historyNums[indexPath.row]
        return cell
    }

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        //dismisses the History screen if the done button is tapped
        dismiss(animated: true, completion: nil)
    }

    @IBAction func clearButton(_ sender: UIButton) {
        //if the clear butto is tapped, an alert pops up asking if the user wants to clear the history
        let clearAlert = UIAlertController(title: "Are you sure you want to clear your calculation history?", message: "This cannot be undone.", preferredStyle: .alert)
        
        clearAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: clearHistory))
        
        clearAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(clearAlert, animated: true)
    }
    
    func checkHistory() {
        //if there are no elements in the historyNumsList array (i.e. if the user hasn't performed any calculations yet), a message is displayed telling the user to perform some calculations, and those calculations will appear on this screen.
        if historyNums.count == 0 {
            noHistory.text = "No history available. Perform some calculations, and you'll see them here."
            clearButton.isEnabled = false
        } else {
            noHistory.text = ""
        }
    }
    func clearHistory(action: UIAlertAction) {
        //if the user tapped Clear, the number of elements in the array is set to 0, the array is savednwith userdefaults, the tablle is reloaded, and a message is displayed on scrreen telling users to perform a calculation.
        historyNums.removeAll()
        tableView.reloadData()
        checkHistory()
    }
}
