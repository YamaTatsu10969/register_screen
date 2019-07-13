//
//  PlaceEditCell.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/13.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

protocol PlaceEditCellDelegate: AnyObject {
    func PlaceEditCell(_ cell: PlaceEditCell, didSelectedPlace place: String)
}

final class PlaceEditCell: UITableViewCell {

    @IBOutlet weak var textField: PickerTextField!
    lazy var currentValue: String? = textField.pickerContent.first
    
    weak var delegate: PlaceEditCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
}

extension PlaceEditCell: UITextFieldDelegate, PickerTextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = currentValue
        if let text = textField.text {
            delegate?.PlaceEditCell(self, didSelectedPlace: text)
        }
    }
    
    func pickerTextField(_ textField: PickerTextField, didSelectPickerValue value: String) {
        delegate?.PlaceEditCell(self, didSelectedPlace: value)
    }
}
