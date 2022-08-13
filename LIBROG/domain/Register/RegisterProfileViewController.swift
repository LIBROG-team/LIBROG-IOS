//
//  RegisterProfileViewController.swift
//  LIBROG
//
//  Created by gomin on 2022/07/28.
//

import UIKit
import MaterialComponents.MaterialBottomSheet

class RegisterProfileViewController: UIViewController {

    @IBOutlet weak var reigsterProfileTableView: UITableView!
    
    
    // 앨범 선택 image picker
    let imagePickerController = UIImagePickerController()
    var selectedPhoto: UIImage = UIImage(named: "logo_profile")!
    
    var email: String!
    var password: String!
    var nickName: String!
    var profileImgUrl: String!
    var introduction: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickerController.delegate = self
        reigsterProfileTableView.delegate = self
        reigsterProfileTableView.dataSource = self
        
        reigsterProfileTableView.separatorStyle = .none
        
        let profileNib = UINib(nibName: "RegisterProfileTableViewCell", bundle: nil)
        reigsterProfileTableView.register(profileNib, forCellReuseIdentifier: "RegisterProfileTableViewCell")
        
        reigsterProfileTableView.estimatedRowHeight = 500
        reigsterProfileTableView.rowHeight = UITableView.automaticDimension
    }
    //MARK: 화면 터치 시 키보드 내리기
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Actions
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
        reigsterProfileTableView.reloadData()
    }
    // MARK: 카메라 버튼 클릭
    @objc func cameraDidTapButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterProfileBottomVC") as! RegisterProfileBottomViewController
        let bottomSheet: MDCBottomSheetController = MDCBottomSheetController(contentViewController: vc)
        self.present(bottomSheet, animated: true, completion: nil)
        vc.goAlbumButton.addTarget(self, action: #selector(goAlbumButtonDidTap(_:)), for: .touchUpInside)
        vc.setDefaultImgButton.addTarget(self, action: #selector(setDefaultImgButtonDidTap(_:)), for: .touchUpInside)

        // 아래로 드래그해도 안닫히게 하기
        bottomSheet.dismissOnDraggingDownSheet = false
        // 높이
        bottomSheet.mdc_bottomSheetPresentationController?.preferredSheetHeight = 127
        // 뒤에 배경 컬러
        bottomSheet.scrimColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.54)
    }
    // 자기소개
    @objc func introductionTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.introduction = text
    }
    // 뒤로가기
    @IBAction func goBackButtonDidTap(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    // MARK: '리브로그 시작하기' 버튼 클릭
    @objc func registerBtnDidTap(_ sender: UIButton) {
        RegisterDataManager().registerMultipartDataManager(self.email, self.password, self.nickName, self.selectedPhoto, self.introduction, self)
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

// MARK: - 회원가입 프로필 사진/자기소개 입력 페이지 tableView delegate
extension RegisterProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterProfileTableViewCell", for: indexPath) as? RegisterProfileTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.profileImageView.image = self.selectedPhoto
        cell.userNameLabel.text = self.nickName
        // MARK: add target
        cell.introTextField.addTarget(self, action: #selector(introductionTextFieldEditingChanged(_:)), for: .editingChanged)
        cell.registerButton.addTarget(self, action: #selector(registerBtnDidTap(_:)), for: .touchUpInside)
        cell.cameraButton.addTarget(self, action: #selector(cameraDidTapButton(_:)), for: .touchUpInside)
        
        return cell
    }
}
// MARK: - 프로필 이미지 선택 -> 앨범 선택 후
extension RegisterProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.selectedPhoto = UIImage()
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.selectedPhoto = image
            reigsterProfileTableView.reloadData()
        }
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - 회원가입 성공 api
extension RegisterProfileViewController {
    func RegisterSuccessAPI(_ result: RegisterModel) {
        guard let userId = result.createdUserIdx else {return}
        UserDefaults.standard.set(userId, forKey: "userId")
        ScreenManager().goMain(self)
    }
}
