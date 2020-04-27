//
//  ViewController.swift
//  MVVM Sample
//
//  Created by iSal on 27/04/20.
//  Copyright © 2020 iSal. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NoteListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel: NoteListViewModel = NoteListViewModel()
    let diposeBag: DisposeBag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    private func setupTableView(){
        self.viewModel.notes
        .bind(to: tableView.rx.items(cellIdentifier: "NoteCell", cellType: UITableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element.title
            cell.detailTextLabel?.text = element.body
        }
        .disposed(by: diposeBag)
        
        self.tableView.rx
            .setDelegate(self)
            .disposed(by: diposeBag)
        
    }
}

