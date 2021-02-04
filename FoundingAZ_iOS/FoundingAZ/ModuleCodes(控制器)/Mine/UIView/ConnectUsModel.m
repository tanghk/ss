//
//  ConnectUsModel.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "ConnectUsModel.h"

@implementation ConnectUsModel

+ (NSMutableArray *)getWithConnectUsData{
    NSMutableArray *dataArr = [NSMutableArray array];
   
    
    NSArray *titleOneArr = @[@"微信咨询",@"合作邮箱",@"合作电话"];
    NSArray *iconOneArr = @[@"ConnectUs_Wechat",
                            @"ConnectUs_Wechat",
                            @"ConnectUs_Wechat",
                           ];
    NSArray *connectArr = @[@"jiaomu007",@"mkt@foundingaz.com",@"010-84161910"];

    NSArray *typeOneArr = @[[NSNumber numberWithInteger:ConnectUsType_WeChat],
                            [NSNumber numberWithInteger:ConnectUsType_Email],
                            [NSNumber numberWithInteger:ConnectUsType_Phone]
                          
    ];
    
    for (int i = 0; i<titleOneArr.count; i++) {
        
        ConnectUsModel *model = [[ConnectUsModel alloc] init];
        model.title = [titleOneArr safeObjectIndex:i];
        model.iconImageStr = [iconOneArr safeObjectIndex:i];
        model.tel = [connectArr safeObjectIndex:i];
        model.connectUsType = [[typeOneArr safeObjectIndex:i] integerValue];
        [dataArr addObject:model];
    }
   
    
    return  dataArr;
}


+ (NSMutableArray *)getWithAddressData{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSMutableArray *oneArr = [NSMutableArray array];
   
    
    NSArray *titleOneArr = @[@"北京总公司",@"上海分公司",@"杭州分公司"];
    NSArray *addressArr = @[@"朝阳区望京东园4区绿地中心D座16层1602",@"上海市徐汇区天钥桥路580号星游城6楼方糖小镇6楼",@"杭州市西湖区中节能西溪首座A1-1 620"];
    NSArray *telArr = @[@"010-84161910",@"18516722881",@"18866111777"];

    NSArray *typeOneArr = @[[NSNumber numberWithInteger:AddressType_Beijing],
                            [NSNumber numberWithInteger:AddressType_Shanghai],
                            [NSNumber numberWithInteger:AddressType_Hangzhou]
                          
    ];
    
  
    
    for (int i = 0; i<titleOneArr.count; i++) {
        
        ConnectUsModel *model = [[ConnectUsModel alloc] init];
        model.title = [titleOneArr safeObjectIndex:i];
        model.address = [addressArr safeObjectIndex:i];
        model.tel = [telArr safeObjectIndex:i];
        model.addressType = [[typeOneArr safeObjectIndex:i] integerValue];

        [oneArr addObject:model];
    }
    [dataArr addObject:oneArr];
    
   
    
    return dataArr;
    
    
}
@end
