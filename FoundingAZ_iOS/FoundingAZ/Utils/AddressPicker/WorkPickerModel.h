//
//  WorkPickerModel.h
//  TuoTuoWeiBao
//
//  Created by 创业酵母 on 2020/6/23.
//  Copyright © 2020 tuotuojia. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WorkPickerSecondModel,WorkPickerThirdModel;

NS_ASSUME_NONNULL_BEGIN

@interface WorkPickerModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSMutableArray<WorkPickerSecondModel *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN

@interface WorkPickerSecondModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSMutableArray<WorkPickerThirdModel *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END



NS_ASSUME_NONNULL_BEGIN

@interface WorkPickerThirdModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *index;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
