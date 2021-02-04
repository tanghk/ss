//
//  UIColor+Creation.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "UIColor+Creation.h"

@implementation UIColor (Creation)

+ (UIColor *)randomColor
{
    int red = arc4random_uniform(256);
    int green = arc4random_uniform(256);
    int blue = arc4random_uniform(256);
    return [UIColor colorWithRed:red / 255.0f green:green / 255.0f blue:blue / 255.0f alpha:100 / 100.0f];
}

@end
