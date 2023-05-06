import SwiftUI
struct HomeView: View {
    @State var selectedColor: Color = .yellow
    @State var scale: String = ""
    @State var label: String = ""
    
    let shapeImageNames: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16"]
    @State var selectedShapeImageNameIndex: Int?                                                   //optional value
    
    
    @State var diary: String = ""
    
    @State var showAlert: Bool = false
    @State var alertMsg: String = ""
    
    
    func addMood(){
        let rgb = UIColor(selectedColor).rgb()!
        var scaleInt = Int64(scale)
        if let scaleIntNew = scaleInt,
           (scaleIntNew < 1 || scaleIntNew > 10){
            scaleInt = nil
        }
        var shapeImage : String?
        if let selectedShapeImageNameIndex = selectedShapeImageNameIndex{
            shapeImage = shapeImageNames[selectedShapeImageNameIndex]
        }
        
       let result = CoreDataManager.share.addOneMood(color: Int64(rgb), shapeImage:shapeImage, scale: scaleInt,  label: label, diary: diary)
        alertMsg = result.msg
        showAlert = true
        
    }
    
    func clearMood(){
        selectedColor = Color.yellow
        scale = ""
        selectedShapeImageNameIndex = nil
        diary = ""
        alertMsg = "Clear success"
        showAlert = true
    }
    
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 18) {
                    
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
                        Text("Mood Scale:")
                            .font(.title3)
                        TextField(" number", text: $scale).frame(width: 100,height: 35).background(Color(UIColor.systemGray4)).cornerRadius(5)
                    }
                   
                    
                    //choose shape
                    Text("Choose your mood shape")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    ScrollView(.horizontal, showsIndicators: true){
                        LazyHStack(spacing: 0){                                                                             //loads cells when needed
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
                                        .renderingMode(.template)
                                        .foregroundColor(selectedColor)
                                        .frame(width: 90, height: 90, alignment: .center
                                        ).padding(3.4)
                                        .tag(index)
                                        .border(selectedShapeImageNameIndex == index ? selectedColor : .clear)
                                }
                            }
                            
                        }
                    }.frame(height: 110, alignment: .center)
                    
                    //text
                    VStack(alignment: .center, spacing: 18){
                        Text("Describe your mood shape with one word")
                            .font(.headline)
                            .padding(.top, 20)
                        
                        HStack(alignment: .center, spacing: 10) {
                            Text("Mood Label:")
                                .font(.title3)
                            TextField(" how do you feel?", text: $label).frame(width: 177,height: 35).background(Color(UIColor.systemGray4)).cornerRadius(5)
                        }
                        
                        
                        Spacer(minLength: 0)
                        
                        Text("Write a mood diary")
                            .font(.headline)
                            .padding(.top, 20)
                        TextEditor(text: $diary)
                            .frame(height: 130)
                            .font(.body.weight(.black))
                            .foregroundColor(.white)
                            .scrollContentBackground(.hidden)
//                            .background(.indigo)
                            .background(Color(hue: 0.226, saturation: 1.0, brightness: 0.78, opacity: 0.481))
                            .cornerRadius(12)
                        
                        Spacer()
                     
                     
                        //clear button
                        Button {
                            self.clearMood()
                        } label: {
                            Text("Clear")
                                .foregroundColor(.white)
                            
                        }
                        .frame(width: 250,height: 60)
                        .background(Color(UIColor.systemGray4))
                        .cornerRadius(12)
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text(alertMsg))
                        }
                        
                        
                        
                        //add button
                        Button{
                            self.addMood()
                        } label:{
                            Text("Add")
                                .foregroundColor(.white)
                        }
                        .frame(width: 250,height: 60)
                        .background(Color.yellow)
                        .cornerRadius(12)
                        
                        Spacer().frame(height: 200)
                        
                    }
                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .navigationTitle("iColour")
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
    // color to rgb value
    func rgb() -> Int? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iRed << 24) + (iGreen << 16) + (iBlue << 8) + iAlpha
            return rgb
        } else {
            // Could not extract RGBA components:
            return nil
        }
        
        
    }
}


