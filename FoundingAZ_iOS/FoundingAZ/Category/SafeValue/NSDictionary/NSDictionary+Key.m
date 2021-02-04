//
//  NSDictionary+Key.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "NSDictionary+Key.h"
#import "NSObject+Conversion.h"

@implementation NSDictionary (Key)

/**
 *  取得的值转换string
 */
- (NSString *)stringForKey:(id)key
{
    return [[self objectForKey:key] asNSString];
}

/**
 *  取得的值转换float
 */
- (CGFloat)floatForKey:(id)key
{
    return [[self objectForKey:key] asFloat];
}
/**
 *  取得的值转换integer
 */
- (NSInteger)integerForKey:(id)key
{
    return [[self objectForKey:key] asInteger];
}
/**
 *  取得的值转换int
 */
- (int)intForKey:(id)key
{
    return [[self objectForKey:key] asInt];
}
/**
 *  取得的值转换BOOL
 */
- (BOOL)boolForKey:(id)key
{
    return [[self objectForKey:key] asBool];
}

/**
 *  取得的值转换double
 */
- (double)doubleForKey:(id)key
{
    return [[self objectForKey:key] asDouble];
}

/**
 *  取得的值转换array
 */
- (NSArray *)arrayForKey:(id)key
{
    return [[self objectForKey:key] asNSArray];
}

/**
 *  取得的值转换NSDictionary
 */
- (NSDictionary *)dicForKey:(id)key
{
    return [[self objectForKey:key] asNSDictionary];
}

/**
 *  取得的值转换NSNumber
 */
- (NSNumber *)numberForKey:(id)key
{
    return [[self objectForKey:key] asNSNumber];
}

- (id)objectForKey:(NSString *)aKey
{
    id val = [self valueForKey:aKey];
    return [val isEqual:[NSNull null]] ? nil : val;
    return val;
}

@end

@implementation NSMutableDictionary (SetKey)

//- (void)setObject:(id)anObject forKey:(NSString *)aKey
//{
//    if (aKey.length) {
//        [self setValue:anObject forKey:aKey];
//    }
//}

@end

@implementation NSNull (Safe)

- (NSInteger)length
{
    return 0;
}

@end
