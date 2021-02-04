//
//  UIView+TapGesture.h
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LineLocation) {
    LineLocation_Top,
    LineLocation_Left,
    LineLocation_Right,
    LineLocation_Bottom,
};


typedef void(^ViewTapBlock)(id sender);
typedef void(^ViewLongTapBlock)(id sender);

@interface UIView (TapGesture)

@property(nonatomic, copy) ViewTapBlock tapBlock;
@property(nonatomic, copy) ViewLongTapBlock tapLongBlock;

-(void)addTapGestureWithBlock:(ViewTapBlock)block;

-(void)addLongTapGestureWithBlock:(ViewLongTapBlock)block;

//边框和圆角
-(void)setBorderColor:(UIColor *)color Width:(CGFloat)width CornerRadius:(CGFloat)cornerRadius;

//阴影
-(void)setShadowColor:(UIColor *)color Offset:(CGSize)offset ShadowOpacity:(CGFloat)opacity;

//虚线四角边框
-(void)setBorderStrokeColor:(UIColor *)color LineWidth:(CGFloat)lineWidth LineDashPattern:(NSArray *)lineDashPattern CornerRadius:(CGFloat)cornerRadius;

//指定圆角
-(void)setBezierPathRectCorner:(UIRectCorner)rectCorner CornerRadius:(CGSize)cornerRadius;



//指定边框
-(void)addLineWithColor:(UIColor *)color Weight:(CGFloat)weight Position:(NSInteger)position;

-(void)removeLinePosition:(NSInteger)position;
//设置渐变背景色
-(void)setGradientLayerStartColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius;

//开始弹框动画
-(void)beginAnimation;

//弹框动画消失
-(void)dismissAnimation;
@end
