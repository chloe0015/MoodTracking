import Foundation
import SwiftUI

struct AddContactsView: View {
    @Binding var contactsModel: ContactsModel
    @Binding var showAddContacts: Bool
    @State var showAlert = false
    @State var alertMsg = ""
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            TextField("name", text: $contactsModel.name).padding().border(Color.gray)
            TextField("phone", text: $contactsModel.phone).padding().border(Color.gray)
            HStack(alignment: .center, spacing: 10) {
                Button {
                    contactsModel.name = ""
                    contactsModel.phone = ""
                    self.showAddContacts = false
                } label: {
                    Text("Cancel").frame(width: 100, height: 40, alignment: .center).background(Color.orange).foregroundColor(.white).cornerRadius(5)
                }
                
                Button {
                    if contactsModel.name.isEmpty {
                        alertMsg = "name error"
                        showAlert = true
                        return
                    }
                    if contactsModel.phone.isEmpty {
                        alertMsg = "phone error"
                        showAlert = true
                        return
                    }
                    self.showAddContacts = false
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

struct AddContactsView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactsView(contactsModel: .constant(ContactsModel()),showAddContacts: .constant(true))
    }
}
