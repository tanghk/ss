//
//  XZPhotoImagePicker.m
//  Market
//
//  Created by Xuz on 2020/3/29.
//  Copyright © 2020 创业酵母. All rights reserved.
//

#import "XZPhotoImagePicker.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>

#import <TZImagePickerController/TZImageManager.h>
#import <TZImagePickerController/TZImagePickerController.h>

@interface XZPhotoImagePicker ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

///系统图片选择控制器
@property(nonatomic, strong)UIImagePickerController *imagePickerVc;
///选择器配置对象
@property(nonatomic, strong)XZPhotoImagePickerConfiger *pickerConfig;
///选择完成回调
@property(nonatomic, copy)void (^successHandle)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,BOOL isCamera,NSString *videoPatch);
///取消选择回调
@property(nonatomic, copy)void (^cancelHandle)(void);

@end

@implementation XZPhotoImagePicker

+ (instancetype)sharedInstance {
    
    static XZPhotoImagePicker *photoPicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        photoPicker = [[XZPhotoImagePicker alloc] init];
    });
    return photoPicker;
}

+ (void)showPhotoPickerConfig:(void (^)(XZPhotoImagePickerConfiger *config))config onSuccess:(void (^)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,BOOL isCamera,NSString *videoPatch))successHandle onCancel:(void (^)(void))cancelHandle {
    
    XZPhotoImagePicker *photoPicker = [XZPhotoImagePicker sharedInstance];
    //配置图片选择
    XZPhotoImagePickerConfiger *pickerConfig = [[XZPhotoImagePickerConfiger alloc] init];
    config(pickerConfig);
    [XZPhotoImagePicker sharedInstance].pickerConfig = pickerConfig;
    photoPicker.successHandle = successHandle;
    photoPicker.cancelHandle = cancelHandle;
    [photoPicker showPhotoPicker];
}

#pragma mark 显示相册或相机
- (void)showPhotoPicker {
    if (_pickerConfig.pickerType == XZPhotoImagePickerTypeAlbum) {
        [self showAlbum];
    }else {
        [self showCamera];
    }
}

#pragma mark 打开拍摄页面
- (void)showCamera{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"无法访问相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (@available(iOS 8.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                }];
            }
        }];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [alertVC addAction:confirmAction];
        [_pickerConfig.presentViewController presentViewController:alertVC animated:YES completion:nil];
    }else if (authStatus == AVAuthorizationStatusNotDetermined) {// fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showCamera];
                });
            }
        }];
    }else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"无法访问相机" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (@available(iOS 8.0, *)) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
                }];
            }
        }];
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:cancelAction];
        [alertVC addAction:confirmAction];
        [_pickerConfig.presentViewController presentViewController:alertVC animated:YES completion:nil];
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self showCamera];
        }];
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            NSMutableArray *mediaTypes = [NSMutableArray array];
            [mediaTypes addObject:(NSString *)kUTTypeImage];
            _imagePickerVc.mediaTypes = mediaTypes;
            [_pickerConfig.presentViewController presentViewController:_imagePickerVc animated:YES completion:nil];
        }else{
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

#pragma mark 打开相册
- (void)showAlbum {
    
    TZImagePickerController *imagePickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:_pickerConfig.maxImagesCount columnNumber:4 delegate:self pushPhotoPickerVc:YES];//最多选择几张      每行排列几个
    
    imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    imagePickerController.statusBarStyle = UIStatusBarStyleDefault;
    imagePickerController.naviBgColor = [UIColor whiteColor];
    imagePickerController.naviTitleColor = Color_MainBlack;
    imagePickerController.barItemTextColor = Color_MainBlue;
    imagePickerController.cancelBtnTitleStr = @"取消";
    imagePickerController.oKButtonTitleColorNormal = Color_MainBlue;
    
    imagePickerController.allowTakePicture = _pickerConfig.allowTakePicture;// 在内部显示拍照按钮
    imagePickerController.allowTakeVideo = _pickerConfig.allowTakeVideo;// 在内部显示拍视频按
    imagePickerController.allowPickingImage = _pickerConfig.allowPickingImage;//是否可以选择图片
    imagePickerController.allowPickingVideo = _pickerConfig.allowPickingVideo;//是否可以选择视频
    imagePickerController.videoMaximumDuration = _pickerConfig.videoMaximumDuration;//拍摄视频的时长
    imagePickerController.allowPickingGif = YES;//是否可以选择gif
    imagePickerController.sortAscendingByModificationDate = NO;//照片排列按修改时间升序
    imagePickerController.allowPickingOriginalPhoto = _pickerConfig.allowPickingOriginalPhoto;//是否选择原图
    
    [imagePickerController setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
        [leftButton setImage:[UIImage imageNamed:@"log_back"] forState:UIControlStateNormal];
        [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        //[leftButton addTarget:self action:@selector(leftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    
    imagePickerController.showSelectedIndex = !_pickerConfig.showSelectedIndex;
    if (_pickerConfig.maxImagesCount > 1) {
        imagePickerController.selectedAssets = _pickerConfig.selectedAssets;
    }
    imagePickerController.showSelectBtn = NO;//是否显示复选框
    imagePickerController.allowCrop = _pickerConfig.allowCrop;
    imagePickerController.needCircleCrop = _pickerConfig.needCircleCrop;
    if (_pickerConfig.allowCrop) {
        if (_pickerConfig.needCircleCrop) {
            imagePickerController.cropRect = CGRectMake(10, (kScreen_Height - kScreen_Width +20)/2, kScreen_Width - 20, kScreen_Width - 20);
        }else{
            imagePickerController.cropRect = _pickerConfig.cropRect;
        }
    }else{
        imagePickerController.cropRect = CGRectMake(10, (kScreen_Height - kScreen_Width +20)/2, kScreen_Width - 20, kScreen_Width - 20);
    }

    __weak typeof(self)weakSelf = self;
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [weakSelf selectPhotoFinishWithAssets:assets images:photos originalPhoto:isSelectOriginalPhoto isCamera:NO isVideoPatch:@""];
    }];
    
    [imagePickerController setImagePickerControllerDidCancelHandle:^{
        [weakSelf selectCancel];
    }];
    [_pickerConfig.presentViewController presentViewController:imagePickerController animated:YES completion:nil];
    
}

