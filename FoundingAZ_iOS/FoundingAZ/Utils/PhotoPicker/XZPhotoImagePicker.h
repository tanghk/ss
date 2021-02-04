//
//  XZPhotoImagePicker.h
//  Market
//
//  Created by Xuz on 2020/3/29.
//  Copyright © 2020 创业酵母. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XZPhotoImagePickerConfiger;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XZPhotoImagePickerType) {
    ///相册
    XZPhotoImagePickerTypeAlbum,
    ///相机
    XZPhotoImagePickerTypeCamera
};

@interface XZPhotoImagePicker : NSObject

+ (void)showPhotoPickerConfig:(void (^)(XZPhotoImagePickerConfiger *config))config onSuccess:(void (^)(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,BOOL isCamera,NSString *videoPatch))successHandle onCancel:(void (^)(void))cancelHandle;

@end

NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN
@interface XZPhotoImagePickerConfiger : NSObject

///当前显示的控制器
@property(nonatomic, strong)UIViewController *presentViewController;
//允许选择的最大图片数
@property(nonatomic, assign)NSInteger maxImagesCount;
//是否可以选择原图
@property (nonatomic , assign) BOOL allowPickingOriginalPhoto;

///当选择单个图片时，是否需要裁切, 需要传 裁剪rect
@property(nonatomic, assign)BOOL                allowCrop;
@property (nonatomic , assign)  CGRect       cropRect;///< 裁剪框大小

@property(nonatomic, assign)BOOL                needCircleCrop;///< 是否需要圆型裁剪框
@property (nonatomic, assign) NSInteger circleCropRadius;  ///< 圆形裁剪框半径大小


///是否在图片选择器中显示右上角选中的序号 YES - 不显示 ，NO - 显示。默认显示
@property (nonatomic , assign) BOOL             showSelectedIndex;
///已经选中的图片Asset
@property(nonatomic, copy)NSMutableArray        *selectedAssets;
///照片选择器类型
@property(nonatomic, assign)XZPhotoImagePickerType   pickerType;
///是否限制图片发送的质量
@property(nonatomic, assign)BOOL                limitImageQuality;
///图片允许发送的最大质量 单位:字节
@property(nonatomic, assign)NSUInteger          imageMaxQuality;
//是否可以选择照片
@property (nonatomic, assign) BOOL allowPickingImage;
//是否可以拍照片
@property (nonatomic, assign) BOOL allowTakePicture;
//是否可以选择视频
@property (nonatomic, assign) BOOL allowPickingVideo;
//是否可以拍视频
@property (nonatomic, assign) BOOL allowTakeVideo;
// Default value is 10 minutes / 视频最大拍摄时间，默认是10分钟，单位是秒
@property (assign, nonatomic) NSTimeInterval videoMaximumDuration;

@end
NS_ASSUME_NONNULL_END
