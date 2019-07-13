//
//  PickerTextField.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/13.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

protocol PickerTextFieldDelegate: UITextFieldDelegate {
    func pickerTextField(_ textField: PickerTextField, didSelectPickerValue value: String)
}

@IBDesignable
final class PickerTextField: UITextField {
    var pickerView: UIPickerView!
    
    var pickerContents: [String]! {
        didSet {
            pickerView?.reloadAllComponents()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pickerContents = [String]()
        
        pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let doneItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(doneButtonTapped(_:)))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: 40))
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        toolbar.items = [spacer, doneItem]
        
        inputView = pickerView
        inputAccessoryView = toolbar
    }
    
    @objc private func doneButtonTapped(_ sender: UIBarButtonItem) {
        resignFirstResponder()
    }
}

extension PickerTextField: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerContents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerContents[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        text = pickerContents[row]
        //　選択された時に、delegateメソッドを使う。
        (delegate as? PickerTextFieldDelegate)?.pickerTextField(self, didSelectPickerValue: pickerContents[row])
    }
    
    
}
