//
//  UIButton+Creation.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Creation)

/**
 自定义按钮:设置标题及背景色
 */
+ (__kindof UIButton*)createButtonWithFrame:(CGRect)frame titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor title:(NSString *)title;

/**
 自定义按钮:设置图片(选中和正常为一样)
 */
+ (__kindof UIButton*)createButtonWithFrame:(CGRect)frame normalImage:(NSString *)imageStr;

/**
 自定义按钮:设置图片正常与选中
 */
+ (__kindof UIButton*)createButtonWithFrame:(CGRect)frame normalImage:(NSString *)normalImageStr selectedImage:(NSString *)selectedImageStr;

@end

NS_ASSUME_NONNULL_END
