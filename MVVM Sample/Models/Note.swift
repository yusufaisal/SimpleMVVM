//
//  NoteModel.swift
//  MVVM Sample
//
//  Created by iSal on 27/04/20.
//  Copyright © 2020 iSal. All rights reserved.
//

import Foundation
import CloudKit

struct Note {
    var body:String
    var title:String
    
    init(record:CKRecord) {
        self.title = record.value(forKey: "title") as? String ?? ""
        self.body = record.value(forKey: "body") as? String ?? ""
    }
}
