//
//  MineModel.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "MineModel.h"

@implementation MineModel
+ (NSMutableArray *)getWithMineData{
    NSMutableArray *dataArr = [NSMutableArray array];
   
    
    NSArray *titleOneArr = @[@"课程",@"优惠券",@"收藏"];
    NSArray *iconOneArr = @[@"Mine_Course",
                            @"Mine_Coupons",
                            @"Mine_Collection",
                           ];
    NSArray *typeOneArr = @[[NSNumber numberWithInteger:MineType_Course],
                            [NSNumber numberWithInteger:MineType_Coupons],
                            [NSNumber numberWithInteger:MineType_Collection]
                          
    ];
    
    for (int i = 0; i<titleOneArr.count; i++) {
        
        MineModel *model = [[MineModel alloc] init];
        model.title = [titleOneArr safeObjectIndex:i];
        model.iconImageStr = [iconOneArr safeObjectIndex:i];
        model.mineType = [[typeOneArr safeObjectIndex:i] integerValue];
        [dataArr addObject:model];
    }
   
    
    return  dataArr;
}
+ (NSMutableArray *)getWithMineViewData{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    NSMutableArray *oneArr = [NSMutableArray array];
    NSMutableArray *twoArr = [NSMutableArray array];
    
    NSArray *titleOneArr = @[@"我的订单",@"企业大学",@"个人信息",@"设置"];
    NSArray *iconOneArr = @[@"Mine_Order",
                            @"Mine_University",
                            @"Mine_Information",
                            @"Mine_Setting"];
    NSArray *typeOneArr = @[[NSNumber numberWithInteger:MineViewType_order],
                            [NSNumber numberWithInteger:MineViewType_university],
                            [NSNumber numberWithInteger:MineViewType_information],
                            [NSNumber numberWithInteger:MineViewType_setting]
    ];
    NSArray *conOneArr = @[@"",@"助力企业快速成长",@"",@""];
    
    for (int i = 0; i<titleOneArr.count; i++) {
        
        MineModel *model = [[MineModel alloc] init];
        model.title = [titleOneArr safeObjectIndex:i];
        model.iconImageStr = [iconOneArr safeObjectIndex:i];
        model.mineViewType = [[typeOneArr safeObjectIndex:i] integerValue];
        model.conStr = [conOneArr safeObjectIndex:i];
        
        [oneArr addObject:model];
    }
    [dataArr addObject:oneArr];
    
    
    NSArray *titleTwoArr = @[@"联系我们",@"关于我们"];
    NSArray *iconTwoArr = @[@"Mine_Contact",@"Mine_About"];
    NSArray *typeTwoArr = @[[NSNumber numberWithInteger:MineViewType_contact],
                            [NSNumber numberWithInteger:MineViewType_about]
                           
    ];
    NSString *str = [NSString stringWithFormat:@"%@.%@ %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"], [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"], Version_Flag];
    NSArray *conTwoArr = @[str,@"400-096-8005",@""];
    
    for (int i = 0; i<titleTwoArr.count; i++) {
        
        MineModel *model = [[MineModel alloc] init];
        model.title = [titleTwoArr safeObjectIndex:i];
        model.iconImageStr = [iconTwoArr safeObjectIndex:i];
        model.mineViewType = [[typeTwoArr safeObjectIndex:i] integerValue];
        model.conStr = [conTwoArr safeObjectIndex:i];
        
        [twoArr addObject:model];
    }
    [dataArr addObject:twoArr];
    
    return dataArr;
}

@end
