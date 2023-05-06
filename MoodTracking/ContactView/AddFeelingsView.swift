import Foundation
import SwiftUI

struct AddFeelingView: View {
    @Binding var addContent: String
    @Binding var showAddFeeling: Bool
    @State var showAlert = false
    @State var alertMsg = ""
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            TextField("feel", text: $addContent).padding().border(Color.gray)
            
            HStack(alignment: .center, spacing: 10) {
                Button {
                    addContent = ""
                    self.showAddFeeling = false
                } label: {
                    Text("Cancel").frame(width: 100, height: 40, alignment: .center).background(Color.orange).foregroundColor(.white).cornerRadius(5)
                }
                
                Button {
                    if addContent.isEmpty {
                        alertMsg = "name error"
                        showAlert = true
                        return
                    }
                    self.showAddFeeling = false
                } label: {
                    Text("Sure").frame(width: 100, height: 40, alignment: .center).background(Color.orange).foregroundColor(.white).cornerRadius(5)
                }
            }
            
            
        }.padding(20)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertMsg))
            }
    }
    
}

struct AddFeelingView_Previews: PreviewProvider {
    static var previews: some View {
        AddFeelingView(addContent: .constant(""), showAddFeeling: .constant(true))
    }
}
