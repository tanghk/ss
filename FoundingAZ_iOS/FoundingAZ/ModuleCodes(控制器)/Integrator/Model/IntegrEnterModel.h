//
//  IntegrEnterModel.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, IntegrEnterType){
    
    IntegrEnterType_name,
    IntegrEnterType_scale,
    IntegrEnterType_license,
    IntegrEnterType_technology,
    IntegrEnterType_industry,
    IntegrEnterType_area,
    IntegrEnterType_adress,
    IntegrEnterType_contact
};

@interface IntegrEnterModel : BaseModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeHolderStr;
@property (nonatomic, strong) NSString *conStr;
@property (nonatomic, assign) IntegrEnterType integrEnterType;

+ (NSMutableArray *)getWithIntegrEnterViewData;

@end

NS_ASSUME_NONNULL_END
