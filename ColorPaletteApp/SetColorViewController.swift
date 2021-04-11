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
    var startViewColor: [CGFloat]!
    var showAlertCount = false
    var currentFocusTextFieldValue = ""
    
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
        delegate.setNewBackGroundValue(CGFloat(redSlider.value),
                                       CGFloat(greenSlider.value),
                                       CGFloat(blueSlider.value))
        delegate.checkGoBack(showAlertCount)
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
        if !showAlertCount {
            showAlert(title: "Attention", message: "Since the value cannot exceed 1.00, you can enter any number from 1 to 100 and it will be processed according to the conditions")
            showAlertCount = true
        } else {
            currentFocusTextFieldValue = textField.text ?? ""
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            guard let numberForSlider = Int(textField.text ?? "") else { return }
            var stringSliderValue = ""
            
            if 1...99 ~= numberForSlider {
                stringSliderValue = "0.\(numberForSlider)"
            } else {
                showAlert(title: "Attention", message: "The number \(numberForSlider) is not in the range from 1 to 100. Current value returned \(currentFocusTextFieldValue)")
                stringSliderValue = currentFocusTextFieldValue
            }
            
            
            if textField == redTextField {
                redSlider.value = Float(stringSliderValue) ?? 0
            } else if textField == greenTextField {
                greenSlider.value = Float(stringSliderValue) ?? 0
            } else {
                blueSlider.value = Float(stringSliderValue) ?? 0
            }
            
            updateTextCount()
            convertColor()
        } else {
            textField.text = String(currentFocusTextFieldValue)
        }
        
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
        
        colorView.layer.cornerRadius = 20
        
        colorView.backgroundColor = UIColor(red: CGFloat(startViewColor[0]),
                                            green:CGFloat(startViewColor[1]),
                                            blue: CGFloat(startViewColor[2]),
                                            alpha: 1)
    }
    
    private func slidersSettings() {
        redSlider.value = Float(startViewColor[0])
        redSlider.tintColor = .red
        
        greenSlider.value = Float(startViewColor[1])
        greenSlider.tintColor = .green
        
        blueSlider.value = Float(startViewColor[2])
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

extension SetColorViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        
        present(alert, animated: true)
    }
}





