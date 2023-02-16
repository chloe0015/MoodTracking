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
                
                GroupBox ("Mood History") {
                    Chart {
                        ForEach(0..<chartViewModel.filterResult.count, id: \.self) { index in
                            LineMark(x: PlottableValue.value("", chartViewModel.filterResult[index].time!.formatted(date: .numeric, time: .omitted)), y: PlottableValue.value("", chartViewModel.filterResult[index].scale))
                                //smooth curve
                                .interpolationMethod(.catmullRom)
                                .foregroundStyle(.gray)
                                .symbol() {
                                    // circle connection
                                    Circle()
                                        .fill(.green)
                                        .frame(width: 10)
                                }

                        }
                        //YAxis left
                    }.chartYAxis {
                        AxisMarks(position: .leading)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width-20, height: 200).border(.gray, width: 2)
                    .groupBoxStyle(WhiteGroupBoxStyle())
                Spacer()
            }
            .navigationTitle("ColorMood")
            .navigationBarTitleDisplayMode(.inline)
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
                Text(String(value))
                    .font(.system(size: 17, weight: .semibold))
                Text(title)
                    .font(.system(size: 14, weight: .medium))
            }
        }
        
    }
}


// charts background white
struct WhiteGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.content
            .padding(.top, 30)
            .padding(20)
            .background(.white)
            .cornerRadius(20)
            .overlay(
                configuration.label.padding(10),
                alignment: .topLeading
            )
    }
}

