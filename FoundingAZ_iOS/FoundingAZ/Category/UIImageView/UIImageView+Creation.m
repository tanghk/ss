//
//  UIImageView+Creation.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "UIImageView+Creation.h"

@implementation UIImageView (Creation)

///创建ImageView-UIImage
+ (__kindof UIImageView*)createImageViewWithFrame:(CGRect)frame image:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (image) {
        imageView.image = image;
    }
    return imageView;
}

///创建ImageView-NSString
+ (__kindof UIImageView*)createImageViewWithFrame:(CGRect)frame imageWithString:(NSString *)imageStr {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if (imageStr) {
        if ([NSString stringIsEmpty:imageStr]) {
            imageStr = @"TMPIMAGE";
        }
        imageView.image = [UIImage imageNamed:imageStr];
    }
    return imageView;
}

@end
