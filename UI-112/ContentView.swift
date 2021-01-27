//
//  ContentView.swift
//  UI-112
//
//  Created by にゃんにゃん丸 on 2021/01/27.
//

import SwiftUI

let issmall = UIScreen.main.bounds.height < 750
struct ContentView: View {
    
    
    @State var index = 0
    var body: some View {
        NavigationView{

            Home()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var unlocked = false
    @StateObject var model = CustomTabViewModel()
   
    var body: some View{
        
        
        ZStack{
            
            if unlocked{
              
                VStack{
                    ZStack{
                        
                        Spacer()
                    
                        if model.index == 0{
                            
                            Color.red.edgesIgnoringSafeArea(.top)
                            
                        }
                        else if model.index == 1{
                            Color.blue.edgesIgnoringSafeArea(.top)
                            
                        }
                        
                        else if model.index == 2{
                            
                            Color.yellow.edgesIgnoringSafeArea(.top)
                            
                        }
                        else{
                            
                            
                            Color.green.edgesIgnoringSafeArea(.top)
                        }
                        
                       
                    
                }
                .padding(.bottom,-35)
                
                CustomTAb(index: $model.index)
               
                }
            }
            
            else{
                LockScreen(unlockd: $unlocked)
                
            }
            
        }
        
        .preferredColorScheme(unlocked ? .light : .dark)
    }
    
}

struct LockScreen : View {
    
    @State var password = ""
    var columns = Array(repeating: GridItem(.flexible(),spacing: 15), count: 3)
    
    @AppStorage("Lock Password") var key = "1234"
    @Binding var unlockd : Bool
    @State var wrongpassword = false
    
    var body: some View{
        
        VStack{
            
            HStack{
                
                Spacer()
                
                Menu(content: {
                    
                    Label(
                        title: { Text("Help")
                            .font(.title)
                            .foregroundColor(.gray)
                        },
                        icon: { Image(systemName: "info") })
                    
                    Label(
                        title: { Text("ResetPassword")
                            
                            .font(.title)
                            .foregroundColor(.gray)
                        },
                        icon: { Image(systemName: "key") })
                    
                    
                }) {
                    
                    
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 15, height: 15)
                        .padding()
                    
                }
                
                
                
                
                
            }
            .padding(.leading)
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
            
            
            Text("Enter Password")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
                .padding(.top,20)
            
            HStack{
                
               
                    
                    withAnimation(.easeInOut(duration: Double(1))){
                        ForEach(0..<4,id:\.self){index in
                            
                            
                            PasswordView(index: index, password: $password)
                            
                        }
                        .padding()
                    }
                    

              
                
                
            }
            .padding(issmall ? 20 : 30)
            
            Spacer()
            
            HStack{
                
             
                
                
                    Text(wrongpassword ? "Incorrect pin" : "")
                        .fontWeight(.heavy)
                        .foregroundColor(Color.red)
                        
                    
            }
            
            Spacer()
            LazyVGrid(columns: columns, spacing: issmall ? 20 : 30, content: {
                
                
                ForEach(1...9,id:\.self){value in
                    
                    PasswordButtonView(value: "\(value)", password: $password, key: $key, unlocked: $unlockd, wrongpassword: $wrongpassword)
                    
                }
                PasswordButtonView(value: "delete.fill", password: $password,key: $key, unlocked: $unlockd, wrongpassword: $wrongpassword)
                
                PasswordButtonView(value: "0", password: $password,key: $key, unlocked: $unlockd, wrongpassword: $wrongpassword)
                
                
                
               
            })
            .padding(.bottom,20)
            
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }
}

struct PasswordView : View {
    
    var index : Int
    @Binding var password : String
    var body: some View{
        
        ZStack{
            
            Circle()
                .stroke(Color.white,lineWidth: 2)
                .frame(width: 30, height: 30)
            
            if password.count > index{
                
                Circle()
                    .fill(Color.white)
                    .frame(width: 30, height: 30)
                
                
            }
            
            
        }
       
        
    }
}

struct PasswordButtonView : View {
    
    var value : String
    @Binding var password : String
    @Binding var key : String
    @Binding var unlocked : Bool
    @Binding var wrongpassword : Bool
    var body: some View{
        
        
        VStack{
            Button(action:
                  setPassword
                   
                   , label: {
                
                if value.count > 1{
                    
                    Image(systemName: "delete.left")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                    
                }
                
                else{
                    
                    Text(value)
                        .font(.title)
                        .foregroundColor(.white)
                    
                }
                
               
            })
        }
        .padding()
        
      
        
        
        
    }
    
    func setPassword(){
        
        
        withAnimation{
            if value.count > 1{
                
                if password.count != 0{
                    
                    password.removeLast()
                    
                }
                }
                
                else{
                    
                    if password.count != 4{
                        
                        password.append(value)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                            
                            if password.count == 4{
                                
                                if password == key{
                                    
                                    unlocked = true
                                    
                                }
                                
                            
                            else{
                                
                                wrongpassword = true
                                password.removeAll()
                            }
                            }
                        }
                        
                    }
                    
                }
            
        }
        
        
    }
    
}
