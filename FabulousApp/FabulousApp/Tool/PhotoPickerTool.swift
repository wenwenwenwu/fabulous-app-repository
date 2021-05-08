//
//  PhotoPickerTool.swift
//  BajieManage
//
//  Created by 邬文文 on 2021/2/23.
//

import Foundation

protocol PhotoPickerToolDelegate: AnyObject {
    func photoPickerToolDidSelectedPhoto(localURL: URL)
}

class PhotoPickerTool: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /**
         如果是相册获取的话，可以从info[.imageURL]获取tem中的路径，相机没有这个属性 file:///private/var/mobile/Containers/Data/Application/FDCEA066-353C-466D-9111-E017ACE81740/tmp/1B34893F-367D-4211-8E8C-C6E40183B1B0.png
         而且这是原图路径，我们还需要对图片做一些处理，不能直接用
         因此还是要自己存一波
         */
        //获取选择的原图
        let pickedImage = info[.originalImage] as! UIImage
        //缓存照片到沙盒(才能上传)
        let localURL = cache(photo: pickedImage)
        //回调照片信息
        delegate?.photoPickerToolDidSelectedPhoto(localURL: localURL)
        //图片控制器退出
        picker.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Method
    func openCamera(){
        UIViewController.resignAllKeyboard() //退出当前控制器的键盘
        let pickerVC = UIImagePickerController()
        pickerVC.delegate = self
        var sourceType = UIImagePickerController.SourceType.camera
        //判断过程在后台线程进行
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            sourceType = UIImagePickerController.SourceType.camera
        }
        pickerVC.sourceType = sourceType
        MAIN_VC.present(pickerVC, animated: true, completion: nil)//进入相机页面
    }
    
    func openAlbum(){
        UIViewController.resignAllKeyboard() //退出当前控制器的键盘
        let pickerVC = UIImagePickerController()
        pickerVC.delegate = self
        pickerVC.allowsEditing = true
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            pickerVC.sourceType = UIImagePickerController.SourceType.photoLibrary
            pickerVC.mediaTypes = UIImagePickerController.availableMediaTypes(for: pickerVC.sourceType)!
        }
        MAIN_VC.present(pickerVC, animated: true, completion: nil) //进入相册页面
    }
    
    private func cache(photo: UIImage) -> URL {
        //缩图
        let compressedPhoto = compress(photo: photo)
        //压图
        let photoData = compressedPhoto.jpegData(compressionQuality: 0.1)!
        return CacheTool.saveFile(data: photoData, name: "\(uniqueFileName()).jpg")
    }
    
    private func compress(photo: UIImage) -> UIImage {
        //缩成宽为手机屏宽，高度自适应的图片
        let photoHeight = SCREEN_WIDTH * photo.size.height / photo.size.width
        let photoWidth = SCREEN_WIDTH
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: photoWidth, height: photoHeight), false, 0)
        photo.draw(in: CGRect.init(x: 0, y: 0, width: photoWidth, height: photoHeight))
        let processedPhoto = UIGraphicsGetImageFromCurrentImageContext()
        return processedPhoto!
    }
    
    private func uniqueFileName() -> String {
        var fileName = ""
        let dateStr = String(Date().timeIntervalSince1970)
        fileName = "daoqi\(dateStr)"
        return fileName
    }
    
    //MARK: - Component
    weak var delegate: PhotoPickerToolDelegate?
    
}

