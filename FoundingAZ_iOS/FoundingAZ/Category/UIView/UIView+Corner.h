//
//  UIView+Corner.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corner)

/**
 *  视图圆角个数
 *
 *  @param targetView 目标视图
 *  @param cornerRect 圆角类型：左上、左下、右上、右下  用 | 来控制显示显示个数
 *  @param size       圆角弧度
 */
- (void)resetView:(UIView *)targetView byRoundingCorners:(UIRectCorner)cornerRect cornerRadii:(CGSize)size;

- (void)roundCorner:(UIRectCorner)rectCorner radius:(CGFloat)radius;

/**
 设置圆角.
 @param radius  - float for corner radius
 */
- (void)setCornerRadius:(float)radius;

/**
 *  设置成圆
 */
- (void)setCornerCircle;

/**
 *  添加边界线
 *
 *  @param width 宽度
 *  @param color 颜色
 */
- (void)addBorderWithWidth:(float)width color:(UIColor *)color;

/**
 *  设置圆 并添加颜色 宽度默认1.5
 *
 *  @param color 颜色
 */
- (void)setClipCircleAndColor:(UIColor *)color;


/**
 四周阴影路径

 @param addWidth 路径加宽值
 @return 绘制的路径
 */
- (UIBezierPath *)boundShadowPathForAddWidth:(CGFloat)addWidth;

@end

NS_ASSUME_NONNULL_END
