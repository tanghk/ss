//
//  HandleBarController.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^shareBlock)(void);

@interface HandleBarController : BaseViewController
@property (nonatomic, copy) shareBlock block;

/*
 * 不透明白色背景+有底部线条+返回按钮+title
 */
- (void)setNavigationTitle:(NSString *)title
                isShowBack:(BOOL)isShowBack
                   hasLine:(BOOL)hasLine;
/*
 * 可以在具体页面通过返回的UIView来进行具体自定义
 */
- (UIView *)setNavigationTitle:(NSString *)title
        NavBackViewGroundColor:(UIColor *)navBackViewGroundColor
                     textColor:(UIColor *)textColor
                    isShowBack:(BOOL)isShowBack;
/*
 * 不透明白色背景+有底部线条+返回按钮+title
 */
- (void)setNavigationTitle:(NSString *)title
                isShowBack:(BOOL)isShowBack
                   hasLine:(BOOL)hasLine
              hasRightItem:(BOOL)hasRightItem
                  CallBack:(void(^)(void))callBack;

/*
 * 可以在具体页面通过返回的UIView来进行具体自定义
 */
- (UIView *)setNavigationTitle:(NSString *)title
        NavBackViewGroundColor:(UIColor *)navBackViewGroundColor
                     textColor:(UIColor *)textColor
                    isShowBack:(BOOL)isShowBack
                  hasRightItem:(BOOL)hasRightItem;

/*
 * 返回按钮点击事件
 */

/*
 * 返回按钮点击事件
 */
- (void)navBackBtnClick;

@end

NS_ASSUME_NONNULL_END