//图片选择完成回调
- (void)selectPhotoFinishWithAssets:(NSArray *)assets images:(NSArray<UIImage *> *)images originalPhoto:(BOOL)isSelectOriginalPhoto isCamera:(BOOL)iscamera isVideoPatch:(NSString *)videoPatch{
    if (_successHandle) {
        _successHandle(images,assets,isSelectOriginalPhoto,iscamera,videoPatch);
    }
    
    self.cancelHandle = nil;
    self.successHandle = nil;
    self.imagePickerVc = nil;
    self.pickerConfig = nil;
}

#pragma mark UIImagePickerController协议方法
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    tzImagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    tzImagePickerVc.sortAscendingByModificationDate = YES;//照片排序
    [tzImagePickerVc showProgressHUD];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[TZImageManager manager] savePhotoWithImage:image completion:^(PHAsset *asset, NSError *error) {
            [tzImagePickerVc hideProgressHUD];
            if (error) {
                NSLog(@"图片保存失败 %@",error);
            }else{
                TZAssetModel *assetModel = [[TZImageManager manager] createModelWithAsset:asset];
                if (self->_pickerConfig.allowCrop) { // 允许裁剪,去裁剪
                    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                        
                        [self selectPhotoFinishWithAssets:@[asset] images:@[cropImage] originalPhoto:NO isCamera:YES isVideoPatch:@""];
                    }];
                    imagePicker.allowPickingImage = YES;
                    imagePicker.allowCrop = self->_pickerConfig.allowCrop;
                    imagePicker.needCircleCrop = self->_pickerConfig.needCircleCrop;
                    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
                    if (self->_pickerConfig.allowCrop) {
                        if (self->_pickerConfig.needCircleCrop) {
                            imagePicker.cropRect = CGRectMake(10, (kScreen_Height - kScreen_Width +20)/2, kScreen_Width - 20, kScreen_Width - 20);
                        }else{
                            imagePicker.cropRect = self->_pickerConfig.cropRect;
                        }
                    }else{
                        imagePicker.cropRect = CGRectMake(10, (kScreen_Height - kScreen_Width +20)/2, kScreen_Width - 20, kScreen_Width - 20);
                    }
                    [self->_pickerConfig.presentViewController presentViewController:imagePicker animated:YES completion:nil];
                    
                } else {
                    [self selectPhotoFinishWithAssets:@[assetModel.asset] images:@[image] originalPhoto:YES isCamera:YES isVideoPatch:@""];
                }
            }
        }];
    }
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset {
    
    [MBProgressHUD showActivityMessageInWindow:@"加载中..."];
    // open this code to send video / 打开这段代码发送视频
    [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetHighestQuality success:^(NSString *outputPath) {
        [MBProgressHUD XZHideHUD];
        NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
        [self selectPhotoFinishWithAssets:@[asset] images:@[coverImage] originalPhoto:YES isCamera:YES isVideoPatch:outputPath];
        // Export completed, send video here, send by outputPath or NSData
        // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
    } failure:^(NSString *errorMessage, NSError *error) {
        NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    [self selectCancel];
}

//选择取消回调
- (void)selectCancel {
    if (_cancelHandle) {
        _cancelHandle();
    }
    
    self.cancelHandle = nil;
    self.successHandle = nil;
    self.imagePickerVc = nil;
    self.pickerConfig = nil;
}

/*
 * creat imagePickerVc
 */
- (UIImagePickerController *)imagePickerVc {
    
    if (!_imagePickerVc) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = _pickerConfig.presentViewController.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = _pickerConfig.presentViewController.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (@available(iOS 9.0, *)) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        }else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)dealloc {
    
    NSLog(@"----------YSPhotoPicker 释放");
}

@end



@implementation XZPhotoImagePickerConfiger

- (instancetype)init {
    self = [super init];
    if (self) {
        _maxImagesCount = 9;
        _pickerType = XZPhotoImagePickerTypeAlbum;
        _allowPickingImage = YES;
        _allowPickingVideo = YES;
    }
    return self;
}

@end
