//
//  NSObject+Conversion.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "NSObject+Conversion.h"

@implementation NSObject (Conversion)

- (NSInteger)asInteger
{
    return [[self asNSNumber] integerValue];
}

- (int)asInt
{
    return [[self asNSNumber] intValue];
}

- (float)asFloat
{
    return [[self asNSNumber] floatValue];
}

- (BOOL)asBool
{
    return [[self asNSNumber] boolValue];
}

- (BOOL)asDouble
{
    return [[self asNSNumber] doubleValue];
}

- (NSNumber *)asNSNumber
{
    if ( [self isKindOfClass:[NSNumber class]] )
    {
        return (NSNumber *)self;
    }
    else if ( [self isKindOfClass:[NSString class]] )
    {
        return [NSNumber numberWithInteger:[(NSString *)self integerValue]];
    }
    else if ( [self isKindOfClass:[NSDate class]] )
    {
        return [NSNumber numberWithDouble:[(NSDate *)self timeIntervalSince1970]];
    }
    else if ( [self isKindOfClass:[NSNull class]] )
    {
        return [NSNumber numberWithInteger:0];
    }
    
    return nil;
}

- (NSString *)asNSString
{
    if ([self isKindOfClass:[NSNull class]] )
        return @"";
    
    if ([self isKindOfClass:[NSString class]] )
    {
        if ([self isEqual:@"(null)"]) {
            return @"";
        }
        return (NSString *)self;
    }
    else if ( [self isKindOfClass:[NSData class]] )
    {
        NSData * data = (NSData *)self;
        
        NSString * text = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
        if ( nil == text )
        {
            text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if ( nil == text )
            {
                text = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            }
        }
        return text;
    }else if ([self isKindOfClass:[NSNumber class]]){
        return [(NSNumber *)self stringValue];
    }else if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]]){
        return @"";
    }else{
        return [NSString stringWithFormat:@"%@", self];
    }
}

- (NSDate *)asNSDate
{
    if ( [self isKindOfClass:[NSDate class]] )
    {
        return (NSDate *)self;
    }
    else if ( [self isKindOfClass:[NSString class]] )
    {
        NSDate * date = nil;
        
        if ( nil == date )
        {
            NSString * format = @"yyyy-MM-dd HH:mm:ss z";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if ( nil == date )
        {
            NSString * format = @"yyyy/MM/dd HH:mm:ss z";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if ( nil == date )
        {
            NSString * format = @"yyyy-MM-dd HH:mm:ss";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        if ( nil == date )
        {
            NSString * format = @"yyyy/MM/dd HH:mm:ss";
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:format];
            [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
            
            date = [formatter dateFromString:(NSString *)self];
        }
        
        return date;
        
        //        NSTimeZone * local = [NSTimeZone localTimeZone];
        //        return [NSDate dateWithTimeInterval:(3600 + [local secondsFromGMT])
        //                                  sinceDate:[dateFormatter dateFromString:text]];
    }
    else
    {
        return [NSDate dateWithTimeIntervalSince1970:[self asNSNumber].doubleValue];
    }
    
    return nil;
}

- (NSData *)asNSData
{
    if ( [self isKindOfClass:[NSString class]] )
    {
        return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    }else if ( [self isKindOfClass:[NSData class]]){
        return (NSData *)self;
    }
    return nil;
}

- (NSArray *)asNSArray
{
    if ( [self isKindOfClass:[NSArray class]] )
    {
        return (NSArray *)self;
    }else if ([self isEqual:[NSNull null]]){
        return [NSArray array];
    }else if ([self isKindOfClass:[NSString class]]){
        return [NSArray array];
    }else{
        
        return [NSArray array];
    }
}

- (NSArray *)asNSArrayWithClass:(Class)clazz
{
    if ( [self isKindOfClass:[NSArray class]] )
    {
        NSMutableArray * results = [NSMutableArray array];
        
        for ( NSObject * elem in (NSArray *)self )
        {
            if ( [elem isKindOfClass:[NSDictionary class]] )
            {
                return nil;
            }
        }
        
        return results;
    }
    
    return nil;
}

- (NSMutableArray *)asNSMutableArray
{
    if ( [self isKindOfClass:[NSMutableArray class]] )
    {
        return (NSMutableArray *)self;
    }
    
    return nil;
}

- (NSMutableArray *)asNSMutableArrayWithClass:(Class)clazz
{
    NSArray * array = [self asNSArrayWithClass:clazz];
    if ( nil == array )
        return nil;
    
    return [NSMutableArray arrayWithArray:array];
}

- (NSDictionary *)asNSDictionary
{
    if ( [self isKindOfClass:[NSDictionary class]] )
    {
        return (NSDictionary *)self;
    }
    
    return [NSDictionary dictionary];
}

- (NSMutableDictionary *)asNSMutableDictionary
{
    if ( [self isKindOfClass:[NSMutableDictionary class]] )
    {
        return (NSMutableDictionary *)self;
    }
    
    NSDictionary * dict = [self asNSDictionary];
    if ( nil == dict )
        return nil;
    
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

@end
