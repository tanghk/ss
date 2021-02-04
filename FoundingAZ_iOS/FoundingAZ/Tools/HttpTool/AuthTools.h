//
//  AuthTools.h
//  JobApp
//
//  Created by 创业酵母 on 2021/01/21.
//


#import <Foundation/Foundation.h>

@interface AuthTools : NSObject

/**
 *  签名串
 */
@property (nonatomic, copy) NSString *signature;
/**
 *  时间戳
 */
@property (nonatomic, copy) NSString *timestamp;

+ (BOOL)resultWithResponseObject:(id)responseObject;

@end
