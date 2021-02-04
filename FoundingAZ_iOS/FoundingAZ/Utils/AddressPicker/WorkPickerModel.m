//
//  WorkPickerModel.m
//  TuoTuoWeiBao
//
//  Created by 创业酵母 on 2020/6/23.
//  Copyright © 2020 tuotuojia. All rights reserved.
//

#import "WorkPickerModel.h"

@implementation WorkPickerModel

- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if (dictionary) {
            
            self.name = dictionary[@"value"];
        }
    }
    return self;
}

@end


@implementation WorkPickerSecondModel

- (NSMutableArray *)list {
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if (dictionary) {
            
            self.name = dictionary[@"value"];
        }
    }
    return self;
}

@end

@implementation WorkPickerThirdModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if (dictionary) {
            
            self.name = dictionary[@"value"];
        }
    }
    return self;
}

@end
