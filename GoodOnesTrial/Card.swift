//
//  Card.swift
//  GoodOnesTrial
//
//  Created by Ian Smith on 5/14/22.
//
import UIKit


//MARK: - DATA
struct Card: Identifiable {
    let id = UUID()
    let imageName: String

    /// Card x position
    var x: CGFloat = 0.0
    /// Card y position
    var y: CGFloat = 0.0
    /// Card rotation angle
    var degree: Double = 0.0
    
    static var data: [Card] {
        [
            Card(imageName: "p0"),
            Card(imageName: "p1"),
            Card(imageName: "p2"),
            Card(imageName: "p3"),
            Card(imageName: "p4"),
            Card(imageName: "p5"),
        ]
    }
    
}
