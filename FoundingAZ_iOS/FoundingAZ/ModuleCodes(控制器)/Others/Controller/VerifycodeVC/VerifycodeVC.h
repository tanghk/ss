//
//  VerifycodeVC.h
//  FoundingAZ
//
//  Created by mark on 2021/2/2.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^VerifycodeDismiss)(NSDictionary *dic);
typedef void(^CancelAction)(void);

@interface VerifycodeVC : BaseViewController

//新版本号
@property (nonatomic, strong) NSString *updateVerSion;
//内容
@property (nonatomic, strong) NSString *updateMsg;
//
@property (nonatomic, strong) NSString *updateUrl;

@property (nonatomic, assign) NSInteger isforup;

@property(nonatomic,strong) NSString *titleKey;

@property (nonatomic, copy) VerifycodeDismiss verifycodeDismiss;

@end

NS_ASSUME_NONNULL_END
