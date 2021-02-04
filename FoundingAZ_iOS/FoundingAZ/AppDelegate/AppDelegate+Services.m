//
//  AppDelegate+Services.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "AppDelegate+Services.h"
#import "XZTabBarController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <RongIMKit/RongIMKit.h>
@implementation AppDelegate (Services)

//单例
+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

#pragma mark 初始化窗口
- (void)XZ_initWithWindow{
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

#pragma mark 初始化主界面
- (void)XZ_initWithMainUI{
    
    [self XZ_initWithMainVC];
}

#pragma mark 初始化tabVC
- (void)XZ_initWithMainVC{
    
    XZTabBarController *rootVC = [[XZTabBarController alloc] init];
    self.window.rootViewController = rootVC;
}

#pragma mark 初始化第三方键盘
- (void)XZ_initWithKeyboardService{
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES;
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    keyboardManager.enableAutoToolbar = YES;
    keyboardManager.shouldShowToolbarPlaceholder = YES;
    keyboardManager.toolbarDoneBarButtonItemText = @"完成";
}

#pragma mark 初始化第三方服务
- (void)XZ_initWithThridService{
   // [[RCIM sharedRCIM] initWithAppKey:@"获取到的 AppKey"];
    
}
- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    [[RCIM sharedRCIM] initWithAppKey:@"获取到的 AppKey"];
}
#pragma mark *************
-(UIViewController *)XZ_getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(UIViewController *)XZ_getCurrentUIVC{
    
    UIViewController  *superVC = [self XZ_getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
        if ([superVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)superVC).viewControllers.lastObject;
        }
    return superVC;
}

@end
