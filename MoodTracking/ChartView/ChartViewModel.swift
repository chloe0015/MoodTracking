

import Foundation
import CoreData

struct ChartScaleModel {
    var days: Int = 0
    var negative: Int = 0
    var neutral: Int = 0
    var positive: Int = 0
}

class ChartViewModel:NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    
    private var requestResultController: NSFetchedResultsController<Mood>
    @Published var filterResult = [Mood]()
    
    @Published var chartScaleModel = ChartScaleModel()
    
    override init() {
        let sortDescriptors: [NSSortDescriptor] = [.init(key: "time", ascending: true)]
        let request:NSFetchRequest<Mood> =  NSFetchRequest(entityName: "Mood")
        request.sortDescriptors = sortDescriptors
        //request.predicate = predicate
        let requestResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: PersistenceController.shared.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        self.requestResultController = requestResultController
        super.init()
        requestResultController.delegate = self
        try? requestResultController.performFetch()
        updateData()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    // core data change to updateData
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        updateData()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        //updateData()
    }
    
    
    var results: [Mood] {
        
        return requestResultController.fetchedObjects ?? []
    }
    
    func updateData() {
        var results = self.results
        var resultsTemp = [Mood]()
        let calendar = Calendar.current
        //time had sort
        if var compare = results.first {
            results.remove(at: 0)
            resultsTemp.append(compare)
            // get the day first data
            results.forEach { mood in
                let dateStart = calendar.startOfDay(for: compare.time!)
                let dateEnd = calendar.date(byAdding: .day, value: 1, to: dateStart)!
                
                if mood.time!.timeIntervalSince1970 < dateStart.timeIntervalSince1970 || mood.time!.timeIntervalSince1970 >= dateEnd.timeIntervalSince1970 {
                    resultsTemp.append(mood)
                    compare = mood
                    
                }
            }
            //only  show 7 days
            if resultsTemp.count > 7 {
                resultsTemp =  resultsTemp.suffix(7)
            }
            
            let filter1 = resultsTemp.filter({$0.scale >= 1 && $0.scale <= 4})
            let filter2 = resultsTemp.filter({$0.scale >= 5 && $0.scale <= 6})
            let filter3 = resultsTemp.filter({$0.scale >= 7 && $0.scale <= 10})
            chartScaleModel.negative = filter1.count
            chartScaleModel.neutral = filter2.count
            chartScaleModel.positive = filter3.count
            
        } else {
            chartScaleModel.negative = 0
            chartScaleModel.neutral = 0
            chartScaleModel.positive = 0
        
        }
        chartScaleModel.days = resultsTemp.count
        filterResult = resultsTemp
        
        
       print("update")
    }
}
