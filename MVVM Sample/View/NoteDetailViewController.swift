//
//  DetailNoteViewController.swift
//  MVVM Sample
//
//  Created by iSal on 27/04/20.
//  Copyright © 2020 iSal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NoteDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }

}
