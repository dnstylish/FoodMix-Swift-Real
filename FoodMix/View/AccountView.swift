//
//  EditProfileView.swift
//  FoodMix
//
//  Created by Yuan on 10/03/2022.
//

import SwiftUI

struct AccountView: View {
    
    @StateObject var viewModel: AccountViewModel = AccountViewModel()
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var currentTab: AccountTab = .Info
    
    @Namespace var animation
    
    @State var initScreen: Bool = true
    
    var body: some View {
        
        VStack {
            
            HStack(spacing: 20) {
                
                Button {
                    
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    
                    Image(systemName: "arrow.left")
                    
                }
                
                Text("Tài Khoản")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                    
                Spacer()
                
            }
            .foregroundColor(Color("Text"))
            .padding(.vertical)
            
            HStack(spacing: 15) {
                
                ForEach(AccountTab.allCases, id: \.self) { tab in
                    
                    AccountTabView(tab: tab)
                    
                }
                
            }
            .withAlignment(alignment: .leading)
            .background(
                
                Rectangle()
                    .fill(Color("InputText").opacity(0.1))
                    .frame(height: 1.5)
                
                ,alignment: .bottom
                
            )
            .padding(.top, 25)
            
            ScrollView(showsIndicators: false) {
                
                Group {
                    
                    InfoFormView()
                    
                }
                .padding(.vertical, 40)
                
            }
            
        }
        .padding(.horizontal, 25)
        .environmentObject(viewModel)
        
    }
    
    @ViewBuilder
    private func AccountTabView(tab: AccountTab) -> some View {
        
        Button {
            
            withAnimation(.spring()) {
                currentTab = tab
            }
            
        } label: {
            
            Text(tab.rawValue)
                .foregroundColor( currentTab == tab ? Color("Text") : Color("Secondary"))
                .fontWeight(currentTab == tab ? .semibold :.regular)
                .animation(.none, value: currentTab)
                .padding(.bottom, 14)
                .padding(.horizontal, 3)
                .padding(.trailing, 5)
            
        }
        .buttonStyle(PlainButtonStyle())
        .background(
            
            Group {
                
                if currentTab == tab {
                    
                    Rectangle()
                        .fill(Color("Primary"))
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "ACCOUNT_TAB", in: animation)
                    
                }
                
            }
            
            ,alignment: .bottom
        
        )
        
    }
}

enum AccountTab: String, CaseIterable {
    case Info = "Thông Tin"
    case Password = "Mật Khẩu"
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        
        PreviewWrapper {
            
            AccountView()
            
        }
        
    }
}