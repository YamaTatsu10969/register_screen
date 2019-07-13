//
//  GenderEditCell.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/13.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

protocol GenderEditCellDelegate: AnyObject {
    func genderEditCell(_ cell: GenderEditCell, didSelectGenderButton tag: Int)
}

final class GenderEditCell: UITableViewCell {
    
    @IBOutlet weak var notsetGenderButton: UIButton!
    @IBOutlet weak var womanGencerButton: UIButton!
    @IBOutlet weak var manGenderButton: UIButton!

    weak var delegate: GenderEditCellDelegate?
    
    private var buttons: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // buttonをまとめて処理するために、この処理が必要。めちゃ便利
        buttons = [UIButton]()
        buttons.append(notsetGenderButton)
        buttons.append(womanGencerButton)
        buttons.append(manGenderButton)
        
        for i in buttons {
            i.layer.cornerRadius = i.bounds.size.width / 2
            i.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
        }
    }

    @objc private func genderButtonTapped(_ sender: UIButton) {
        for i in buttons {
            i.isSelected = false
            i.layer.borderWidth = 0
            i.layer.borderColor = UIColor.clear.cgColor
        }
        sender.isSelected = true
        sender.layer.borderWidth = 1.5
        sender.layer.borderColor = UIColor(named: "gender_border")?.cgColor
        delegate?.genderEditCell(self, didSelectGenderButton: sender.tag)
    }
    
}
