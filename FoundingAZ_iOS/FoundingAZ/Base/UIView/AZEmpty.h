//
//  AZEmpty.h
//  FoundingAZ
//
//  Created by mark on 2021/1/29.
//

#import <LYEmptyView/LYEmptyView.h>

NS_ASSUME_NONNULL_BEGIN

@interface AZEmpty : LYEmptyView
/////////属性传递(可修改)
/* image 的优先级大于 imageStr，只有一个有效*/
@property (nonatomic, strong)UIImage *image;
@property (nonatomic, copy) NSString *imageStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *detailStr;
@property (nonatomic, copy) NSString *btnTitleStr;

+ (instancetype)diyNoDataEmpty;

+ (instancetype)diyNoNetworkEmptyWithTarget:(id)target action:(SEL)action;

+ (instancetype)diyCustomEmptyViewWithTarget:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
