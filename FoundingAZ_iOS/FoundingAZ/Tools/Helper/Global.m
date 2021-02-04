//
//  Global.m
//  iMuGou
//
//  Created by YYK on 2017/5/20.
//  Copyright © 2017年 imugou. All rights reserved.
//

#import "Global.h"
#import "MJPhoto.h"
#import "MyDateTimeView.h"
#import "MJPhotoBrowser.h"
#import <AVFoundation/AVCaptureDevice.h>
//#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>
//#import <MobileCoreServices/MobileCoreServices.h>



@implementation Global


+(instancetype)shareGlobal
{
    static Global * global;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        global=[[Global alloc]init];
    });
    return global;
}


-(instancetype)init
{
    self=[super init];
    if (self) {
        
    }
    return self;
}



#pragma mark - 选择相册 拍照
-(void)pickImageBySourceType:(UIImagePickerControllerSourceType)sourceType ShowView:(UIViewController *)showView pickerSuccessed:(void (^)(UIImage *image))pickerSuccessBlock
{
    _pickerImageBlock=pickerSuccessBlock;
    UIImagePickerController *pickerer = [[UIImagePickerController alloc] init];
    pickerer.delegate=self;
    //设置选择后的图片可被编辑
    pickerer.allowsEditing = YES;
    pickerer.sourceType=sourceType;
    if (sourceType==UIImagePickerControllerSourceTypeCamera) {
        //判断应用是否有权限访问系统相册/相机    add by Qu - 160323
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
            
            [CusAlertView showCusAlertViewWithTitle:@"提示" message:@"请在'设置-隐私-相机'中允许App访问您的相机" cancleButtonTitle:@"知道了" clickHandle:^(NSInteger index) {
                
            }];
        }
        else{
            if ([UIImagePickerController isSourceTypeAvailable: sourceType]){
                [showView presentViewController:pickerer animated:YES completion:nil];
                [pickerer takePicture];
            }
            else{
                NSLog(@"模拟其中无法打开照相机,请在真机中使用");
            }
        }
    }
    else{//判断用户是否允许访问相册     add by Qu - 160323
        ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
        if (authStatus == ALAuthorizationStatusRestricted || authStatus == ALAuthorizationStatusDenied) {
            [CusAlertView showCusAlertViewWithTitle:@"提示" message:@"您没有授权此应用访问您的相册或视频。请在“隐私设置”中启用访问。" cancleButtonTitle:@"知道了" clickHandle:^(NSInteger index) {
                
            }];
        }
        else{
            [showView presentViewController:pickerer animated:YES completion:nil];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
//定义图片编辑页面
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        [picker dismissViewControllerAnimated:YES completion:^{
            UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
            self->_pickerImageBlock(image);
        }];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 单张照片选择提示框

-(void)showPickPhotoAlertSelectSuccess:(void(^)(UIImage *image,NSInteger sourceType))selectSuccess InView:(UIViewController *)viewController{
    [viewController.view endEditing:YES];
    
    UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pickImageBySourceType:UIImagePickerControllerSourceTypeCamera ShowView:viewController pickerSuccessed:^(UIImage *image) {
            selectSuccess(image,UIImagePickerControllerSourceTypeCamera);
        }];
    }];
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionsheet addAction:camera];
    [actionsheet addAction:photoLibrary];
    [viewController presentViewController:actionsheet animated:YES completion:^{
        [self pickImageBySourceType:UIImagePickerControllerSourceTypePhotoLibrary ShowView:viewController pickerSuccessed:^(UIImage *image) {
            selectSuccess(image,UIImagePickerControllerSourceTypePhotoLibrary);
        }];
    }];
}





#pragma mark - 预览图片

-(void)browserImageWithArray:(NSArray *)imageArray CurrentImageView:(UIImageView *)currentImageView{
    NSMutableArray *photosArr = [NSMutableArray array];
    for (int i=0; i<[imageArray count]; i++) {
        
        NSString *imgUrl = imageArray[i];
        NSString *strSmall = @"_small";
        NSRange smallSymbolRange = [imgUrl rangeOfString:strSmall];
        NSString *newUrl = @"";
        if (smallSymbolRange.location!=NSNotFound && smallSymbolRange.length==[strSmall length]) {
//          获取头像的大图地址:newUrl
            newUrl = [imgUrl stringByReplacingCharactersInRange:smallSymbolRange withString:@""];
        }
        else {
            newUrl = imgUrl;
        }
 
        MJPhoto *photo = [[MJPhoto alloc] init];
        if (!isNil(imgUrl)) {
            photo.url = [NSURL URLWithString:imgUrl];
        }
        else {
            photo.url = nil;
        }
        photo.srcImageView = currentImageView;
        [photosArr addObject:photo];
    }
    // 2.显示相册
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = currentImageView.tag;
    browser.photos = photosArr;
    browser.showDeletePicBtn = NO;
    browser.showSavePicBtn = YES;
    [browser show];

}


#pragma mark - 选择日期

-(void)showSelectDateTimeType:(NSInteger)dateType Complete:(void(^)(NSString *strDate))complete{
    MyDateTimeView *pickerView = [[MyDateTimeView alloc]initWithFrame:ScreenFrame DatePickerViewType:dateType DidConfirmAction:^(NSString *stringDate) {
        complete(stringDate);
    }];
    [pickerView show];
}



@end
