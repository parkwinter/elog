//
//  SwiftUIView.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/09/26.
//

import SwiftUI
import ConfettiSwiftUI

struct SwiftUIView: View {
    @State var counter:Int = 1
    
    let sentiment : String?
    
    var body: some View {
        ZStack{
            
            
            if sentiment == "y"{
                VStack(spacing: 20) {
                    Text("🥳").font(.system(size: 50)).onTapGesture(){counter += 1}
                    Text("글이 대체로 긍정적이네요~")
                }
//                Text("yes").font(.system(size: 50)).onTapGesture(){counter += 1}
                ConfettiCannon(counter: $counter, num:1,
                               confettis: [.text("✨"), .text("🌟"),.text("💫")], confettiSize: 30,
                               repetitions: 30, repetitionInterval: 0.1)
            
            
            } else if sentiment == "n" {
                VStack(spacing: 20) {
                Text("😢").font(.system(size: 50)).onTapGesture(){counter += 1}
                Text("글이 대체로 부정적이네요~")
                }
                ConfettiCannon(counter: $counter, num:1,
                               confettis: [.text("💧"), .text("🥶"),.text("🌀")], confettiSize: 30,
                               repetitions: 30, repetitionInterval: 0.1)
            
            
            } else {
                VStack(spacing: 20) {
                Text("😎").font(.system(size: 50)).onTapGesture(){counter += 1}
                Text("글이 중정적이네요~")
                }
                ConfettiCannon(counter: $counter, repetitions: 3, repetitionInterval: 0.5)
            }
            
//            Text("🎉").font(.system(size: 50)).onTapGesture(){counter += 1}
//
//            ConfettiCannon(counter: $counter, repetitions: 3, repetitionInterval: 0.5)
        }
    }
    }


//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}

