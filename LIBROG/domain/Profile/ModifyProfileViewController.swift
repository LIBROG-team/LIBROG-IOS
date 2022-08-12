//
//  ModifyProfileViewController.swift
//  LIBROG
//
//  Created by 최승희 on 2022/08/11.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class ModifyProfileViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var modifyButton: UIButton!
    
    let selectArray = ["앨범에서 사진/동영상 선택", "기본 이미지로 변경"]
    // 앨범 선택 image picker
    let imagePickerController = UIImagePickerController()
    var selectedPhoto: UIImage!
    var userNameText: String!
    var email: String!
    var password: String!
    var nickName: String!
    var profileImgUrl: String!
    var introduction: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 리브로그 시작하기 버튼 Custom
        modifyButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        modifyButton.layer.borderWidth = 1
        modifyButton.layer.cornerRadius = 20
        modifyButton.tintColor = UIColor(named: "LIBROGColor")
        
        imagePickerController.delegate = self
        
        userNameLabel.text = userNameText
        if let url = URL(string: self.profileImgUrl) {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(named: "logo22%"))
        }
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Actions
    // MARK: 카메라 버튼 클릭
    @IBAction func cameraButtonDidTap(_ sender: UIButton) {
        guard let ProfileBottomVC = UIStoryboard(name: "Register", bundle: nil).instantiateViewController(identifier: "RegisterProfileBottomVC") as? RegisterProfileBottomViewController else {return}
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: ProfileBottomVC)
        self.present(bottomSheet, animated: true, completion: nil)

        // 아래로 드래그해도 안닫히게 하기
        bottomSheet.dismissOnDraggingDownSheet = false
        // 높이
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 127
        // 뒤에 배경 컬러
        bottomSheet.scrimColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.54)
    }
    
    @IBAction func modifyButtonDidTap(_ sender: UIButton) {
        guard let ProfileVC = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(identifier: "ProfileVC") as? ProfileViewController else {return}
        ProfileVC.modalPresentationStyle = .fullScreen
        self.present(ProfileVC, animated: true, completion: nil)
    }
    
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func introductionTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.introduction = text
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
            profileImageView.image = self.selectedPhoto
//            print(info)
        }
        if let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            let urlStr = imageUrl.absoluteString
        }
        self.dismiss(animated: true, completion: nil)
    }
}
