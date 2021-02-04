//
//  UIView+Corner.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "UIView+Corner.h"

@implementation UIView (Corner)

- (void)resetView:(UIView *)targetView byRoundingCorners:(UIRectCorner)cornerRect cornerRadii:(CGSize)size{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:targetView.bounds byRoundingCorners:cornerRect cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = targetView.bounds;
    maskLayer.path = maskPath.CGPath;
    targetView.layer.mask = maskLayer;
}

- (void)roundCorner:(UIRectCorner)rectCorner radius:(CGFloat)radius{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark - Corner Radius
- (void)setCornerRadius:(float)radius {
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.cornerRadius = radius ? radius : 0.0;
    self.layer.masksToBounds = YES;
}

/**
 *  设置成圆
 */
- (void)setCornerCircle {
    [self setCornerRadius:MIN(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds))/2.0];
}

- (void)addBorderWithWidth:(float)width color:(UIColor *)color {
    self.layer.borderWidth = width ? width : 1.0;
    self.layer.borderColor = color ? color.CGColor : [UIColor blackColor].CGColor;
    self.layer.masksToBounds = YES;
}

- (void)setClipCircleAndColor:(UIColor *)color
{
    [self setCornerCircle];
    [self addBorderWithWidth:1.5 color:color];
}

//四周阴影路径
- (UIBezierPath *)boundShadowPathForAddWidth:(CGFloat)addWidth
{
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width = self.bounds.size.width;
    float height = self.bounds.size.height;
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float addWH = addWidth;
    
    CGPoint topLeft      = CGPointMake(x-addWH, y-addWH);
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width+addWH,y-addWH);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width+addWH,y+height+addWH);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x-addWH,y+height+addWH);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];
    //添加四个二元曲线
//    [path addQuadCurveToPoint:topRight
//                 controlPoint:topMiddle];
//    [path addQuadCurveToPoint:bottomRight
//                 controlPoint:rightMiddle];
//    [path addQuadCurveToPoint:bottomLeft
//                 controlPoint:bottomMiddle];
//    [path addQuadCurveToPoint:topLeft
//                 controlPoint:leftMiddle];
    return path;
}

@end
