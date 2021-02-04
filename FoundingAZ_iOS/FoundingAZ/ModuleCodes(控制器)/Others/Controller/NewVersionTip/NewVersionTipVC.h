//
//  NewVersionTipVC.h
//  JobApp
//
//  Created by 创业酵母 on 2021/01/21.
//


#import "BaseViewController.h"

typedef void(^UpdateViewDismiss)(void);
typedef void(^CancelAction)(void);

@interface NewVersionTipVC : BaseViewController

//新版本号
@property (nonatomic, strong) NSString *updateVerSion;
//内容
@property (nonatomic, strong) NSString *updateMsg;
//
@property (nonatomic, strong) NSString *updateUrl;

@property (nonatomic, assign) NSInteger isforup;

@property(nonatomic,strong) NSString *titleKey;

@property (nonatomic, copy) UpdateViewDismiss updateViewDismiss;
@property (nonatomic, copy) CancelAction cancelAction;

@end
