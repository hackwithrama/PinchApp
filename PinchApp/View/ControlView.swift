//
//  ControlView.swift
//  PinchApp
//
//  Created by Ramachandran Varadaraju on 29/06/24.
//

import SwiftUI

struct ControlView: View {
    @Binding var imageOffset: CGSize
    @Binding var imageScale: CGFloat
    
    var body: some View {
        Group {
            HStack(spacing: 20){
                // MARK: SCALE DOWN BUTTON
                Button{
                    if imageScale > 1{
                        withAnimation(.spring()){
                            imageScale -= 1
                        }
                    }else{
                        withAnimation(.spring()){
                            imageScale = 1.0
                            imageOffset = .zero
                        }
                    }
                }label: {
                    Image(systemName: "minus.magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                // MARK: RESET BUTTON
                Button{
                    withAnimation(.easeOut(duration: 0.5)){
                        imageScale = 1.0
                        imageOffset = .zero
                    }
                }label: {
                    Image(systemName: "arrow.up.left.and.down.right.magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                
                // MARK: SCALE UP BUTTON
                Button{
                    if imageScale < 5{
                        withAnimation(.spring()){
                            imageScale += 1
                        }
                    }else{
                        withAnimation(.spring()){
                            imageScale = 5
                        }
                    }
                }label: {
                    Image(systemName: "plus.magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .padding()
            .background(.ultraThinMaterial)
        .cornerRadius(8)
        }
    }
}

#Preview {
    ControlView(imageOffset: .constant(.zero), imageScale: .constant(1))
}
