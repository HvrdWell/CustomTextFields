//
//  ContentView.swift
//  TextFields
//
//  Created by geka231 on 14.12.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text = ""
    
    var body: some View {
        VStack{
            LineTextField(text: $text, plaseholder: "Enter...", title: "Username")

        
            TextField("23", text: $text)
                .textFieldStyle(GradientTextFieldStyle(systemImage: "person"))
                .padding()
            
            TextField("33", text: $text)
                .textFieldStyle(UnderlinedTextFieldStyle(color:.indigo))
                .padding()
            
            SecureTextField(text: $text)
                .padding()
            ZStack{
                NeomphismTextFieldStyle(textField: TextField("Enter...", text: $text), imageName: "person.fill")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(.background)
            
            
        }
    }
}

struct GradientTextFieldStyle: TextFieldStyle{
    
    let systemImage: String
    
    func _body(configuration: TextField<Self._Label>) -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    LinearGradient( colors: [.mint, .cyan], startPoint: .leading, endPoint: .trailing)
                )
                .frame(height: 40)
            HStack{
                Image(systemName: systemImage)
                
                configuration
            }
            .padding(.leading)
            .foregroundColor(.gray)
        }
    }
    
}

struct UnderlinedTextFieldStyle: TextFieldStyle {
    
    let color : Color
    
    func _body(configuration: TextField<Self._Label>) -> some View{
        configuration
            .padding()
            .background(
                VStack{
                    Spacer()
                    color
                        .frame(height: 2)
                
            })
    }
    
}

struct SecureTextField: View {
    @State private var isSecure : Bool = false
    @Binding var text: String
    
    var body: some View{
        HStack{
            if isSecure{
                SecureField("Enter your password", text: $text)
                    .textFieldStyle(UnderlinedTextFieldStyle(color: .teal))
            } else{
                TextField(text, text: $text)
                    .textFieldStyle(UnderlinedTextFieldStyle(color:.teal))
            }
        }
        .overlay(alignment: .trailing){
            Image(systemName: isSecure ? "eye.slash" : "eye")
                .foregroundColor(.gray)
                .padding(.trailing, 8)
                .onTapGesture {
                    isSecure.toggle()
                }
        }
    }
}


extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let neumorphictextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)

}

struct NeomphismTextFieldStyle: View {
    
    var textField: TextField<Text>
    var imageName: String
    
    
    var body: some View{
        HStack{
            Image(systemName: imageName)
                .foregroundColor(.darkShadow)
            textField
        }
        .padding()
//        .foregroundColor(.neumorphictextColor)
//        .background(Color.background)
        .cornerRadius(20)
        .shadow(color: .lightShadow, radius: 5, x: -4, y: -4)
        .shadow(color: .darkShadow, radius: 5, x: 4, y: 4)
    }
    
}

struct LineTextFieldStyle: TextFieldStyle{
    func _body(configuration: TextField<Self._Label>) -> some View{
        configuration
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.indigo))
    }
}

struct LineTextField: View {
    
    @Binding var text: String
    var plaseholder: String
    var title : String
    var body: some View{
        ZStack {
            TextField(plaseholder, text: $text)
                .textFieldStyle(LineTextFieldStyle())
            VStack (alignment: .leading){
                Text(title)
                    .foregroundColor(.indigo)
                    .background(.white)
                    .opacity(1)
                    .offset(x: -150, y: -28)
                    .padding(3)
            }
        }
    }
}







struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


