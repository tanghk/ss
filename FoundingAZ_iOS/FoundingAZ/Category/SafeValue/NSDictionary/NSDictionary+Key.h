//
//  NSDictionary+Key.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Key)

/**
 *  取得的值转换string
 */
- (NSString *)stringForKey:(id)key;
/**
 *  取得的值转换float
 */
- (CGFloat)floatForKey:(id)key;
/**
 *  取得的值转换integer
 */
- (NSInteger)integerForKey:(id)key;
/**
 *  取得的值转换int
 */
- (int)intForKey:(id)key;
/**
 *  取得的值转换BOOL
 */
- (BOOL)boolForKey:(id)key;
/**
 *  取得的值转换double
 */
- (double)doubleForKey:(id)key;
/**
 *  取得的值转换array
 */
- (NSArray *)arrayForKey:(id)key;

/**
 *  取得的值转换NSDictionary
 */
- (NSDictionary *)dicForKey:(id)key;
/**
 *  取得的值转换NSNumber
 */
- (NSNumber *)numberForKey:(id)key;

@end

@interface NSMutableDictionary (SetKey)

@end

@interface NSNull (Safe)

- (NSInteger)length;

@end

NS_ASSUME_NONNULL_END
