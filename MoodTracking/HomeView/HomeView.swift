import SwiftUI
struct HomeView: View {
    @State var selectedColor: Color = .red
    @State var scale: String = ""
    let shapeImageNames: [String] = ["shape","shape","shape"]
    @State var selectedShapeImageNameIndex: Int?                                                   //optional value
    
    
    @State var diary: String = ""
    
    @State var showAlert: Bool = false
    @State var alertMsg: String = ""
    
    
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
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.top, 20)
                    ColorPicker("", selection: $selectedColor)
                        .labelsHidden()
                    
                    //scale number
                    Text("Write down your mood scale(1-10)")
                        .font(.system(size: 18, weight: .semibold))
                        .padding(.top, 20)
                    HStack(alignment: .center, spacing: 10) {
                        Text("Scale:")
                            .font(.system(size: 20, weight: .bold))
                        TextField("scale", text: $scale).frame(width: 100,height: 30).background(Color.gray).cornerRadius(5)
                    }
                    
                    //choose shape
                    Text("Choose your mood shape")
                        .font(.system(size: 18, weight: .semibold))
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
                            .font(.system(size: 18, weight: .semibold))
                            .padding(.top, 20)
                        TextEditor(text: $diary)
                            .frame(height: 130)
                            .font(.body.weight(.black))
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
                            .background(.indigo)
                            .cornerRadius(12)
                        
                        
                        //clear button
                        Button {
                            selectedColor = Color.red
                            scale = ""
                            selectedShapeImageNameIndex = nil
                            diary = ""
                            alertMsg = "Clear success"
                            showAlert = true
                        } label: {
                            Text("Clear")
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 250,height: 60)
                        .background(Color.gray)
                        .cornerRadius(12)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertMsg))
                        }
                        
                        Spacer().frame(height: 200)
                        
                    }
                }
            }
        }
    }
}
