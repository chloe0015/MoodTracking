import SwiftUI
import Charts

struct ChartView: View{
    var body: some View {
        NavigationView{
            ScrollView {
                Text("Mood Chart")
                    .font(.system(size: 24, weight: .semibold))
                    .padding(10).frame(width: UIScreen.main.bounds.width - 20, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Spacer()
                    }
                    Text("Posted for")
                        .font(.system(size: 18, weight: .regular))
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 10))
                    Text("No. days")
                        .font(.system(size: 22, weight: .bold))
                        .padding(EdgeInsets(top: -5, leading: 10, bottom: 10, trailing: 10))
                }
            }
        }
    }
}


struct Previews_ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}

