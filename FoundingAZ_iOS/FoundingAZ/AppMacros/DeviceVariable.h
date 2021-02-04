//
//  DeviceVariable.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#ifndef DeviceVariable_h
#define DeviceVariable_h

/*
* UIApplication
*/
#define kApplication [UIApplication sharedApplication]
#define kAppWindow  [UIApplication sharedApplication].delegate.window
#define kRootViewController [UIApplication sharedApplication].delegate.window.rootViewController

/*
 * 设备相关信息
 */
//ios系统号
#define kSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//屏幕尺寸
#define Get_Real_Px()
#define ScreenFrame                         [[UIScreen mainScreen] bounds]
//设备的宽
#define kScreen_Width ([UIScreen mainScreen].bounds.size.width)

//设备的高
#define kScreen_Height ([UIScreen mainScreen].bounds.size.height)

//状态栏的高度
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

// 导航栏高度
#define kNavBarHeight 44.0

//状态栏 + 导航栏 = 总高度
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

//TabBar高度
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height >20 ? 83:49)

// 底部安全区
#define kBottomHeight ([[UIApplication sharedApplication] statusBarFrame].size.height >20 ? 34:0)

// 刘海的状态栏高度差值
#define kTopBarDifHeight ([[UIApplication sharedApplication] statusBarFrame].size.height >20 ?  24 : 0)

//宽的比例
#define kScale_WIDTH(X)  X*([UIScreen mainScreen].bounds.size.width/375.0)

//高的比例
#define kScale_HEIGHT(X) X*([UIScreen mainScreen].bounds.size.height/667.0)

//获得当前屏幕宽与6的屏宽比例
#define RATIO_W                             [UIScreen mainScreen].bounds.size.width/375
//获得当前屏幕高与6的屏高比例
#define RATIO_H                             [UIScreen mainScreen].bounds.size.height/667
#define X(x)                                x*RATIO_W
#define Y(y)                                y*RATIO_H
#define Width(width)                        ceilf(width*RATIO_W)
#define Height(height)                      ceilf(height*RATIO_H)

/*
 * 打印
 */
#ifdef DEBUG
#define XZNSLog( s, ... ) NSLog( @"<%p %@:(第%d行)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define XZNSLog(...)
#endif


/*
 * 圆角相关
 */
//圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//View 阴影
#define ViewShadow(View,Color,Offset,Radius,Opacity)\
\
[View.layer setShadowColor:[Color CGColor]];\
[View.layer setShadowOffset:Offset];\
[View.layer setShadowRadius:(Radius)];\
[View.layer setShadowOpacity:(Opacity)];



//图片-快捷定义
#define kImage(image)                       [UIImage imageNamed:image]
//颜色-快捷定义
#define kWhiteColor(white,alph)             [UIColor colorWithWhite:white alpha:alph]
#endif /* DeviceVariable_h */
