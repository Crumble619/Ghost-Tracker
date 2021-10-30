//
//  ContentView.swift
//  Ghost Tracker
//
//  Created by Colin Greene on 10/27/21.
//

import SwiftUI
import RealityKit

//let numberOfBars: Int = 3

struct ContentView: View {
    
    @ObservedObject var motion: MagnetManager
    let shortViewHeight = UIScreen.main.bounds.maxY
    
    private func normalizeMagnetLevel(level: Float) -> CGFloat {
        var level = level
        
        if level > 1000 {
            level = 1000
        }
        
        return CGFloat(Float((UIScreen.main.bounds.maxX - (UIScreen.main.bounds.maxX / 3))) * (level / 1000))
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 0)
                .foregroundColor(.black)
                .ignoresSafeArea(.all)
            VStack {
                BodyTracking()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
//                                RoundedRectangle(cornerRadius: 25)
//                                    .stroke(Color.white, lineWidth: 3)
                    .frame(width: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.maxX / 18), height: shortViewHeight / 1.5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.white, lineWidth: 3)
                    )
//                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                //VStack {
//                    HStack{
//                        RoundedRectangle(cornerRadius: 25)
//                            .stroke(Color.white, lineWidth: 3)
//                            .frame(width: shortViewHeight / 9, height: shortViewHeight / 9)
//                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                            .padding(.horizontal, UIScreen.main.bounds.maxX / 30)
//                        RoundedRectangle(cornerRadius: 25)
//                            .stroke(Color.white, lineWidth: 3)
//                            .frame(width: shortViewHeight / 9, height: shortViewHeight / 9)
//                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                            .padding(.horizontal, UIScreen.main.bounds.maxX / 30)
//                        RoundedRectangle(cornerRadius: 25)
//                            .stroke(Color.white, lineWidth: 3)
//                            .frame(width: shortViewHeight / 9, height: shortViewHeight / 9)
//                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
//                            .padding(.horizontal, UIScreen.main.bounds.maxX / 30)
//                    }
//                    .padding(.vertical, 5)
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: UIScreen.main.bounds.maxX - (UIScreen.main.bounds.maxX / 18), height: shortViewHeight / 4.5)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .overlay {
                            VStack(alignment: .center, spacing: 3) {
                                Text("Electromagnetic Field (EMF)")
                                    .font(.system(size: UIScreen.main.bounds.maxY / 50))
                                    .foregroundColor(.white)
                                BarView(value: self.normalizeMagnetLevel(level: Float(abs(motion.x))))
                                Text("(X-Axis)")
                                    .font(.system(size: UIScreen.main.bounds.maxY / 50))
                                    .foregroundColor(.white)
                                BarView(value: self.normalizeMagnetLevel(level: Float(abs(motion.y))))
                                Text("(Y-Axis)")
                                    .font(.system(size: UIScreen.main.bounds.maxY / 50))
                                    .foregroundColor(.white)
                                BarView(value: self.normalizeMagnetLevel(level: Float(abs(motion.z))))
                                Text("(Z-Axis)")
                                    .font(.system(size: UIScreen.main.bounds.maxY / 50))
                                    .foregroundColor(.white)
                            }
                        }
                //}
            }
            .padding(5)
        }
    }
}

struct BarView: View {
    var value: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.red)
                .frame(width: value, height: UIScreen.main.bounds.maxY / 50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(motion: MagnetManager())
    }
}
