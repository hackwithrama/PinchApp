//
//  ContentView.swift
//  PinchApp
//
//  Created by Ramachandran Varadaraju on 28/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var isDrawerOpen: Bool = false
    
    let pages: [Page] = pagesData
    @State private var pageIndex: Int = 1
    
    func currentPage() -> String{
        return pages[pageIndex - 1].imageName
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.clear
                // MARK: PAGE IMAGE
                Image(currentPage())
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(16)
                    .padding()
                    .animation(.easeOut(duration: 0.5), value: pageIndex)
                    .shadow(color: .black.opacity(0.25),radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.linear(duration: 0.5), value: isAnimating)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                    // MARK: TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1{
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        }else{
                            withAnimation(.spring()){
                                imageScale = 1
                                imageOffset = .zero
                            }
                        }
                    })
                    // MARK: DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged{value in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = value.translation
                                }
                            }
                        
                            .onEnded{_ in
                                if imageScale <= 1{
                                    withAnimation(.spring()){
                                        imageScale = 1
                                        imageOffset = .zero
                                    }
                                }
                            }
                    )
                    // MARK: MAGNIFICATINO GESTURE
                    .gesture(
                        MagnificationGesture()
                            .onChanged{value in
                                withAnimation(.linear(duration: 1)){
                                    if imageScale >= 1 && imageScale <= 5{
                                        imageScale = value
                                    }else if imageScale > 5{
                                        imageScale = 5
                                    }
                                }
                            }
                        
                            .onEnded{_ in
                                if imageScale > 5{
                                    withAnimation(.spring()){
                                        imageScale = 5
                                    }
                                }else if imageScale <= 1{
                                    imageScale = 1
                                    imageOffset = .zero
                                }
                            }
                    )
            }//: ZStack
            .navigationTitle("Pinch and Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                isAnimating = true
            })
            .overlay(
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            .overlay(
                ControlView(imageOffset: $imageOffset, imageScale: $imageScale)
                , alignment: .bottom
            )
            .overlay(
                HStack(spacing: 12){
                    // MARK: DRAWER HANDLE
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundColor(.red)
                    
                    ForEach(pages){page in
                        Image(page.thumbnailName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(8)
                            .onTapGesture {
                                pageIndex = page.id
                            }
                    }
                    
                    Spacer()
                    
                    // MARK: THUMBNAIL
                }
                    .padding(.vertical, 16)
                    .padding(.horizontal, 8)
                    .background(.ultraThinMaterial)
                    .cornerRadius(16)
                    .frame(width: 260)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 20 : 220)
                    .animation(.easeOut(duration: 0.5), value: isDrawerOpen)
                    .onTapGesture(count: 1, perform: {
                            isDrawerOpen.toggle()
                    })
                , alignment: .topTrailing
            )
        }//: NavigationStack
    }
}

#Preview {
    ContentView()
}
