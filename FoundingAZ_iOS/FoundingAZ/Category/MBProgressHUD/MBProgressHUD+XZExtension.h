//
//  MBProgressHUD+XZExtension.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <MBProgressHUD/MBProgressHUD.h>

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (XZExtension)

#pragma mark - 只显示文字
+ (void)showMessageInWindow:(NSString *)message;
+ (void)showMessageInWindow:(NSString *)message hideTime:(CGFloat)hidetime;
+ (void)showMessageInView:(NSString *)message;
+ (void)showMessageInView:(NSString *)message hideTime:(CGFloat)hidetime;


#pragma mark - Activity
+ (void)showActivityMessageInWindow;
+ (void)showActivityMessageInView;
+ (void)showActivityMessageInWindow:(NSString*)message;
+ (void)showActivityMessageInView:(NSString*)message;
+ (void)showActivityMessageInWindow:(NSString*)message timer:(float)aTimer;
+ (void)showActivityMessageInView:(NSString*)message timer:(float)aTimer;


+ (void)XZHideHUD;

@end

NS_ASSUME_NONNULL_END
