//
//  YYLabel+creation.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/23.
//

#import "YYLabel+creation.h"

@implementation YYLabel (creation)

///带Frame-Label:内容、字体大小、字体颜色、对齐方式、背景色
+ (__kindof YYLabel*)createLabelWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment backgroundColor:(UIColor *)backgroundColor text:(NSString *)text{
    YYLabel *label = [[YYLabel alloc]initWithFrame:frame];
    
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
