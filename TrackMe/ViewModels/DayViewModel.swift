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
    
    init(dayPublisher: AnyPublisher<[StoredDay], Never> = DayController.shared.days.eraseToAnyPublisher()) {
        cancellable = dayPublisher.sink { days in
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
