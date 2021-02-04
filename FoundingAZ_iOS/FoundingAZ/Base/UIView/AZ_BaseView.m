//
//  AZ_BaseView.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "AZ_BaseView.h"

@implementation AZ_BaseView


- (instancetype)init {
    self = [super init];
    if (self) {
    
        self.layer.cornerRadius = 5;
        self.backgroundColor =Color_Whitle;
        self.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
        self.alpha = 1;
        UIColor * color =kColorFromHex(@"#2B3754");
//        [self colorWithHexString:@"#2B3754"];
        // 阴影颜色
      self.layer.shadowColor =color.CGColor;
        // 阴影偏移，默认(0, -3)
       self.layer.shadowOffset = CGSizeMake(0,0);
        // 阴影透明度，默认0
       self.layer.shadowOpacity = 0.06;
        // 阴影半径，默认3
        self.layer.shadowRadius = 5;
    }
    return self;
}
/// 添加四边阴影效果
- (void)addShadowToView:(UIView *)theView withColor:(UIColor *)theColor {
   
}


-(UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


@end
