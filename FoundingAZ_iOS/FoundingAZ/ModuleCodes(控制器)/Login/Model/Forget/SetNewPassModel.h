//
//  SetNewPassModel.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetNewPassModel : BaseModel

typedef NS_ENUM(NSInteger, SetNewPassType){
    
    SetNewPassType_new
};

@property (nonatomic, strong) NSString *iconImageStr;
@property (nonatomic, strong) NSString *placeHolderStr;
@property (nonatomic, strong) NSString *conStr;
@property (nonatomic, assign) SetNewPassType setNewPassType;

+ (NSMutableArray *)getWithSetNewPassViewData;

@end

NS_ASSUME_NONNULL_END
