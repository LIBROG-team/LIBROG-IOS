//
//  RegisterProfileViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class RegisterProfileViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBAction func registerBtnDidTap(_ sender: UIButton) {
        guard let LoginVC = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(identifier: "LoginVC") as? LoginViewController else {return}
        LoginVC.modalPresentationStyle = .fullScreen
        self.present(LoginVC, animated: true, completion: nil)
    }
    
    let selectArray = ["앨범에서 사진/동영상 선택", "리브로그 프로필로 설정", "기본 이미지로 변경"]
    // 앨범 선택 image picker
    let imagePickerController = UIImagePickerController()
    var selectedPhoto: UIImage!
    var userNameText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 리브로그 시작하기 버튼 Custom
        registerButton.layer.borderColor = UIColor(named: "LIBROGColor")?.cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 20
        registerButton.tintColor = UIColor(named: "LIBROGColor")
        
        imagePickerController.delegate = self
        
        userNameLabel.text = userNameText
    }
    @IBAction func cameraDidTapButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterProfileBottomVC") as! RegisterProfileBottomViewController
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        self.present(bottomSheet, animated: true, completion: nil)
        vc.setTableViewDataSourceDelegate(dataSourceDelegate: self)

        // 아래로 드래그해도 안닫히게 하기
        bottomSheet.dismissOnDraggingDownSheet = false
        // 높이
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 177
        // 뒤에 배경 컬러
        bottomSheet.scrimColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.54)
    }
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func registerButtonDidTap(_ sender: UIButton) {
    }
}

// MARK: -  회원가입 사진추가 MDCBottomSheet delegate
extension RegisterProfileViewController: MDCBottomSheetControllerDelegate {
    func bottomSheetControllerDidDismissBottomSheet(_ controller: MDCBottomSheetController) {
        print("바트 시트 닫힘")
    }
    
    func bottomSheetControllerDidChangeYOffset(_ controller: MDCBottomSheetController, yOffset: CGFloat) {
        // 바텀 시트 위치
        print(yOffset)
    }
}

// MARK: - 이미지 종류 메뉴 Table view data source
extension RegisterProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.contentInsetAdjustmentBehavior = .never
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        if indexPath.row == 0 { cell.textLabel?.text = selectArray[0] }
        else if indexPath.row == 1 { cell.textLabel?.text = selectArray[1] }
        else if indexPath.row == 2 { cell.textLabel?.text = selectArray[2] }
        return cell
    }
    //셀 세로 길이 조절
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    //클릭 이벤트 처리
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 앨범에서 선택
        if indexPath.row == 0 {
            self.dismiss(animated: true, completion: nil)
            self.imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }
        else if indexPath.row == 2 {
            profileImageView.image = UIImage(named: "logo_profile")
            self.dismiss(animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
// MARK: - 프로필 이미지 선택 -> 앨범 선택 후
extension RegisterProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
//        uploadTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}
