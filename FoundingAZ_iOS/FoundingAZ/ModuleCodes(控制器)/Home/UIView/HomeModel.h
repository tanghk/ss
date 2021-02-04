//
//  HomeModel.h
//  FoundingAZ
//
//  Created by mark on 2021/1/27.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeModel : BaseModel
@property (nonatomic, strong) NSString *iconImageStr;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *conStr;

@end

NS_ASSUME_NONNULL_END
