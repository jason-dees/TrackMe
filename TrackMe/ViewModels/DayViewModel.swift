//
//  DayViewModel.swift
//  TrackMe
//
//  Created by Jason Dees on 12/15/22.
//

import Combine
import CoreData
import Foundation

class DayViewModel: ObservableObject {
    @Published var storedDays: [StoredDay] = [] {
        willSet {
            NSLog("Updating days")
        }
        didSet {
            self.days = self.storedDays.map { $0.day }
        }
    }
    
    @Published var days: [Day] = []
    
    private var cancellable: AnyCancellable?
    
    //= DayController.shared.days.eraseToAnyPublisher()
    convenience init(context moc: NSManagedObjectContext) {
        self.init(publisher: DayController(context: moc).days.eraseToAnyPublisher())
    }
    
    init(publisher: AnyPublisher<[StoredDay], Never>) {
        cancellable = publisher.sink { days in
            NSLog("Updating days")
            self.storedDays = days
        }
    }
    
    public var today: Day {
        get {
            self.days.first ?? Day()
        }
    }
}
