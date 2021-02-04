//
//  LoginPhoneVC.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "HandleBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginPhoneVC : HandleBarController

@property (nonatomic, assign) NSInteger fromeType;//1:来自设置页面修改密码
@property (nonatomic, strong) NSString *phoneStr;

@end

NS_ASSUME_NONNULL_END
