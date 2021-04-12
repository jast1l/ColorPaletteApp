//
//  ShowColorViewController.swift
//  ColorPaletteApp
//
//  Created by MACBOOK on 10.04.2021.
//

import UIKit

protocol SetColorViewContollerDelagate {
    func setNewBackGroundValue(_ color: UIColor)
}

class ShowColorViewController: UIViewController {
    @IBOutlet weak var updateLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = getRandomColor()
        updateLabel.layer.cornerRadius = 15
        updateLabel.tintColor = view.backgroundColor
        updateLabel.alpha = 0.8
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setColorVC = segue.destination as? SetColorViewController
        setColorVC?.curentColor = view.backgroundColor
        setColorVC?.delegate = self
    }
    
    @IBAction func updateButtonPressed() {
        view.backgroundColor = getRandomColor()
        updateLabel.tintColor = view.backgroundColor
    }
}

extension ShowColorViewController{
    func getRandomColor() -> UIColor {
        UIColor(red: CGFloat(Float.random(in: 0...1)),
                green: CGFloat(Float.random(in: 0...1)),
                blue: CGFloat(Float.random(in: 0...1)),
                alpha: 1)
    }
}

extension ShowColorViewController: SetColorViewContollerDelagate {
    func setNewBackGroundValue(_ color: UIColor) {
        view.backgroundColor = color
        updateLabel.tintColor = view.backgroundColor
    }
}
