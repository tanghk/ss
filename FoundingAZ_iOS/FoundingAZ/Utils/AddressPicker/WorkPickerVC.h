//
//  WorkPickerVC.h
//  TuoTuoWeiBao
//
//  Created by 创业酵母 on 2020/6/23.
//  Copyright © 2020 tuotuojia. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkPickerVC : BaseViewController

@property (nonatomic, assign) NSInteger numberOfSection;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, assign) NSArray *dataArr;
@property (nonatomic, assign) NSInteger fromType;//1地址  2：普通
@property (nonatomic, assign) BOOL isAllState;//是否增加全部

@property (nonatomic, copy) void(^WorkPickerSelectBlock)(NSString *str);

@end

NS_ASSUME_NONNULL_END
