//
//  NSString+Creation.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "NSString+Creation.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Creation)

+ (BOOL)stringIsEmpty:(NSString *)str{
    
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    
    if (str == nil) {
        return YES;
    }
    
    if ([str isKindOfClass:[NSString class]]) {
        NSString *selfstr = (NSString *)str;
        
        if ([selfstr isEqual:nil]) {
            return YES;
        }
        
        if([selfstr isEqualToString:@""]){
            return YES;
        }
        
    }
    
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"null"]) {
        return YES;
    }
    
    
    //  如果字符串里全是空格,  则算空
    NSMutableString *temp = [NSMutableString stringWithString:str];
    [temp replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, str.length)];
    if ([temp isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

#pragma mark 手机号是否合法
+ (BOOL)stringIsPhoneVerify:(NSString *)str{
    
    if ([self stringIsEmpty:str]) {
        return NO;
    }
    
    if (str.length != 11) {
        return NO;
    }
    
    if (str.length > 1) {
        NSString *firstrStr = [str substringToIndex:1];
        if ([firstrStr isEqualToString:@"1"]) {
            return YES;
        }else{
            return NO;
        }
    }
    
    return YES;
}

+ (NSString *)M_replacePhoneMid4String:(NSString *)objectString{
    
    NSString *outString = objectString;
    if ([objectString length] >=8) {
        NSString *fisrtString = [objectString substringWithRange:NSMakeRange(0, 3)];
        NSString *lastString  = [objectString substringWithRange:NSMakeRange(7, objectString.length - 7)];
        
        outString = [NSString stringWithFormat:@"%@****%@",fisrtString,lastString];
    }
    return outString;
}

/** MD5处理字符串 */
- (NSString *)M_getMD5Encrypt{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", result[i]];
    
    return  output;
}

+ (CGFloat)widthOfStringWithString:(NSString *)str Font:(UIFont *)font height:(CGFloat)height{
    
    NSDictionary *fontDict = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);
    
    CGRect rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
    return ceilf(rect.size.width);
}

+ (CGFloat)heightOfStringWithString:(NSString *)str Font:(UIFont *)font width:(CGFloat)width{
    
    NSDictionary *fontDict = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    
    CGRect rect = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
    return ceilf(rect.size.height);
}

@end
