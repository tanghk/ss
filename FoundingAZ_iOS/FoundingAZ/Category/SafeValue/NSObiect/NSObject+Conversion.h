//
//  NSObject+Conversion.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Conversion)

- (NSInteger)asInteger;
- (int)asInt;
- (float)asFloat;
- (BOOL)asBool;
- (BOOL)asDouble;

- (NSNumber *)asNSNumber;
- (NSString *)asNSString;
- (NSDate *)asNSDate;
- (NSData *)asNSData;    // TODO
- (NSArray *)asNSArray;
- (NSArray *)asNSArrayWithClass:(Class)clazz;
- (NSMutableArray *)asNSMutableArray;
- (NSMutableArray *)asNSMutableArrayWithClass:(Class)clazz;
- (NSDictionary *)asNSDictionary;
- (NSMutableDictionary *)asNSMutableDictionary;

@end

NS_ASSUME_NONNULL_END
