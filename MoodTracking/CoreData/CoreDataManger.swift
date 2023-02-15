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
    
}

