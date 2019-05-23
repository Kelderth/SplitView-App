//
//  DetailViewController.swift
//  DDGTheSimpsons
//
//  Created by Eduardo Santiz on 5/20/19.
//  Copyright © 2019 EduardoSantiz. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var vm: DDGViewModel = DDGViewModel()
    var characterIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = vm.getCharactersName(index: characterIndex)
        

    }

    var detailItem: NSDate? {
        didSet {
            // Update the view.
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        detailDescriptionLabel.text = vm.getCharactersName(index: characterIndex)
        
    }


}

