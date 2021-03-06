//
//  SwiftUIView.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/09/26.
//

// https://github.com/simibac/ConfettiSwiftUI μ°Έκ³ ν¨

import SwiftUI
import ConfettiSwiftUI

struct SwiftUIView: View {
    @State var counter:Int = 1
    
    let sentiment : String?
    
    var body: some View {
        ZStack{
            
            
            if sentiment == "positive"{
                VStack(spacing: 20) {
                    Text("π₯³").font(.system(size: 50)).onTapGesture(){counter += 1}
                    Text("κΈμ΄ λμ²΄λ‘ κΈμ μ μ΄λ€μ~")
                }
//                Text("yes").font(.system(size: 50)).onTapGesture(){counter += 1}
                ConfettiCannon(counter: $counter, num:1,
                               confettis: [.text("β¨"), .text("π"),.text("π«")], confettiSize: 30,
                               repetitions: 30, repetitionInterval: 0.1)
            
            
            } else if sentiment == "negative" {
                VStack(spacing: 20) {
                Text("π’").font(.system(size: 50)).onTapGesture(){counter += 1}
                Text("κΈμ΄ λμ²΄λ‘ λΆμ μ μ΄λ€μ~")
                }
                ConfettiCannon(counter: $counter, num:1,
                               confettis: [.text("π§"), .text("π₯Ά"),.text("π")], confettiSize: 30,
                               repetitions: 30, repetitionInterval: 0.1)
            
            
            } else {
                VStack(spacing: 20) {
                Text("π").font(.system(size: 50)).onTapGesture(){counter += 1}
                Text("κΈμ΄ μ€μ±μ μ΄λ€μ~")
                }
                ConfettiCannon(counter: $counter, repetitions: 3, repetitionInterval: 0.5)
            }
            
//            Text("π").font(.system(size: 50)).onTapGesture(){counter += 1}
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

