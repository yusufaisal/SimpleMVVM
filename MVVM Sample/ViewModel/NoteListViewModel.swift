//
//  NoteListViewModel.swift
//  MVVM Sample
//
//  Created by iSal on 27/04/20.
//  Copyright © 2020 iSal. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NoteListViewModel {
    var notes: BehaviorRelay<[Note]> = BehaviorRelay<[Note]>.init(value: [])
    
    init() {
        self.fetchNotes()
    }
    
    public func fetchNotes(){
        CKService.shared.fetchNotes { (notes, error) in
            if let notes = notes {
                self.notes.accept(notes)
            }
        }
    }
}
