//
//  Color.swift
//  ColorPaletteApp
//
//  Created by MACBOOK on 10.04.2021.
//

import UIKit

struct Color {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    
    func getRandomColor() -> UIColor {
        UIColor(red: CGFloat(Float.random(in: 0...1)),
                green: CGFloat(Float.random(in: 0...1)),
                blue: CGFloat(Float.random(in: 0...1)),
                alpha: 1)
    }
}
