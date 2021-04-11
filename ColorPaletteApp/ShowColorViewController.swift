//
//  ShowColorViewController.swift
//  ColorPaletteApp
//
//  Created by MACBOOK on 10.04.2021.
//

import UIKit

protocol SetColorViewContollerDelagate {
    func setNewBackGroundValue(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat)
    func checkGoBack(_ alertCount: Bool)
}

class ShowColorViewController: UIViewController {
    @IBOutlet weak var updateLabel: UIButton!
    
    var goBack = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = getRandomColor()
        updateLabel.layer.cornerRadius = 15
        updateLabel.tintColor = view.backgroundColor
        updateLabel.alpha = 0.8
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setColorVC = segue.destination as? SetColorViewController
        setColorVC?.startViewColor = view.backgroundColor?.cgColor.components
        setColorVC?.delegate = self
        
        if goBack {
            setColorVC?.showAlertCount = true
        }
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
    func setNewBackGroundValue(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        updateLabel.tintColor = view.backgroundColor
    }
    
    func checkGoBack(_ alertCount: Bool) {
        self.goBack = alertCount
    }
}
