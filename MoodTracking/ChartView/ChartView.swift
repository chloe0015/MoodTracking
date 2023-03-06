import SwiftUI
import Charts


struct ChartView: View{
    @ObservedObject var chartViewModel: ChartViewModel

    @State private var rect1: CGRect = .zero

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
                        ChartScaleItemView(value: chartViewModel.chartScaleModel.negative, title: "Negative days")
                        ChartScaleItemView(value: chartViewModel.chartScaleModel.neutral, title: "Neutral days")
                        ChartScaleItemView(value: chartViewModel.chartScaleModel.positive, title: "Positive days")
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
                                        .fill(Color(hue: 0.226, saturation: 1.0, brightness: 0.78, opacity: 0.481))
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
            .frame(width: UIScreen.main.bounds.width).padding(0)
                .background(RectGetter(rect: $rect1))
            .navigationTitle("ColorMood")
            .navigationBarItems(trailing: Button(action: {
                saveAndShare()
            }, label: {
                Image(systemName: "square.and.arrow.up")
            }))
        .navigationBarTitleDisplayMode(.inline)
        }
    }


    func saveAndShare() {
        guard let uiimage = currentWindow()?.rootViewController?.view.asImage(rect: self.rect1)  else {
            return
        }
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        let filePath = "\(rootPath)/share.jpg"
        let imageData = uiimage.jpegData(compressionQuality: 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        let url:URL = URL.init(fileURLWithPath: filePath)
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        currentWindow()?.rootViewController!.present(av, animated: true, completion: nil)
    }
}



struct Previews_ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(chartViewModel: ChartViewModel())
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


