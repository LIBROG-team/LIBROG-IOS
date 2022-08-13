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

        imagePickerController.delegate = self
        
        modifyProfileTableView.delegate = self
        modifyProfileTableView.dataSource = self
        
        modifyProfileTableView.separatorStyle = .none
        
        let modifyNib = UINib(nibName: "ModifyProfileTableViewCell", bundle: nil)
        modifyProfileTableView.register(modifyNib, forCellReuseIdentifier: "ModifyProfileTableViewCell")
        
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
        //TODO: 프로필 수정 api 호출
        guard let ProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "ProfileVC") as? ProfileViewController else {return}
        ProfileVC.modalPresentationStyle = .fullScreen
        self.present(ProfileVC, animated: true, completion: nil)
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
            if let url = URL(string: self.profileImgUrl) {
                cell.profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
            }
            isInit = false
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 844
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
