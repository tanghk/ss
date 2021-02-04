//
//  MBProgressHUD+XZExtension.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "MBProgressHUD+XZExtension.h"
#import "AppDelegate+Services.h"

@implementation MBProgressHUD (XZExtension)

#pragma mark - private method
+ (void)showCustomIcon:(NSString *)iconName message:(NSString *)message hideTime:(CGFloat)hideTime isWindow:(BOOL)isWindow
{
    if ([NSString stringIsEmpty:message]) {
        return;
    }
    
    MBProgressHUD *hud  =  [self createMBProgressHUDWithMessage:message isWindow:isWindow isToast:YES];
    if (iconName == nil) {
        hud.mode = MBProgressHUDModeText;
    }else{
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:iconName]];
        hud.mode = MBProgressHUDModeCustomView;
    }
    [hud hideAnimated:YES afterDelay:hideTime];
}

+ (instancetype)createMBProgressHUDWithMessage:(NSString *)message isWindow:(BOOL)isWindow isToast:(BOOL)isToast{
    UIView *currentView = isWindow ? (UIView *)[UIApplication sharedApplication].delegate.window : [[AppDelegate shareAppDelegate]  XZ_getCurrentUIVC].view;
    MBProgressHUD * hud = [MBProgressHUD HUDForView:currentView];
    
    if (!hud) {
        hud =[MBProgressHUD showHUDAddedTo:currentView animated:YES];
    }else{
        [hud showAnimated:YES];
    }
    if (isToast) {
        hud.minSize = CGSizeMake(60, 40);
    }else{
      //hud.minSize = CGSizeMake(120, 120);
    }
    hud.label.text=message?message:@"加载中...";
    hud.label.font=[UIFont systemFontOfSize:17];
    hud.label.textColor= [UIColor whiteColor];
    hud.label.numberOfLines = 0;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    hud.bezelView.layer.cornerRadius = 4;
    hud.bezelView.layer.masksToBounds = YES;
    hud.removeFromSuperViewOnHide = YES;
    [hud setContentColor:[UIColor whiteColor]];
    //hud.margin = 15;
    
    return hud;
}


#pragma mark - 只显示文字
+ (void)showMessageInWindow:(NSString *)message{
    [self showCustomIcon:nil message:message hideTime:2.0 isWindow:YES];
}
+ (void)showMessageInWindow:(NSString *)message hideTime:(CGFloat)hidetime{
    [self showCustomIcon:nil message:message hideTime:hidetime isWindow:YES];
}

+ (void)showMessageInView:(NSString *)message{
    [self showCustomIcon:nil message:message hideTime:2.0 isWindow:NO];
}
+ (void)showMessageInView:(NSString *)message hideTime:(CGFloat)hidetime{
    [self showCustomIcon:nil message:message hideTime:hidetime isWindow:NO];
}

#pragma mark - Activity
+ (void)showActivityMessageInWindow
{
    [self showActivityMessage:@"正在加载" isWindow:true timer:0];
}
+ (void)showActivityMessageInView
{
    [self showActivityMessage:@"" isWindow:false timer:0];
}
+ (void)showActivityMessageInWindow:(NSString*)message
{
    [self showActivityMessage:message isWindow:true timer:0];
}
+ (void)showActivityMessageInView:(NSString*)message
{
    [self showActivityMessage:message isWindow:false timer:0];
}
+ (void)showActivityMessageInWindow:(NSString*)message timer:(float)aTimer
{
    [self showActivityMessage:message isWindow:true timer:aTimer];
}
+ (void)showActivityMessageInView:(NSString*)message timer:(float)aTimer
{
    [self showActivityMessage:message isWindow:false timer:aTimer];
}
+ (void)showActivityMessage:(NSString*)message isWindow:(BOOL)isWindow timer:(int)aTimer
{
    MBProgressHUD *hud  = [self createMBProgressHUDWithMessage:message isWindow:isWindow isToast:NO];
    hud.mode = MBProgressHUDModeIndeterminate;
    if (aTimer>0) {
        [hud hideAnimated:YES afterDelay:aTimer];
    }
}

+ (void)XZHideHUD
{
    UIView  *winView =(UIView*)[UIApplication sharedApplication].delegate.window;
    [self hideHUDForView:winView animated:YES];
    [self hideHUDForView:[[AppDelegate shareAppDelegate] XZ_getCurrentUIVC].view animated:YES];
}

@end
