//
//  MasterViewController.swift
//  DDGTheSimpsons
//
//  Created by Eduardo Santiz on 5/20/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UISplitViewControllerDelegate {
    
    let vm = DDGViewModel()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vm.downloadJSON {
            DispatchQueue.main.async {
                print("We are Downloading the data.")
                self.vm.fillArrayWithData()
                self.tableView.reloadData()
            }
        }
        
        splitViewController?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        splitViewController?.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }

}

// MARK: - TableView Delegate Methods.
extension MasterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        print(indexPath.row)
        destination.characterIndex = indexPath.row
        destination.vm = self.vm
        
        splitViewController?.showDetailViewController(destination, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TableView Datasource Methods.
extension MasterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getArrayWithDataSize() ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = vm.getCharactersName(index: indexPath.row)
        
        return cell
    }
    
}
