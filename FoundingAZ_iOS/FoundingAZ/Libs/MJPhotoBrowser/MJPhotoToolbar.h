//
//  MJPhotoToolbar.h
//  FingerNews
//
//  Created by mj on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MJPhotoToolbarDelegate <NSObject>

-(void)deletePicWithIndex:(NSInteger)index;


@end


@interface MJPhotoToolbar : UIView
{
    // 显示页码
    UILabel *_indexLabel;
    // 保存图片
    UIButton *saveImageBtn;
    // 删除图片
    UIButton *deleteImageBtn;
}


// 所有的图片对象
@property (nonatomic, strong) NSArray *photos;
// 当前展示的图片索引
@property (nonatomic, assign) NSUInteger currentPhotoIndex;

//工具栏显示保存按钮
@property (nonatomic, assign) BOOL showSavePicBtn;
//工具栏显示删除按钮
@property (nonatomic, assign) BOOL showDeletePicBtn;

@property (nonatomic,assign) id delegate;

@end
