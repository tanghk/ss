//
//  Global.h
//  iMuGou
//
//  Created by YYK on 2017/5/20.
//  Copyright © 2017年 imugou. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "MyDateTimeView.h"
//#import "DatePickerView.h"

//多选、单选
typedef NS_ENUM(NSInteger, SelectType)
{
    SelectType_Multip,
    SelectType_Single,
};

typedef void(^pickerImageSuccess)(UIImage *image);  //拍摄、选取照片


@interface Global : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (copy, nonatomic)pickerImageSuccess   pickerImageBlock;

//这里存放一些需要应用跨页面使用的变量



+(instancetype)shareGlobal;

//拍照 选择相册
-(void)pickImageBySourceType:(UIImagePickerControllerSourceType)sourceType ShowView:(UIViewController *)showView pickerSuccessed:(void(^)(UIImage *image))pickerSuccessBlock;

#pragma mark - 单张照片选择提示框 直接返回图片

-(void)showPickPhotoAlertSelectSuccess:(void(^)(UIImage *image,NSInteger sourceType))selectSuccess InView:(UIViewController *)viewController;


#pragma mark - 预览图片

-(void)browserImageWithArray:(NSArray *)imageArray CurrentImageView:(UIImageView *)currentImageView;


#pragma mark - 选择日期

-(void)showSelectDateTimeType:(NSInteger)dateType Complete:(void(^)(NSString *strDate))complete;


@property (nonatomic, assign) NSInteger isForceUpdate;  //是否强制更新
@property (nonatomic, assign) BOOL isShowUpdate;  //是否已显示更新弹框

@end
