//
//  NSString+Creation.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Creation)

//是否为空字符串
+ (BOOL)stringIsEmpty:(NSString *)str;

//手机号是否合法
+ (BOOL)stringIsPhoneVerify:(NSString *)str;

+ (NSString *)M_replacePhoneMid4String:(NSString *)objectString;

//MD5处理字符串
- (NSString *)M_getMD5Encrypt;

+ (CGFloat)widthOfStringWithString:(NSString *)str Font:(UIFont *)font height:(CGFloat)height;

+ (CGFloat)heightOfStringWithString:(NSString *)str Font:(UIFont *)font width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
