import Foundation
import SwiftUI

struct MeView: View {
    @State var contactsModelList = [ContactsModel]()
    @State var feelingContentList = [String]()
    
    @State var showAddContacts = false
    @State var showAddFeeling = false
    
    
    
    @State var feelingContent = ""
    @State var contactsModel = ContactsModel()
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 10) {
                    Spacer().frame(height: 20)
                    Text("Family Sharing")
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                        .foregroundColor(Color.black)
                    Text("Disable this mode if you want to keep data private")
                        .font(.system(size: 15, weight: .regular, design: .monospaced))
                        .foregroundColor(Color.gray)
                    Spacer().frame(height: 30)
                    HStack(alignment: .center, spacing: 10) {
                        Text("Add Contacts")
                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                            .foregroundColor(Color.black)
                        Button {
                            showAddContacts = true
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 30, height: 30, alignment: .center)
                            
                                .background(Color.yellow)
                        }.cornerRadius(15)
                        
                        
                    }
                    LazyVStack(alignment: .center, spacing: 10) {
                        ForEach(0..<contactsModelList.count, id: \.self) { index in
                            ContactsRowView(contactsModel: $contactsModelList[index])
                        }
                    }
                    
                    Spacer().frame(height: 100)
                    HStack(alignment: .center, spacing: 10) {
                        Text("Feeling low? Why not try...")
                            .font(.system(size: 15, weight: .semibold, design: .monospaced))
                            .foregroundColor(Color.black)
                        Button {
                            showAddFeeling = true
                        } label: {
                            Image(systemName: "plus")
                                .frame(width: 30, height: 30, alignment: .center)
                            
                                .background(Color.yellow)
                        }.cornerRadius(15)
                        
                    }
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(0..<feelingContentList.count, id: \.self) { index in
                            
                            Text(feelingContentList[index]).font(Font.system(size: 15, weight: .regular)).foregroundColor(.red)
                        }
                        
                    }
                    Spacer()
                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .fullScreenCover(isPresented: $showAddContacts, onDismiss: {
                        if !contactsModel.phone.isEmpty && !contactsModel.name.isEmpty{
                            contactsModelList.append(contactsModel)
                            contactsModel = ContactsModel()
                        }
                    }, content: {
                        AddContactsView(contactsModel: $contactsModel,showAddContacts: $showAddContacts)
                    })
                    .fullScreenCover(isPresented: $showAddFeeling, onDismiss: {
                        if !feelingContent.isEmpty {
                            feelingContentList.append(feelingContent)
                            feelingContent = ""
                        }
                    }, content: {
                        AddFeelingView(addContent: $feelingContent, showAddFeeling: $showAddFeeling)
                        
                    })
                
            }
            
            .navigationTitle("ColorMood")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView(contactsModelList: [ContactsModel(name: "Mom", phone: "14342423432"),ContactsModel(name: "Dad", phone: "234892342747"),ContactsModel(name: "Aom", phone: "234123234444")])
    }
}
