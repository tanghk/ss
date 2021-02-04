//
//  CusAlertView.h
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//



#import <Foundation/Foundation.h>

/**
 *  @brief 点击回调
 *
 *  @param index 点击的下标
 */
typedef void (^CusAlertViewClickedWithIndex)(NSInteger index);
/**
 *  @brief 点击确定按钮回调
 */
typedef void (^CusAlertViewOkClicked)(void);
/**
 *  @brief 点击取消按钮回调
 */
typedef void (^CusAlertViewCancelClicked)(void);


@interface CusAlertView : NSObject


/**
 *  @brief 弹出提示框，点击返回点击下标
 *
 *  @param title           标题
 *  @param msg             提示信息
 *  @param cancelTitle     取消按钮文字
 *  @param handle          点击回调
 */
+ (void)showCusAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle clickHandle:(CusAlertViewClickedWithIndex) handle;



/**
 *  @brief 弹出提示框，点击返回点击下标
 *
 *  @param title           标题
 *  @param msg             提示信息
 *  @param cancelTitle     取消按钮文字
 *  @param okTitle         确定按钮文字
 *  @param otherTitleArray 其他按钮文字
 *  @param handle          点击回调
 */
+ (void)showCusAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle otherButtonTitleArray:(NSArray*)otherTitleArray clickHandle:(CusAlertViewClickedWithIndex) handle;
/**
 *  @brief 弹出提示框只有确定和取消按钮
 *
 *  @param title             标题
 *  @param msg               提示信息
 *  @param cancelTitle       取消按钮文字
 *  @param okTitle           确定按钮文字
 *  @param okHandle          点击确定回调
 *  @param cancelClickHandle 点击取消回调
 */
+ (void)showCusAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle okClickHandle:(CusAlertViewOkClicked)okHandle cancelClickHandle:(CusAlertViewCancelClicked)cancelClickHandle;
/**
 *  @brief 弹出框，没有回调.
 *
 *  @param title           标题
 *  @param msg             提示信息
 *  @param cancelTitle     取消按钮的文字
 *  @param okTitle         确定按钮的文字
 *  @param otherTitleArray 其他按钮文字
 */
+ (void)showCusAlertViewWithTitle:(NSString *)title message:(NSString *)msg cancleButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle otherButtonTitleArray:(NSArray*)otherTitleArray;

@end
