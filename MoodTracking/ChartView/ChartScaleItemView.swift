import SwiftUI

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

struct ChartScaleItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChartScaleItemView(value: 0, title: "")
    }
}

