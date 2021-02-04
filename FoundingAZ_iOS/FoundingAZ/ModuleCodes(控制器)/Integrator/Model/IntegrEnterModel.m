//
//  IntegrEnterModel.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "IntegrEnterModel.h"

@implementation IntegrEnterModel

+ (NSMutableArray *)getWithIntegrEnterViewData{
    
    NSMutableArray *dataArr = [NSMutableArray array];
    
    NSArray *titleArr = @[@"企业名称",@"企业规模",@"营业执照",@"擅长工艺",@"所属行业",@"所属地区",@"详细地址",@"联系人"];
    NSArray *placeHolderArr = @[@"请输入与营业执照一致的全称",@"请选择",@"",@"请选择",@"请选择",@"请选择",@"请填写街道门牌地址",@"请填写联系人"];
    NSArray *conArr = @[@"",@"",@"",@"",@"",@"",@"",@""];
    NSArray *typeArr = @[[NSNumber numberWithInteger:IntegrEnterType_name],
                         [NSNumber numberWithInteger:IntegrEnterType_scale],
                         [NSNumber numberWithInteger:IntegrEnterType_license],
                         [NSNumber numberWithInteger:IntegrEnterType_technology],
                         [NSNumber numberWithInteger:IntegrEnterType_industry],
                         [NSNumber numberWithInteger:IntegrEnterType_area],
                         [NSNumber numberWithInteger:IntegrEnterType_adress],
                         [NSNumber numberWithInteger:IntegrEnterType_contact]
    ];
    
    for (int i = 0; i<titleArr.count; i++) {
        
        IntegrEnterModel *model = [[IntegrEnterModel alloc] init];
        model.title = [titleArr safeObjectIndex:i];
        model.placeHolderStr = [placeHolderArr safeObjectIndex:i];
        model.conStr = [conArr safeObjectIndex:i];
        model.integrEnterType = [[typeArr safeObjectIndex:i] integerValue];
        
        [dataArr addObject:model];
    }
    
    return dataArr;
}

@end
