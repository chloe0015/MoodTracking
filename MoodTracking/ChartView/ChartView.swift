import SwiftUI
import Charts


struct ChartView: View{
    @ObservedObject var chartViewModel: ChartViewModel
    
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
                    Text("\(chartViewModel.chartScaleModel.days)days")
                        .font(.system(size: 22, weight: .bold))
                        .padding(EdgeInsets(top: -5, leading: 10, bottom: 10, trailing: 10))
                    
                    HStack(alignment: .center, spacing: 5) {
                        
                        ChartScaleItemView(value: chartViewModel.chartScaleModel.negative, title: "negative days")
                        ChartScaleItemView(value: chartViewModel.chartScaleModel.neutral, title: "neutral days")
                        ChartScaleItemView(value: chartViewModel.chartScaleModel.positive, title: "positive days")
                    }.padding(.bottom, 10)
                }
                    .frame(width: UIScreen.main.bounds.width-20)
                    .border(.gray, width: 2)
            }
        }
    }
}


struct Previews_ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(chartViewModel: ChartViewModel())
    }
}

struct ChartScaleItemView: View {
    var value: Int
    var title: String
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 2, height: 30)
                .background(Color.gray)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 3))
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Spacer()
                }
                Text("1")
                    .font(.system(size: 17, weight: .semibold))
                Text("Title")
                    .font(.system(size: 14, weight: .medium))
            }
        }
        
    }
}

