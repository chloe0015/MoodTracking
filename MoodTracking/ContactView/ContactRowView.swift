import Foundation
import SwiftUI

struct ContactsRowView: View {
    @Binding var contactsModel: ContactsModel
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            
            Image(systemName: "face.smiling.fill").foregroundColor(Color.yellow).padding(.leading,15)
            Text(contactsModel.name)
            Spacer()
            Button {
                let urlstr = "tel://\(contactsModel.phone)"
                if let url = URL(string: urlstr), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text(contactsModel.phone)
                    .padding(.trailing,15)
            }

            
        }.frame(height: 40).background(Color.gray).cornerRadius(20).padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 5))//.padding(10)
    }
}

struct ContactsRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsRowView(contactsModel: .constant(ContactsModel(name: "Sas",phone: "e12312312")))
    }
}
