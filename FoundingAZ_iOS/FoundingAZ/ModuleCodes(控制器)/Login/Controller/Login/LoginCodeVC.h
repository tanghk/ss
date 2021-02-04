//
//  LoginCodeVC.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "HandleBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginCodeVC : HandleBarController

@property (nonatomic, assign) NSInteger fromeType;//1:来自设置页面修改密码
@property (nonatomic, strong) NSString *phoneStr;//输入的手机号码
@property (nonatomic, strong) NSString *codeStr;//输入的短信验证码
@property (nonatomic, assign) NSInteger inteIndex;
@end

NS_ASSUME_NONNULL_END
