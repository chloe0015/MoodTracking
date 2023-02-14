import SwiftUI


struct ContentView: View {
    
    @State var selectedState = 0
    @State var presented = false
    
    let icons = [
        "paintpalette",
        "gearshape",
        "plus",
        "chart.xyaxis.line",
        "person.2"
    ]
     
    var body: some View {
        VStack{
            
            ZStack{
                
                Spacer().fullScreenCover(isPresented: $presented, content: {
                    Button(action: {
                        presented.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18, weight: .semibold, design: .monospaced))
                            
                            .frame(width: 200, height: 50)
                            .background(Color(hue: 0.226, saturation: 1.0, brightness: 0.78, opacity: 0.481))
                            .cornerRadius(16)
                    })
                })
                
                
                switch selectedState {
                case 0:
                    HomeView()
                    
                case 1:
                    NavigationView{
                        Text("Mood Diary")
                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                            .fontWeight(.bold)
                            .position(x: 100, y: 40)

                            .navigationTitle("ColorMood")
                        .navigationBarTitleDisplayMode(.inline)
                        
                    }
                    
                case 2:
                    NavigationView{
                        Text("plus")
                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                            .multilineTextAlignment(.center)
                            .position(x: 200, y: 80)

                            .navigationTitle("ColorMood")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                    
                case 3:
                    NavigationView{
                        Text("Mood Chart")
                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                            .fontWeight(.bold)
                            .position(x: 100, y: 40)

                            .navigationTitle("ColorMood")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                    
                case 4:
                    NavigationView{
                        Text("Family Sharing")
                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                            .fontWeight(.bold)
                            .position(x: 130, y: 40)

                            .navigationTitle("ColorMood")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                    
                default:
                    NavigationView{
                        Text("How Are You Today?")
                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                            .multilineTextAlignment(.center)
                            .position(x: 200, y: 80)

                            .navigationTitle("ColorMood")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        
            
            Spacer()
            Divider()
            Spacer()
            HStack{
                ForEach(0..<5, id: \.self) {number in
                    Spacer()
                    Button(action: {
                        if number == 2 {
                            presented.toggle()
                        }
                        else{
                            self.selectedState = number
                        }
                    },
                           label: {
                        if number == 2 {
                            Image(systemName: icons[number])
                            .font(.system(
                                size: 22,
                                weight: .regular,
                                design: .default))
                            .foregroundColor(.white)
                            
                            .frame(width: 60, height: 60)

                            .background(Color.yellow)
                            .cornerRadius(22)
                            
                        }
                        else {
                            Image(systemName: icons[number])
                            .font(.system(
                                size: 22,
                                weight: .regular,
                                design: .default))
                            .foregroundColor(selectedState == number ? .yellow: Color(UIColor.lightGray))
                        }
                        }
                    )
                    Spacer()
                    
                }
            }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

