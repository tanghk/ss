//
//  VerfiyPhoneModel.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "VerfiyPhoneModel.h"

@implementation VerfiyPhoneModel

+ (NSMutableArray *)getWithVerfiyPhoneViewData{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSArray *placeHolderOneArr = @[@"请输入手机号码",@"请输入验证码"];
    NSArray *iconOneArr = @[@"L_phone_img",@"L_code_img"];
    NSArray *typeOneArr = @[[NSNumber numberWithInteger:VerfiyPhoneType_phone],
                            [NSNumber numberWithInteger:VerfiyPhoneType_code]
    ];
    NSArray *conOneArr = @[@"",@""];
    
    for (int i = 0; i<placeHolderOneArr.count; i++) {
        
        VerfiyPhoneModel *model = [[VerfiyPhoneModel alloc] init];
        model.placeHolderStr = [placeHolderOneArr safeObjectIndex:i];
        model.iconImageStr = [iconOneArr safeObjectIndex:i];
        model.VerfiyPhoneType = [[typeOneArr safeObjectIndex:i] integerValue];
        model.conStr = [conOneArr safeObjectIndex:i];
        
        [dataArr addObject:model];
    }
    
    return dataArr;
}

@end
