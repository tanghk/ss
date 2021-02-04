//
//  UIFont+Creation.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (Creation)

/*
 * 常规字体
 */
//苹方--常规体
+ (UIFont *)M_PingFang_RegularOfSize:(CGFloat)fontSize;

//苹方--中黑体
+ (UIFont *)M_PingFang_MediumOfSize:(CGFloat)fontSize;

//苹方--中粗体
+ (UIFont *)M_PingFang_SemiboldOfSize:(CGFloat)fontSize;

@end

NS_ASSUME_NONNULL_END
