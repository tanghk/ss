//
//  MJPhotoToolbar.m
//  FingerNews
//
//  Created by mj on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoToolbar.h"
#import "MJPhoto.h"
//#import "MBProgressHUD+Add.h"
#import "SVProgressHUD.h"

@interface MJPhotoToolbar()

@end

@implementation MJPhotoToolbar

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = kColorFromRGB(27, 27, 27);
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    _currentPhotoIndex = -1;
    
    CGFloat btnWidth = self.bounds.size.height;
    // 保存图片按钮
    if (_showSavePicBtn) {
        saveImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        saveImageBtn.frame = CGRectMake(20, 0, btnWidth, btnWidth);
        saveImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [saveImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/saveIcon.png"] forState:UIControlStateNormal];
        [saveImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/saveIcon_highlighted.png"] forState:UIControlStateHighlighted];
        [saveImageBtn addTarget:self action:@selector(saveImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:saveImageBtn];
        saveImageBtn.enabled = YES;
    }
    
    //图片索引:1/3
    if (_photos.count > 1) {
        _indexLabel = [[UILabel alloc] initWithFrame:CGRectMake(saveImageBtn.frameRight, 0, kScreen_Width-saveImageBtn.frameRight*2, btnWidth)];
        _indexLabel.font = [UIFont boldSystemFontOfSize:20];
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_indexLabel];
    }
    
    //删除图片按钮
    if (_showDeletePicBtn) {
        deleteImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        deleteImageBtn.frame = CGRectMake(kScreen_Height-20-btnWidth, 0, btnWidth, btnWidth);
        deleteImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [deleteImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/deleteIcon"] forState:UIControlStateNormal];
        [deleteImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/deleteIcon_highlighted"] forState:UIControlStateHighlighted];
        [deleteImageBtn addTarget:self action:@selector(deleteImageBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteImageBtn];
    }
    
}

/**
 *	@brief	保存图片到本地相册
 */
- (void)saveImageBtnAction
{
//    Alice_Debug(@"保存图片");
    if (saveImageBtn.enabled) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            MJPhoto *photo = self->_photos[self->_currentPhotoIndex];
            UIImageWriteToSavedPhotosAlbum(photo.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        });
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"不可重复保存"];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else {
        MJPhoto *photo = _photos[_currentPhotoIndex];
        photo.save = YES;
        saveImageBtn.enabled = NO;
        [SVProgressHUD showSuccessWithStatus:@"成功保存到相册"];
    }
}
//删除图片
-(void)deleteImageBtnAction
{
//    NSInteger index = [_indexLabel.text integerValue]-1;
//    [delegate deletePicWithIndex:index];
}

- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _indexLabel.text = [NSString stringWithFormat:@"%@ / %@", @(_currentPhotoIndex + 1), @(_photos.count)];
    
    //按钮控制
    MJPhoto *photo = _photos[_currentPhotoIndex];
    saveImageBtn.enabled = photo.image!=nil && !photo.save;
    
}

@end
