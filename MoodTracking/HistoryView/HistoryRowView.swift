import SwiftUI

struct HistoryRowView: View {
     var mood: Mood
    var body: some View {
        VStack {
            
            VStack(alignment: .leading, spacing: 5) {
            
                HStack(alignment: .center, spacing: 5) {
                    Text("Color:")
                    Spacer().frame(width: 20, height: 20)
                        .background(self.getColor())
                        .cornerRadius(10)
                    Spacer()
                    
                    Text (mood.time!.formatted(date: .numeric, time: .standard))
                }.padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                
                Text("Scale:" +  String(mood.scale))
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                
                Text("Diary:" +  (mood.diary ?? ""))
                    .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                
                if let shapeImage =  mood.shapeImage{
                    HStack {
                        Text("Shape:")
                            .padding(.leading, 15)
                        Image(shapeImage)
                            .resizable()
                            .renderingMode(.template)
                            .frame(width: 100, height: 100)
                            .foregroundColor(self.getColor())
                    }.padding(.top, -5).padding(.bottom, 10)
                    
                }
            }.background(Color.white)
                .cornerRadius(8)
                .shadow(color: .gray, radius: 10, x: 5, y: 5)
        }.background(Color.clear)
            .padding(EdgeInsets(top: 8, leading: 15, bottom: 8, trailing: 15))
        
    }
    
    //rgb to color
    func getColor() -> Color {
        
        let iRed1 = (mood.color & 0xFF000000) >>  24
        let iGreen1 = (mood.color & 0xFF0000) >> 16
        let iBlue1 = (mood.color & 0xFF00) >> 8
        let iAlpha1 = (mood.color & 0xFF)
        return Color(red: Double(iRed1)/255.0, green: Double(iGreen1)/255.0, blue: Double(iBlue1)/255.0,opacity: Double(iAlpha1)/255.0)
    }
    

}

struct HistoryRowView_Previews: PreviewProvider {
    static var previews: some View {
//        HistoryRowView(mood: .constant(Mood(context: PersistenceController.shared.container.viewContext)))
        HistoryRowView(mood: Mood(context: PersistenceController.shared.container.viewContext))
    }
}

