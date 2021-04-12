//
//  ViewController.swift
//  ColorPaletteApp
//
//  Created by MACBOOK on 26.03.2021.
//

import UIKit

class SetColorViewController: UIViewController {
    
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
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    var delegate: SetColorViewContollerDelagate!
    var curentColor: UIColor!
    var curentTextFiledValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        canfigureAppearance()
        
        addDoneButtonOnKeyboard()
        
        labelsSettings()
        slidersSettings()
        updateTextCount()
    }
    
    @IBAction func redSliderMove() {
        updateTextCount()
        convertColor()
    }
    
    @IBAction func doneButtonePressed() {
        delegate.setNewBackGroundValue(colorView.backgroundColor ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        dismiss(animated: true)
    }
    
    @objc func doneClicked() {
        view.endEditing(true)
    }
}

extension SetColorViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    private func addDoneButtonOnKeyboard() {
        let keyboardToolBar = UIToolbar()
        keyboardToolBar.sizeToFit()
        var items = [UIBarButtonItem]()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem:
                                                UIBarButtonItem.SystemItem.flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem:
                                            UIBarButtonItem.SystemItem.done,
                                         target: self,
                                         action: #selector(self.doneClicked))
        items.append(flexibleSpace)
        items.append(doneButton)
        
        keyboardToolBar.setItems(items, animated: true)
        
        redTextField.inputAccessoryView = keyboardToolBar
        greenTextField.inputAccessoryView = keyboardToolBar
        blueTextField.inputAccessoryView = keyboardToolBar
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        curentTextFiledValue = text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = Float(textField.text ?? "1.0"),
              text != Float("") else {
            textField.text = curentTextFiledValue
            return
        }
        
        switch textField {
        case redTextField :
            redSlider.value = text
        case greenTextField :
            greenSlider.value = text
        default:
            blueSlider.value = text
        }
        
        updateTextCount()
        convertColor()
    }
}

extension SetColorViewController {
    
    private func convertColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func updateTextCount() {
        redCount.text = String(format: "%.2f", redSlider.value)
        redTextField.text = redCount.text
        greenCount.text = String(format: "%.2f", greenSlider.value)
        greenTextField.text = greenCount.text
        blueCount.text = String(format: "%.2f", blueSlider.value)
        blueTextField.text = blueCount.text
    }
}

extension SetColorViewController {
    private func canfigureAppearance() {
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.backgroundColor = curentColor
        colorView.layer.cornerRadius = 20
        
        
    }
    
    private func slidersSettings() {
        let ciColor = CIColor(color: colorView.backgroundColor!)
        
        redSlider.value = Float(ciColor.red)
        redSlider.tintColor = .red
        
        greenSlider.value = Float(ciColor.green)
        greenSlider.tintColor = .green
        
        blueSlider.value = Float(ciColor.blue)
        blueSlider.tintColor = .blue
    }
    
    private func labelsSettings() {
        let labelColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        redCount.textColor = labelColor
        greenCount.textColor = labelColor
        blueCount.textColor = labelColor
        
        redLabel.textColor = labelColor
        greenLabel.textColor = labelColor
        blueLabel.textColor = labelColor
    }
}




