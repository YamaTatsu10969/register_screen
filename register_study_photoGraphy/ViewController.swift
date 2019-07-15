//
//  ViewController.swift
//  register_study_photoGraphy
//
//  Created by Tatsuya Yamamoto on 2019/7/11.
//  Copyright © 2019 山本竜也. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // 大きく分けるセクションタイプが２つある
    fileprivate enum SectionType: Int {
        case basicInfo
        case bio
    }
    
    // basicInfo の中に、行のタイプがある
    fileprivate enum RowType: Int {
        case basicInfoIcon
        case basicInfoNickName
        case basicInfoGender
        case basicInfoAge
        case basicInfoPlace
        case bioBio
    }
    
    // structでセクションを生成
    // 上で作成した、セクションタイプと、ロータイプを持っている
    fileprivate struct Section {
        var sectionType: SectionType
        var rowItems: [RowType]
    }
    
    // セクションが入るセクションズをもつ
    fileprivate var sections: [Section]!
    
    //　srotyboard と連結する
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    
    // プロパティ この要素が編集中に書き変わって、登録の際に利用する
    fileprivate var newName: String?
    fileprivate var newGender: Int?
    fileprivate var newArea: String?
    fileprivate var newAge: String?
    fileprivate var newBio: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // navigation var にアクションを追加する時には、addTargetではないらしい。これらしい。
        rightBarButton.target = self
        rightBarButton.action = #selector(saveButtonTapped(_:))
        
        // まずはセクションズを生成。構成が、1つ目のセクションに5つ。2つ目のセクションに1つ入っている。
        // ここで表示する順番が指定されている。
        sections = [
            Section(sectionType: .basicInfo, rowItems: [.basicInfoIcon, .basicInfoNickName, .basicInfoGender, .basicInfoAge, .basicInfoPlace]),
            Section(sectionType: .bio, rowItems: [.bioBio])
        ]
        
        // tableView関連だな。登録とdelegateのセット。
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "IconEditCell", bundle: nil), forCellReuseIdentifier: IconEditCell.description())
        tableView.register(UINib(nibName: "NickNameEditCell", bundle: nil), forCellReuseIdentifier: NickNameEditCell.description())
        tableView.register(UINib(nibName: "GenderEditCell", bundle: nil), forCellReuseIdentifier: GenderEditCell.description())
        tableView.register(UINib(nibName: "AgeEditCell", bundle: nil), forCellReuseIdentifier: AgeEditCell.description())
        tableView.register(UINib(nibName: "PlaceEditCell", bundle: nil), forCellReuseIdentifier: PlaceEditCell.description())
        tableView.register(UINib(nibName: "BioEditCell", bundle: nil), forCellReuseIdentifier: BioEditCell.description())
    }
    
    
    @objc private func saveButtonTapped(_ sender: UIBarButtonItem) {
        // guard let はバリデーション的な要素。空欄だったら、エラーアラートを表示する。
        guard let newName = newName else {
            let errorAlert = UIAlertController(title: "ニックネームを入力してください", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                errorAlert.dismiss(animated: true, completion: nil)
            }
            errorAlert.addAction(okAction)
            present(errorAlert, animated: true, completion: nil)
            return
        }
        
        guard let newGender = newGender else {
            let errorAlert = UIAlertController(title: "性別を選択してください", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                errorAlert.dismiss(animated: true, completion: nil)
            }
            errorAlert.addAction(okAction)
            present(errorAlert, animated: true, completion: nil)
            return
        }
        
        guard let newArea = newArea else {
            let errorAlert = UIAlertController(title: "場所を入力してください", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                errorAlert.dismiss(animated: true, completion: nil)
            }
            errorAlert.addAction(okAction)
            present(errorAlert, animated: true, completion: nil)
            return
        }
        
        guard let newAge = newAge else {
            let errorAlert = UIAlertController(title: "年齢を入力してください", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                errorAlert.dismiss(animated: true, completion: nil)
            }
            errorAlert.addAction(okAction)
            present(errorAlert, animated: true, completion: nil)
            return
        }
        
        // 非同期処理に入る前に二度目の登録が押せないようにしておく
        view.isUserInteractionEnabled = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // SignUpOperationの execute を呼び出しているだけ。
        SignUpOperation(name: newName, gender: newGender, area: newArea, age: newAge, bio: newBio).execute(in: AppDispatcher.appDispatcher()).then(in: .main) { (user) in
            
            // error は返ってこないんかな。下にあった！！！user が返ってきたら、error が返ってきたら下なのか！
            
            // 非同期処理が終わったタイミングで、画面操作をできるようにする
            self.view.isUserInteractionEnabled = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            let sucsessAlert = UIAlertController(title: "ユーザー登録が完了しました", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                sucsessAlert.dismiss(animated: true, completion: nil)
            })
            sucsessAlert.addAction(okAction)
            self.present(sucsessAlert, animated: true, completion: nil)
            
            // UserDefaultsに保存する。
            let userAsJSON = try! JSONEncoder().encode(user)
            // Userdefalts にこのキャッシュキーで保存している
            UserDefaults.standard.setValue(userAsJSON, forKey: CacheKey.myInfo)
            // 同期している
            UserDefaults.standard.synchronize()
            
            }.catch(in: .main) { (error) in
                
                self.view.isUserInteractionEnabled = true
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                let errorMessage = ErrorMessage(error: error)
                let errorAlert = UIAlertController(title: errorMessage.errorMessage, message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                    errorAlert.dismiss(animated: true, completion: nil)
                })
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // これを入れると、セレクトした後に、背景色が元に戻る。
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rowItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPathのセクションと、ローで表示を切り替えている。
        switch sections[indexPath.section].rowItems[indexPath.row] {
        case .basicInfoIcon:
            let cell = tableView.dequeueReusableCell(withIdentifier: IconEditCell.description()) as! IconEditCell
            cell.delegate = self
            return cell
        case .basicInfoNickName:
            let cell = tableView.dequeueReusableCell(withIdentifier: NickNameEditCell.description()) as! NickNameEditCell
            cell.delegate = self
            return cell
        case .basicInfoGender:
            let cell = tableView.dequeueReusableCell(withIdentifier: GenderEditCell.description()) as! GenderEditCell
            cell.delegate = self
            return cell
        case .basicInfoAge:
            let cell = tableView.dequeueReusableCell(withIdentifier: AgeEditCell.description()) as! AgeEditCell
            cell.delegate = self
            var ageStrings = [String]()
            (18..<100).forEach {
                ageStrings.append(String(describing: $0))
            }
            cell.textField.pickerContents = ageStrings
            return cell
        case .basicInfoPlace:
            let cell = tableView.dequeueReusableCell(withIdentifier: PlaceEditCell.description()) as! PlaceEditCell
            cell.delegate = self
            cell.textField.pickerContents = Prefecture.allCases.map { $0.rawValue }
            return cell
        case .bioBio:
            let cell = tableView.dequeueReusableCell(withIdentifier: BioEditCell.description()) as! BioEditCell
            cell.delegate = self
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch sections[section].sectionType {
        case .basicInfo:
            return "情報"
        case .bio:
            return "自己紹介"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
}

extension ViewController: IconEditCellDelegate {
    func iconEditCellDidIconButtonTapped(_ cell: IconEditCell) {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            picker.dismiss(animated: true, completion: nil)
            let iconEditCellIndexPath = IndexPath(row: RowType.basicInfoIcon.rawValue, section: SectionType.basicInfo.rawValue)
            let iconEditCell = tableView.cellForRow(at: iconEditCellIndexPath) as! IconEditCell
            iconEditCell.setImage(image)
        }
    }
}

// 編集されている時に、プロパティに記述した内容をいれる。
extension ViewController: NickNameEditCellDelegate {
    func nickNameEditCell(_ cell: NickNameEditCell, nickNameDidEditing text:String) {
        newName = text
    }
}

extension ViewController: GenderEditCellDelegate {
    func genderEditCell(_ cell: GenderEditCell, didSelectGenderButton tag: Int) {
        newGender = tag
    }
}

extension ViewController: AgeEditCellDelegate {
    func ageEditCellDidDoneButtonTapped(_ cell: AgeEditCell) {
    }
    
    func ageEditCell(_ cell: AgeEditCell, didSelectedAge age: String) {
        newAge = age
    }
}

extension ViewController: PlaceEditCellDelegate {
    func placeEditCell(_ cell: PlaceEditCell, didSelectedPlace place: String) {
        newArea = place
    }
}

extension ViewController: BioEditCellDelegate {
    func bioEditCell(_ cell: BioEditCell, didEditingBio bio: String) {
        newBio = bio
    }
}

