import SwiftUI
struct HomeView: View {
    @State var selectedColor: Color = .red
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 10) {
                    
                    //title
                    Text("How Are You Today?")
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .padding(.top, 20)
                    Spacer().frame(height: 20)
                    
                    //choose color
                    Text("Choose your mood color")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.top, 20)
                    ColorPicker("", selection: $selectedColor)
                        .labelsHidden()
                    
            
                    }
                }
            }
        }
    }
}
