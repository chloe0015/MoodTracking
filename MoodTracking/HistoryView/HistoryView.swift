

import SwiftUI
import CoreData


struct HistoryView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    // MARK: Fetching Task
    @FetchRequest (entity: Mood.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Mood.time, ascending: false)], predicate: nil, animation: .easeInOut)
    var results: FetchedResults<Mood>
    var body: some View {
        NavigationView{
            List(results) { result in
                ForEach(0..<results.count,id: \.self) { index in
                    HistoryRowView(mood: results[index])

                }
                }.listRowInsets(EdgeInsets())
            }.listStyle(.plain).padding(0)

                
           
            .navigationTitle("ColorMood")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}

