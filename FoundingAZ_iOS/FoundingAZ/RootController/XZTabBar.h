//
//  XZTabBar.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XZTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickButton:(UIButton *)tabBtn;

@end

@interface XZTabBar : UITabBar

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id<XZTabBarDelegate>tabDelegate;

@end

NS_ASSUME_NONNULL_END
