//
//  ModifyProfileViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/08/11.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class ModifyProfileViewController: UIViewController {
    @IBOutlet weak var modifyProfileTableView: UITableView!
    
    // 앨범 선택 image picker
    let imagePickerController = UIImagePickerController()
    var selectedPhoto: UIImage!
    
    var nickName: String!
    var introduction: String!
    var profileImgUrl: String!
    
    var isInit: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // imagePicker delegate
        imagePickerController.delegate = self
        // tableview delegate
        modifyProfileTableView.delegate = self
        modifyProfileTableView.dataSource = self
        // tableview separatorStyle
        modifyProfileTableView.separatorStyle = .none
        // tableview register nib
        let modifyNib = UINib(nibName: "ModifyProfileTableViewCell", bundle: nil)
        modifyProfileTableView.register(modifyNib, forCellReuseIdentifier: "ModifyProfileTableViewCell")
        // tableview row height
        modifyProfileTableView.estimatedRowHeight = 800
        modifyProfileTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Actions
    // MARK: 카메라 버튼 클릭
    @objc func cameraButtonDidTap(_ sender: UIButton) {
        guard let ProfileBottomVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterProfileBottomVC") as? RegisterProfileBottomViewController else {return}
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: ProfileBottomVC)
        self.present(bottomSheet, animated: true, completion: nil)
        ProfileBottomVC.goAlbumButton.addTarget(self, action: #selector(goAlbumButtonDidTap(_:)), for: .touchUpInside)
        ProfileBottomVC.setDefaultImgButton.addTarget(self, action: #selector(setDefaultImgButtonDidTap(_:)), for: .touchUpInside)

        // 아래로 드래그해도 안닫히게 하기
        bottomSheet.dismissOnDraggingDownSheet = false
        // 높이
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 127
        // 뒤에 배경 컬러
        bottomSheet.scrimColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.54)
    }
    // 앨범에서 사진/동영상 선택
    @objc func goAlbumButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    // 기본 이미지로 변경
    @objc func setDefaultImgButtonDidTap(_ sender: UIButton) {
        isInit = false
        self.selectedPhoto = UIImage(named: "logo_profile")!
        self.dismiss(animated: true, completion: nil)
        modifyProfileTableView.reloadData()
    }
    @objc func nickNameTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.nickName = text
    }
    @objc func introductionTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.introduction = text
    }
    // MARK: 수정 완료 버튼 클릭
    @objc func modifyButtonDidTap(_ sender: UIButton) {
        // 프로필 수정 api 호출
        if isInit {
            // 프로필 사진 그대로 (string)
            let userId = UserDefaults.standard.integer(forKey: "userId")
            guard let name = self.nickName else {return}
            guard let profileImgUrl = self.profileImgUrl else {return}
            guard let introduction = self.introduction else {return}
            let modifyProfileInput = ModifyProfileInput(idx: userId, name: name, introduction: introduction, profileImg: profileImgUrl)
            ProfileDataManager().modifyProfileDataManager(modifyProfileInput,self)
        } else {
            // 프로필 사진 수정
            guard let name = self.nickName else {return}
            guard let selectedPhoto = self.selectedPhoto else {return}
            guard let introduction = self.introduction else {return}
            ProfileDataManager().modifyProfileDataManager(name, selectedPhoto, introduction, self)
        }
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
// MARK: - 프로필 수정 페이지 tableView delegate
extension ModifyProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyProfileTableViewCell", for: indexPath) as? ModifyProfileTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        if isInit {
            if let imgUrl = self.profileImgUrl {
                let url = URL(string: imgUrl)
                cell.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
            }
            if let name = self.nickName { cell.nickNameTextField.text = name }
            if let intro = self.introduction {cell.introTextField.text = intro}
        } else {
            if let photo = self.selectedPhoto {
                cell.profileImageView.image = photo
            }
        }
        // MARK: add target
        cell.cameraButton.addTarget(self, action:  #selector(cameraButtonDidTap(_:)), for: .touchUpInside)
        cell.modifyButton.addTarget(self, action:  #selector(modifyButtonDidTap(_:)), for: .touchUpInside)
        cell.nickNameTextField.addTarget(self, action: #selector(nickNameTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.introTextField.addTarget(self, action: #selector(introductionTextFieldEditingChanged(_:)), for: .editingChanged)
        
        return cell
    }
}
// MARK: -  회원가입 사진추가 MDCBottomSheet delegate
extension ModifyProfileViewController: MDCBottomSheetControllerDelegate {
    func bottomSheetControllerDidDismissBottomSheet(_ controller: MDCBottomSheetController) {
        print("바트 시트 닫힘")
    }
    
    func bottomSheetControllerDidChangeYOffset(_ controller: MDCBottomSheetController, yOffset: CGFloat) {
        // 바텀 시트 위치
        print(yOffset)
    }
}
// MARK: - 프로필 이미지 선택 -> 앨범 선택 후
extension ModifyProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isInit = false
        self.selectedPhoto = UIImage()
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.selectedPhoto = image
            modifyProfileTableView.reloadData()
        }
        if let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let urlStr = imageUrl.absoluteString
        }
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: - 프로필 수정 api
extension ModifyProfileViewController {
    func modifyProfileSuccessAPI(_ result: APIModel<ResultModel>) {
        if result.isSuccess! {
            self.dismiss(animated: true, completion: nil)
        } else {
            guard let errorMessage = result.message else {return}
            DialogManager().alertErrorDialog(errorMessage, self)
        }
    }
}
