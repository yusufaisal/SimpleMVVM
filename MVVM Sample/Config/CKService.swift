//
//  CKService.swift
//  MVVM Sample
//
//  Created by iSal on 27/04/20.
//  Copyright © 2020 iSal. All rights reserved.
//

import Foundation
import CloudKit

class CKService {
    static let shared: CKService = {
        return CKService()
    }()
    
    var recordID:CKRecord.ID?
    private var defaultContainer = CKContainer.default() {
        didSet {
            self.defaultContainer.fetchUserRecordID { (recordID, error) -> Void in
                if let responseError = error {
                    self.errorHandler(error: responseError)
                } else if let userRecordID = recordID {
                    self.recordID = userRecordID
                }
            }
        }
    }
    
    func addDummyNotes(){
        for _ in 0...2{
            let rec = CKRecord(recordType: "Notes")
            rec["title"] = "Title"
            rec["body"] = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            let publicData = defaultContainer.publicCloudDatabase
            publicData.save(rec) { (record:CKRecord?, error:Error?) in
                if error == nil{
                    print("saved")
                }else{
                    print(error as Any)
                }
            }
        }
        
    }
    
    func fetchNotes(complete: @escaping (_ instance: [Note]?, _ error: NSError?) -> ()){
        let pred = NSPredicate(value: true)
        let sort = NSSortDescriptor(key: "creationDate", ascending: false)
        let query = CKQuery(recordType: "Notes", predicate: pred)
        query.sortDescriptors = [sort]
        defaultContainer.publicCloudDatabase.perform(query, inZoneWith: nil) {[self] results, error in
            if let error = error {
                self.errorHandler(error: error)
                complete(nil,error as NSError)
            } else if let checkedResults = results {
                let notes = self.parseNoteResults(records: checkedResults)
                complete(notes,nil)
            }
        }
    }
    
    private func parseNoteResults(records: [CKRecord]) -> [Note]{
        var notes = [Note]()
        
        records.forEach { (record) in
            notes.append(Note(record:record))
        }
        
        return notes
    }
    
    private func errorHandler(error: Error) {
        print("CloudKit Message :: ",error.localizedDescription)
    }
}
