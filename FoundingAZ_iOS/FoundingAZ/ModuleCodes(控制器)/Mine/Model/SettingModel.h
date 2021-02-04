//
//  SettingModel.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SettingViewType){
    
    SettingViewType_modify
};

@interface SettingModel : BaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) SettingViewType settingViewType;

+ (NSMutableArray *)getWithSettingViewData;

@end

NS_ASSUME_NONNULL_END
