//
//  BioEditCell.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/13.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

protocol BioEditCellDelegate: AnyObject {
    func bioEditCell(_ cell: BioEditCell, didEditingBio bio: String)
}

final class BioEditCell: UITableViewCell {

    @IBOutlet weak var textView: PlaceholderTextView!
    @IBOutlet weak var countLabel: UILabel!
    
    weak var delegate: BioEditCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        textView.placeholder = "どんな人？"
        textView.placeholderTextColor = UIColor(named: "textBlack54")
    }
}

extension BioEditCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let textCount = 100 - textView.text.count
        var countLabelText: String!
        if textCount > 0 {
            countLabelText = "\(textCount)/100"
        } else {
            countLabelText = "0/100"
        }
        countLabel.text = countLabelText
        delegate?.bioEditCell(self, didEditingBio: textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text.mutableCopy() as? NSMutableString else { return true }
        str.replaceCharacters(in: range, with: text)
        return (str as String).count <= 100
    }
}
