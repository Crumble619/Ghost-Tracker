//
//  ContentView.swift
//  Ghost Tracker
//
//  Created by Colin Greene on 10/27/21.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @ObservedObject var motion: MagnetManager
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.black)
                .ignoresSafeArea(.all)
            VStack {
                BodyTracking()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
//                RoundedRectangle(cornerRadius: 25)
//                    .stroke(Color.white, lineWidth: 3)
                    .frame(width: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.maxX / 18), height: UIScreen.main.bounds.maxY / 1.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 3)
                    )
                    //.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                VStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.maxX / 18), height: UIScreen.main.bounds.maxY / 9)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.maxX / 18), height: UIScreen.main.bounds.maxY / 9)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .overlay {
                            VStack {
                                Text("Magnetometer Data")
                                    .foregroundColor(.white)
                                Text("X: \(motion.x)")
                                    .foregroundColor(.white)
                                Text("Y: \(motion.y)")
                                    .foregroundColor(.white)
                                Text("Z: \(motion.z)")
                                    .foregroundColor(.white)
                            }
                        }
                }
            }
            .padding(5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(motion: MagnetManager())
    }
}
