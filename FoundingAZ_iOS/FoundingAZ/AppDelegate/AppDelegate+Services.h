//
//  AppDelegate+Services.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Services)

//单例
+ (AppDelegate *)shareAppDelegate;

//初始化窗口
- (void)XZ_initWithWindow;

//初始化主界面
- (void)XZ_initWithMainUI;

//初始化tabVC
- (void)XZ_initWithMainVC;

//初始化第三方键盘
- (void)XZ_initWithKeyboardService;

//初始化第三方服务
- (void)XZ_initWithThridService;

-(UIViewController *)XZ_getCurrentVC;

-(UIViewController *)XZ_getCurrentUIVC;

@end

NS_ASSUME_NONNULL_END
