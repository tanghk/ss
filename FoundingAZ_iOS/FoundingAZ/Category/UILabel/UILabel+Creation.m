//
//  UILabel+Creation.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "UILabel+Creation.h"

@implementation UILabel (Creation)

//带Frame-Label:内容、字体大小、字体颜色、对齐方式、背景色
+ (__kindof UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment backgroundColor:(UIColor *)backgroundColor text:(NSString *)text{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    
    if (text) {
        label.text = text;
    }
    
    if (font) {
        label.font = font;
    }
    
    if (color) {
        label.textColor = color;
    }
    
    if (alignment) {
        label.textAlignment = alignment;
    }
    
    if (backgroundColor) {
        label.backgroundColor = backgroundColor;
    }
    
    return label;
}

@end
