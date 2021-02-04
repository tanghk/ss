//
//  UILabel+Creation.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Creation)

/*
 *带Frame-Label:内容、字体大小、字体颜色、对齐方式、背景色
 */
+ (__kindof UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment backgroundColor:(UIColor *)backgroundColor text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
