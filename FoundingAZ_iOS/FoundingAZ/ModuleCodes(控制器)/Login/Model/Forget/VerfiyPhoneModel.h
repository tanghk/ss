//
//  VerfiyPhoneModel.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, VerfiyPhoneType){
    
    VerfiyPhoneType_phone,
    VerfiyPhoneType_code
};

@interface VerfiyPhoneModel : BaseModel

@property (nonatomic, strong) NSString *iconImageStr;
@property (nonatomic, strong) NSString *placeHolderStr;
@property (nonatomic, strong) NSString *conStr;
@property (nonatomic, assign) VerfiyPhoneType VerfiyPhoneType;

+ (NSMutableArray *)getWithVerfiyPhoneViewData;

@end

NS_ASSUME_NONNULL_END
