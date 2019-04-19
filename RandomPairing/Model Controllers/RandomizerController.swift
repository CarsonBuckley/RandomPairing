//
//  RandomizerController.swift
//  RandomPairing
//
//  Created by Carson Buckley on 4/19/19.
//  Copyright © 2019 Launch. All rights reserved.
//

import Foundation
import CloudKit

class PersonController {
    
    //Shared Instance
    static let sharedInstance = PersonController()
    private init() {}
    
    //Source of Truth
    var persons: [Person] = []
    
    let publicDB = CKContainer.default().publicCloudDatabase
    
    //CRUD
    func save(person: Person, completion: @escaping (Bool) -> ()) {
        let record = CKRecord(person: person)
        CKContainer.default().publicCloudDatabase.save(record) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(false)
                return
            }
            guard let record = record,
                let person = Person(ckRecord: record) else { completion(false) ; return }
            self.persons.append(person)
            completion(true)
            
        }
    }
    
    func addPersonWith(name: String, completion: @escaping (Person?) -> Void) {
        let newPerson = Person(name: name)
        let newRecord = CKRecord(person: newPerson)
        
        publicDB.save(newRecord) { (record, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let record = record else { return }
            let person = Person(ckRecord: record)
            guard let unwrappedPerson = person else { return }
            self.persons.append(unwrappedPerson)
            
            completion(person)
        }
    }
    
    func fetchPersons(completion: @escaping ([Person]?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: PersonConstants.RecordType, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("\(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let records = records else { return }
            let persons: [Person] = records.compactMap { Person(ckRecord: $0) }
            self.persons = persons
            completion(persons)
            
        }
    }
    
//    func deletePerson(personToDelete: Person) {
//        let record = CKRecord(person: personToDelete)
//        CKContainer.default().publicCloudDatabase.delete(withRecordID: CKRecord.ID) { (record, error) in
//
//        }
//    }
    
//        guard let index = persons.index(of: personToDelete) else { return }
//        persons.remove(at: index)
    
}
