import SwiftUI
struct HomeView: View {
    @State var selectedColor: Color = .red
    @State var scale: String = ""
    let shapeImageNames: [String] = ["shape","shape","shape"]
    @State var selectedShapeImageNameIndex: Int?                                                   //optional value
    
    
    @State var diary: String = ""
    
    @State var showAlert: Bool = false
    @State var alertMsg: String = ""
    @State var alertMsg1: String = ""
    

    func addMood(){
        alertMsg1 = "Add success"
        showAlert = true
    }
    
    func clearMood(){
        selectedColor = Color.red
        scale = ""
        selectedShapeImageNameIndex = nil
        diary = ""
        alertMsg = "Clear success"
        showAlert = true
    }
    
    
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 10) {
                    
                    Text("How Are You Today?")
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .padding(.top, 20)
                    Spacer().frame(height: 20)
                    
                    //choose color
                    Text("Choose your mood color")
                        .font(.headline)
                        .padding(.top, 20)
                    ColorPicker("", selection: $selectedColor)
                        .labelsHidden()

                    //scale number
                    Text("Write down your mood scale(1-10)")
                        .font(.headline)
                        .padding(.top, 20)

                    HStack(alignment: .center, spacing: 10) {
                        Text("Scale:")
                            .font(.title3)
                        TextField("number", text: $scale).frame(width: 100,height: 30).background(Color(UIColor.lightGray)).cornerRadius(5)
                    }
                    Spacer()
                    
                    //choose shape
                    Text("Choose your mood shape")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        LazyHStack{                                                                             //loads cells when needed
                            ForEach(0..<shapeImageNames.count, id: \.self) { index in
                                Button {
                                    
                                    if selectedShapeImageNameIndex == index {
                                        selectedShapeImageNameIndex = nil
                                    } else {
                                        selectedShapeImageNameIndex = index
                                    }
                                    
                                } label: {
                                    Image(uiImage: UIImage(named: shapeImageNames[index])!)
                                        .resizable()
                                        .frame(width: 100, height: 100, alignment: .center
                                        ).padding(5)
                                        .tag(index)
                                        .border(selectedShapeImageNameIndex == index ? .green : .clear)
                                }
                            }
                            
                        }
                    }.frame(height: 110, alignment: .center)
                
                    
                    
                    //text
                    VStack(alignment: .center, spacing: 10){
                        Text("Write a mood diary")
                            .font(.headline)
                            .padding(.top, 20)
                        TextEditor(text: $diary)
                            .frame(height: 130)
                            .font(.body.weight(.black))
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
                            .background(.indigo)
                            .cornerRadius(12)
                        
                        
                        //add button
                        Button{
                            self.addMood()
                        } label:{
                            Text("Add")
                                .foregroundColor(.white)
                        }
                        .frame(width: 250,height: 60)
                        .background(Color.orange)
                        .cornerRadius(12)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertMsg1))
                        }
                     
                        //clear button
                        Button {
                            self.clearMood()
                        } label: {
                            Text("Clear")
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 250,height: 60)
                        .background(Color(UIColor.lightGray))
                        .cornerRadius(12)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertMsg))
                        }
                        
                        Spacer().frame(height: 200)
                        
                    }
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .navigationTitle("ColorMood")
                    .navigationBarTitleDisplayMode(.inline)
                
               
            }
        }
    }
}



struct Previews_HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


extension UIColor {
    convenience init(rgb: UInt) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0, green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0, blue: CGFloat(rgb & 0x0000FF) / 255.0, alpha: CGFloat(1.0))
    }
}


