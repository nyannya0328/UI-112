//
//  CustomTabView.swift
//  UI-112
//
//  Created by にゃんにゃん丸 on 2021/01/27.
//

import SwiftUI

struct CustomTAb : View {
    @Binding var index : Int
    var body: some View{
        
        HStack{
            
            
            Button(action: {
                index = 0
                
            }) {
                
                Image(systemName: "house.fill")
                    .foregroundColor(Color.black.opacity(index == 0 ? 1 : 0.1))
                
            }
            
            Spacer(minLength: 0)
            
            Button(action: {
                index = 1
                
            }) {
                
                Image(systemName: "gear")
                    .foregroundColor(Color.black.opacity(index == 1 ? 1 : 0.1))
                
            }
            
            Spacer(minLength: 0)
            
            Button(action: {}) {
                Image("plus")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 60, height: 60)
            }
            .offset(x: +3,y: -35)
            
            Spacer()
            
            
            Button(action: {
                index = 2
                
            }) {
                
                Image(systemName: "person")
                    .foregroundColor(Color.black.opacity(index == 2 ? 1 : 0.1))
                
            }
            
            Spacer(minLength: 0)
            
            Button(action: {
                index = 3
                
            }) {
                
                Image(systemName: "folder")
                    .foregroundColor(Color.black.opacity(index == 3 ? 1 : 0.1))
                
            }
            
            
            
            
            
        }
        .padding(.horizontal,35)
        .padding(.top,35)
        .background(Color.white)
        .clipShape(CustomShape())
        
    }
}


struct CustomShape : Shape {
    func path(in rect: CGRect) -> Path {
        return Path {path in
            
            
            path.move(to: CGPoint(x: 0, y: 38))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 38))
            
           path.addArc(center: CGPoint(x: (rect.width / 2) + 4, y: 38), radius: 35, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
            
        }
    }
}



