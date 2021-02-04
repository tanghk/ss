//
//  MineModel.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MineViewType){
    
    MineViewType_order,
    MineViewType_university,
    MineViewType_information,
    MineViewType_setting,
    MineViewType_contact,
    MineViewType_about,
    
};
typedef NS_ENUM(NSInteger, MineType){
    
    MineType_Course,
    MineType_Coupons,
    MineType_Collection,

};

@interface MineModel : BaseModel

@property (nonatomic, strong) NSString *iconImageStr;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *conStr;
@property (nonatomic, assign) MineViewType mineViewType;
@property (nonatomic, assign) MineType mineType;
@property (nonatomic, strong) NSString *image;
+ (NSMutableArray *)getWithMineViewData;
+ (NSMutableArray *)getWithMineData;
@end

NS_ASSUME_NONNULL_END
