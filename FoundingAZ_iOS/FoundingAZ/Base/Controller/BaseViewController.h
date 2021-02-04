//
//  BaseViewController.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

//初始化数据
- (void)initWithData;

//配置导航栏
- (void)initWithNaviUI;

//配置UI
- (void)initWithMainUI;

//配置dismiss
- (void)dismiss;
@end

NS_ASSUME_NONNULL_END
