//
//  NSArray+Safe.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)

- (id)safeObjectIndex:(NSUInteger)index
{
    if (self.count <= index) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (id)objectForKey:(id)key{
#ifdef DEBUG
    NSAssert(NO, @"NSArray should not call objectForKey, you should check your code!");
    return nil;
#else
    return nil;
#endif
}

@end
