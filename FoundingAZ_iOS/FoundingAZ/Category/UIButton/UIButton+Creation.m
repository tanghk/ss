//
//  UIButton+Creation.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "UIButton+Creation.h"

@implementation UIButton (Creation)

///自定义按钮:设置标题及背景色
+ (__kindof UIButton*)createButtonWithFrame:(CGRect)frame titleColor:(UIColor *)titleColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor title:(NSString *)title{
    UIButton *button = [UIButton createButtonWithFrame:frame normalTitle:title normalColor:titleColor selectedTitle:nil selectedColor:nil font:font normalImage:nil selectedImage:nil normalBackgroundImage:nil selectedBackgroundImage:nil backgroundColor:backgroundColor];
    return button;
}

///自定义按钮:设置图片(选中和正常为一样)
+ (__kindof UIButton*)createButtonWithFrame:(CGRect)frame normalImage:(NSString *)imageStr{
    UIButton *button = [UIButton createButtonWithFrame:frame normalTitle:nil normalColor:nil selectedTitle:nil selectedColor:nil font:nil normalImage:imageStr selectedImage:imageStr normalBackgroundImage:nil selectedBackgroundImage:nil backgroundColor:nil];
    return button;
}

///自定义按钮:设置图片正常与选中
+ (__kindof UIButton*)createButtonWithFrame:(CGRect)frame normalImage:(NSString *)normalImageStr selectedImage:(NSString *)selectedImageStr{
    UIButton *button = [UIButton createButtonWithFrame:frame normalTitle:nil normalColor:nil selectedTitle:nil selectedColor:nil font:nil normalImage:normalImageStr selectedImage:selectedImageStr normalBackgroundImage:nil selectedBackgroundImage:nil backgroundColor:nil];
    return button;
}

#pragma mark - private method
/**
 创建自定义按钮button 根方法
 
 @param frame 位置·大小
 @param normalTitle 正常标题文字
 @param selectedTitle 选中时标题文字
 @param normalColor 正常标题颜色
 @param selectedColor 选中时标题颜色
 @param normalImage 正常button图片
 @param selectedImage 设置button选中时的图片
 @param normalBackgroundImage 设置button正常的背景图
 @param selectedBackgroundImage 设置button选中时的背景图
 @param backgroudColor 设置button的背景色
 @return button
 */
+ (UIButton *)createButtonWithFrame:(CGRect)frame normalTitle:(NSString *)normalTitle normalColor:(UIColor *)normalColor selectedTitle:(NSString *)selectedTitle selectedColor:(UIColor *)selectedColor font:(UIFont *)font  normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage normalBackgroundImage:(NSString *)normalBackgroundImage selectedBackgroundImage:(NSString *)selectedBackgroundImage backgroundColor:(UIColor *)backgroudColor{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    ///设置标题
    if (normalTitle) {
        [button setTitle:normalTitle forState:UIControlStateNormal];
    }
    
    if (selectedTitle) {
        [button setTitle:selectedTitle forState:UIControlStateSelected];
    }
    
    ///设置button标题字体大小
    if (font) {
        button.titleLabel.font = font;
    }
    
    ///设置标题颜色
    if (normalColor) {
        [button setTitleColor:normalColor forState:UIControlStateNormal];
    }
    if (selectedColor) {
        [button setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    
    ///设置图片
    if (normalImage) {
        if ([NSString stringIsEmpty:normalImage]) {
            normalImage = @"TMPIMAGE";
        }
        [button setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    }
    if (selectedImage) {
        if ([NSString stringIsEmpty:selectedImage]) {
            selectedImage = @"TMPIMAGE";
        }
        [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    }
    
    ///正常的背景
    if (normalBackgroundImage) {
        if ([NSString stringIsEmpty:normalBackgroundImage]) {
            normalBackgroundImage = @"TMPIMAGE";
        }
        [button setBackgroundImage:[UIImage imageNamed:normalBackgroundImage] forState:UIControlStateNormal];
    }
    if (selectedBackgroundImage) {
        if ([NSString stringIsEmpty:selectedBackgroundImage]) {
            selectedBackgroundImage = @"TMPIMAGE";
        }
        [button setBackgroundImage:[UIImage imageNamed:selectedBackgroundImage] forState:UIControlStateSelected];
    }
    
    ///设置背景色
    if (backgroudColor) {
        button.backgroundColor = backgroudColor;
    }
    
    return button;
}

@end
