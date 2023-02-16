import CoreData



class CoreDataManager {
    
    static let share = CoreDataManager()
    let viewContext = PersistenceController.shared.container.viewContext
    
    // add coredata
    func addOneMood(color: Int64, shapeImage: String?, scale: Int64?, diary: String?) -> (isSuccess: Bool,msg: String){
       let mood = Mood(context: viewContext)
        
        mood.time = Date()
        //Calendar.current.date(byAdding: .day, value: -3, to: Date(), wrappingComponents: false)
        mood.uuid = UUID().uuidString
        mood.color = color
        mood.shapeImage = shapeImage
        mood.scale = scale ?? 0
        mood.diary = diary
        do {
            try viewContext.save()
            return (true,"Save success")
        } catch  {
            return (false,error.localizedDescription)
        }
    }
    
    public func deleteCounter(mood: Mood) {
        do {
            let fetchRequest = NSFetchRequest<Mood>(entityName: "Mood")
            var moodList: [Mood] = []
            moodList = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            print("found \(moodList.count) mood")
            for item in moodList where mood == item{
                PersistenceController.shared.container.viewContext.delete(mood)
                break
            }
            try PersistenceController.shared.container.viewContext.save()
        }
        catch {
            print("Error creating new counter. \(error), \(error.localizedDescription)")
        }
    }
}

