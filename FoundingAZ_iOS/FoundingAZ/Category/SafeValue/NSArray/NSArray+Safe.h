//
//  NSArray+Safe.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (Safe)

- (id)safeObjectIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
