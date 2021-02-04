//
//  SetNewPassModel.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "SetNewPassModel.h"

@implementation SetNewPassModel

+ (NSMutableArray *)getWithSetNewPassViewData{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSArray *placeHolderOneArr = @[@"请输入密码"];
    NSArray *iconOneArr = @[@"L_pass_img"];
    NSArray *typeOneArr = @[[NSNumber numberWithInteger:SetNewPassType_new],
    ];
    NSArray *conOneArr = @[@""];
    
    for (int i = 0; i<placeHolderOneArr.count; i++) {
        
        SetNewPassModel *model = [[SetNewPassModel alloc] init];
        model.placeHolderStr = [placeHolderOneArr safeObjectIndex:i];
        model.iconImageStr = [iconOneArr safeObjectIndex:i];
        model.setNewPassType = [[typeOneArr safeObjectIndex:i] integerValue];
        model.conStr = [conOneArr safeObjectIndex:i];
        
        [dataArr addObject:model];
    }
    
    return dataArr;
}

@end
