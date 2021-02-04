//
//  SettingModel.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "SettingModel.h"

@implementation SettingModel

+ (NSMutableArray *)getWithSettingViewData{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSArray *titleArr = @[@"修改密码"];
    NSArray *typeArr = @[[NSNumber numberWithInteger:SettingViewType_modify]
    ];
    
    for (int i = 0; i<titleArr.count; i++) {
        
        SettingModel *model = [[SettingModel alloc] init];
        model.title = [titleArr safeObjectIndex:i];
        model.settingViewType = [[typeArr safeObjectIndex:i] integerValue];
        
        [dataArr addObject:model];
    }
    
    return dataArr;
}

@end
