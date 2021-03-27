//
//  ViewController.swift
//  ColorPaletteApp
//
//  Created by MACBOOK on 26.03.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redCount: UILabel!
    @IBOutlet weak var greenCount: UILabel!
    @IBOutlet weak var blueCount: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.09868655354, green: 0.3001600206, blue: 0.6156072617, alpha: 1)
        colorView.layer.cornerRadius = 20
        
        labelSettings()
        slidersSettings()
    }

    @IBAction func redSliderMove() {
        updateColorCount()
        converColor()
    }
}



extension ViewController {
    private func converColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func updateColorCount() {
    redCount.text = String(format: "%.2f", redSlider.value)
    greenCount.text = String(format: "%.2f", greenSlider.value)
    blueCount.text = String(format: "%.2f", blueSlider.value)
    }
}

extension ViewController {
    private func slidersSettings() {
        let sliderValue: Float = 0.5
        let sliderMin: Float = 0
        let sliderMax: Float = 1
        
        redSlider.minimumValue = sliderMin
        redSlider.value = sliderValue
        redSlider.maximumValue = sliderMax
        redSlider.tintColor = .red
        
        greenSlider.minimumValue = sliderMin
        greenSlider.maximumValue = sliderMax
        greenSlider.value = sliderValue
        greenSlider.tintColor = .green
        
        blueSlider.minimumValue = sliderMin
        blueSlider.maximumValue = sliderMax
        blueSlider.value = sliderValue
        blueSlider.tintColor = .blue
    }
    
    private func labelSettings() {
        let labelColor = #colorLiteral(red: 0.7803899646, green: 0.8429759145, blue: 0.9137470722, alpha: 1)
        
        redCount.textColor = labelColor
        greenCount.textColor = labelColor
        blueCount.textColor = labelColor
        
        redLabel.textColor = labelColor
        greenLabel.textColor = labelColor
        blueLabel.textColor = labelColor
    }
}



