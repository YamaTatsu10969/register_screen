//
//  NickNameEditCell.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/13.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

protocol NickNameEditCellDelegate: AnyObject {
    func nickNameEditCell(_ cell: NickNameEditCell, nickNameDidEditing text: String)
}

final class NickNameEditCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: NickNameEditCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
}

extension NickNameEditCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text ?? "") as NSString
        let resutltString = text.replacingCharacters(in: range, with: string)
        delegate?.nickNameEditCell(self, nickNameDidEditing: resutltString)
        return resutltString.count <= 15
    }
}
