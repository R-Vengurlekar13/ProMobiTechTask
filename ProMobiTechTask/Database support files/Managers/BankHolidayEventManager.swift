//
//  BankHolidayEventManager.swift
//  ProMobiTechTask
//
//  Created by Rahul Vengurlekar on 01/09/21.
//

import Foundation

// Class to manage operations of BankHolidayEvent Entity
class BankHolidayEventManager {
    
    private init() { }
    
    static let shared = BankHolidayEventManager()
    
    // add new entries
    // parameter - recordList: all events list
    func create(recordList: [EventModel]) {
        
        recordList.forEach { (record) in
            
            let event = BankHolidayEvent(context: PersistentStorage.shared.context)
            event.title = record.title
            event.date = record.date
            event.bunting = record.bunting ?? false
            event.notes = record.notes
        }
        
        PersistentStorage.shared.saveContext()
    }
    
    // read all records
    func getAll() -> [BankHolidayEvent]? {
        
        let eventList = PersistentStorage.shared.fetchManagedObject(managedObject: BankHolidayEvent.self)
        return eventList
    }
    
    // delete all records
    func deleteAll() {
        
        guard let allEvents = self.getAll() else {  return  }
        allEvents.forEach { (event) in
            
            PersistentStorage.shared.context.delete(event)
        }
        PersistentStorage.shared.saveContext()
    }
}


extension BankHolidayEventManager {
    
    // method to convert managed object model to usable model
    // paramter - eventList: events managed object list
    func convert(eventList:[BankHolidayEvent])-> [EventModel] {
        
       return eventList.compactMap { (event) -> EventModel in
        return EventModel(title: event.title, date: event.date, notes: event.notes, bunting: event.bunting, isExpanded: false)
        }
    }
    
}
