//
//  UIFont+Creation.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "UIFont+Creation.h"

@implementation UIFont (Creation)

#pragma mark 苹方--常规体
+ (UIFont *)M_PingFang_RegularOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

#pragma mark 苹方--中黑体
+ (UIFont *)M_PingFang_MediumOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
}

#pragma mark 苹方--中粗体
+ (UIFont *)M_PingFang_SemiboldOfSize:(CGFloat)fontSize{
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}

@end
