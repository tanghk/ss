//
//  UIImageView+Creation.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Creation)

/**
 创建ImageView-UIImage
 */
+ (__kindof UIImageView*)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image;

/**
 创建ImageView-NSString
 */
+ (__kindof UIImageView*)createImageViewWithFrame:(CGRect)frame imageWithString:(NSString *)imageStr;

@end

NS_ASSUME_NONNULL_END
