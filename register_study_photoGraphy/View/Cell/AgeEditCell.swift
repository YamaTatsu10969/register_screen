//
//  AgeEditCell.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/13.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

protocol AgeEditCellDelegate: AnyObject {
    func ageEditCell(_ cell: AgeEditCell, didSelectedAge age: String)
}

final class AgeEditCell: UITableViewCell {

    @IBOutlet weak var textField: PickerTextField!
    
    weak var delegate: AgeEditCellDelegate?
    
    lazy var currentValue: String? = textField.pickerContents.first
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
    
}

extension AgeEditCell: UITextFieldDelegate, PickerTextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = currentValue
        if let text = textField.text {
            delegate?.ageEditCell(self, didSelectedAge: text)
        }
    }
    
    func pickerTextField(_ textField: PickerTextField, didSelectPickerValue value: String) {
        delegate?.ageEditCell(self, didSelectedAge: value)
    }
}
