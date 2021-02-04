//
//  AuthTools.m
//  JobApp
//
//  Created by 创业酵母 on 2021/01/21.
//


#import "AuthTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation AuthTools

- (id)init
{
    if (self = [super init]) {
        //格式化时间
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        dateFormatter.dateFormat = @"yyyyMMddHHmmss";
        NSDate *nowDate = [NSDate date];
        //        NSString *currentDate = [dateFormatter stringFromDate:nowDate];
        
        NSTimeInterval testDate = [nowDate timeIntervalSince1970];
        NSString *currentDate = [NSString stringWithFormat:@"%ld",(long)testDate];
        
        //token+timestamp
        NSString *tokenTimestamp = [NSString stringWithFormat:@"jjoobb2015.cn%@",currentDate];
        
        //签名串
        NSString *signature = [self getSha1String:tokenTimestamp];
        self.signature = signature;
        
        //时间戳
        NSString *timestamp = currentDate;
        self.timestamp = timestamp;
    }
    return self;
}

//sha1加密方式
- (NSString *)getSha1String:(NSString *)srcString
{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
#pragma mark - 金小白修改
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

+ (BOOL)resultWithResponseObject:(id)responseObject
{
    if ([responseObject[@"msgId"] isEqualToString:@"1"]) {//数据返回有值
        return YES;
    }
    else {//数据返回错误
        //        [SVProgressHUD showInfoWithStatus:responseObject[@"msgBox"]];
        return NO;
    }
}

@end
