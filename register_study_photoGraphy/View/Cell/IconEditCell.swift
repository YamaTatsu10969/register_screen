//
//  IconEditCell.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/13.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

protocol IconEditCellDelegate: AnyObject {
    func iconEditCellDidIconButtonTapped(_ cell: IconEditCell)
}

final class IconEditCell: UITableViewCell {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: IconEditCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // コードでつなげるんやね。
        button.addTarget(self, action: #selector(iconButtonTapped(_:)), for: .touchUpInside)
        button.layer.cornerRadius = button.bounds.width / 2
    }

    // setSelected は消すのか。なんでだろう。
    
    @objc private func iconButtonTapped(_ sender: UIButton) {
        delegate?.iconEditCellDidIconButtonTapped(self)
    }
    
    func setImage(_ image: UIImage) {
        button.setBackgroundImage(image, for: .normal)
    }
    
}
