//
//  ContentView.swift
//  GoodOnesTrial
//
//  Created by Ian Smith on 5/13/22.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    // @StateObject private var viewModel = ContentViewModel()
    @State var showSheet = false
    @State var showLiked = false
    @ObservedObject var mediaItems = PickedMediaItems()
    // @State var likedItems = [PhotoPickerModel]()
    @ObservedObject var likedItems = PickedMediaItems()
    
    var body: some View {
        ZStack {
            Color.teal.ignoresSafeArea()
            VStack {
                HStack { // Top Bar
                    Button(action: { showLiked.toggle() }) { // view liked photos
                        Image("bookmark")
                            .background(.white, in: Circle())
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.cyan, lineWidth: 3))
                            .padding(.horizontal)
                    }
                    Spacer()
                    Button(action: { showSheet.toggle() }) { // add more photos
                        Image("plus")
                            .background(.white, in: Circle())
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.cyan, lineWidth: 3))
                    }
                    Spacer()
                    Button(action: {}) { // log in through google
                        Image("google")
                            .background(.white, in: Circle())
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.cyan, lineWidth: 3))
                            .padding(.horizontal)
                    }
                } // Top Bar
                
                // Tinder style card photo
                ZStack {
                    // attempt 1 at getting photos uploaded
                    /*ForEach(viewModel.images.indices, id: \.self) {
                        var newCard: Card
                        Card.data.append(Card(imageName: viewModel.images[$0]))
                    }*/
                    VStack {
                        Spacer()
                        Spacer()
                        Text("Click the '+' button to add photos")
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("Swipe right to like the photo")
                            .foregroundColor(Color.white)
                        Spacer()
                        Text("Swipe left to discard")
                            .foregroundColor(Color.white)
                        Spacer()
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.cyan)
                    .cornerRadius(8)
                    .padding(8)
                    
                    ForEach(mediaItems.items, id: \.id) { item in
                        // UserCardView(item: item, likedItemsArray: $likedItems).padding(8)
                        UserCardView(item: item, likedItemsArray: $likedItems.items).padding(8)
                    }
                    
                    // For viewing dummy data not uploaded by user
                    /*ForEach(Card.data) { card in
                        CardView(card: card).padding(8)
                    }*/
                } // Card Section
                
                /*HStack { // Bottom bar
                    Spacer()
                    Button(action: {}) {
                        Image("cancel")
                            .background(.white, in: Circle())
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.red, lineWidth: 3))
                    }
                    Spacer()
                    Spacer()
                    Button(action: {}) {
                        Image("accept")
                            .background(.white, in: RoundedRectangle(cornerRadius: 8))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.green, lineWidth: 3))
                    }
                    Spacer()
                } // Bottom Bar*/
                
            }
            .sheet(isPresented: $showSheet, content: {
                PhotoPicker(mediaItems: mediaItems) { didSelectedItems in
                    // Handle didSelected items here...
                    showSheet = false;
                }
            })
            .sheet(isPresented: $showLiked, content: {
                // LikedImageView(likedItemsArray: likedItems)
                VStack {
                    Button("Dismiss", action: { showLiked.toggle() })
                    ScrollView {
                        ForEach(likedItems.items) { likedImage in
                            Image(uiImage: likedImage.photo ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12 mini")
    }
}

struct CardView: View {
    @State var card: Card
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(card.imageName).resizable()
            
            HStack {
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(Double(card.x / 10 - 1))
                Spacer()
                Image("no")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(Double((card.x * -1) / 10 - 1))
            }
        }
        .cornerRadius(8)
        
        // Step 1 - Make sure the ZStack follows the card coordinate
        .offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        
        // Step 2 - Apply gesture recognizer and make sure it updates the coordinate values of the card
        .gesture(
            DragGesture()
                .onChanged { value in
                    // user is dragging view
                    withAnimation(.default) {
                        card.x = value.translation.width
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                }
            
                .onEnded { value in
                    // user has stopped dragging
                    // user has either made a decision or the card needs to return
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                            case (-100)...(100):
                                card.x = 0; card.y = 0; card.degree = 0;
                            case let x where x > 100:
                                card.x = 500; card.degree = 12;
                            case let x where x < -100:
                                card.x = -500; card.degree = -12;
                            default: card.x = 0; card.y = 0; card.degree = 0;
                        }
                    }
                }
        )
    }
} // For dummy data

struct UserCardView: View {
    @State var item: PhotoPickerModel
    @Binding var likedItemsArray: [PhotoPickerModel]
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(uiImage: item.photo ?? UIImage())
                .resizable()
            
            HStack {
                Image("yes")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(Double(item.x / 10 - 1))
                Spacer()
                Image("no")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(Double((item.x * -1) / 10 - 1))
            }
        }
        .cornerRadius(8)
        
        // Step 1 - Make sure the ZStack follows the card coordinate
        .offset(x: item.x, y: item.y)
        .rotationEffect(.init(degrees: item.degree))
        
        // Step 2 - Apply gesture recognizer and make sure it updates the coordinate values of the card
        .gesture(
            DragGesture()
                .onChanged { value in
                    // user is dragging view
                    withAnimation(.default) {
                        item.x = value.translation.width
                        item.y = value.translation.height
                        item.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                }
            
                .onEnded { value in
                    // user has stopped dragging
                    // user has either made a decision or the card needs to return
                    withAnimation(.interpolatingSpring(mass: 1, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                            case (-100)...(100):
                                item.x = 0; item.y = 0; item.degree = 0;
                            case let x where x > 100:
                            item.x = 500; item.degree = 12; likedItemsArray.append(item); print(likedItemsArray.count);
                            case let x where x < -100:
                                item.x = -500; item.degree = -12;
                            default: item.x = 0; item.y = 0; item.degree = 0;
                        }
                    }
                }
        )
    }
} // For user uploaded data

struct LikedImageView: View {
    @Binding var likedItemsArray: [PhotoPickerModel]
    
    var body: some View {
        VStack {
            ForEach(likedItemsArray) { likedImage in
                Image(uiImage: likedImage.photo ?? UIImage())
                    .resizable()
            }
        }
    }
}
