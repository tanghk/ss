//
//  UIView+TapGesture.m
//  iMuGou
//

#import "UIView+TapGesture.h"
#import <objc/message.h>

#define Tag_Line_Top    5555
#define Tag_Line_Left   6666
#define Tag_Line_Bottom 7777
#define Tag_Line_Right  8888
@interface UIView ()


@end

@implementation UIView (TapGesture)

#pragma mark - 点击事件

-(void)setTapBlock:(ViewTapBlock)tapBlock{
    objc_setAssociatedObject(self, @"AddClickedEvent", tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(ViewTapBlock)tapBlock{
    return objc_getAssociatedObject(self, @"AddClickedEvent");
}

-(void)addTapGestureWithBlock:(ViewTapBlock)block{
    self.tapBlock = block;
    
    // hy:先判断当前是否有交互事件，如果没有的话。。。所有gesture的交互事件都会被添加进gestureRecognizers中
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        //添加单击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
}

-(void)tap:(UITapGestureRecognizer *)sender{
    if (self.tapBlock) {
        self.tapBlock(sender.view);
    }
}

#pragma mark - 长按事件

-(void)setTapLongBlock:(ViewLongTapBlock)tapLongBlock{
    objc_setAssociatedObject(self, @"AddLongClickedEvent", tapLongBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(ViewLongTapBlock)tapLongBlock{
    return objc_getAssociatedObject(self, @"AddLongClickedEvent");
}

-(void)addLongTapGestureWithBlock:(ViewLongTapBlock)block{
    self.tapLongBlock = block;
    
    // hy:先判断当前是否有交互事件，如果没有的话。。。所有gesture的交互事件都会被添加进gestureRecognizers中
    if (![self gestureRecognizers]) {
        self.userInteractionEnabled = YES;
        //添加单击事件
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTap:)];
        tap.minimumPressDuration = 2;
        [self addGestureRecognizer:tap];
    }
}

-(void)longTap:(UILongPressGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.tapLongBlock) {
            self.tapLongBlock(sender.view);
        }
    }
}


-(void)setBorderColor:(UIColor *)color Width:(CGFloat)width CornerRadius:(CGFloat)cornerRadius{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

-(void)setShadowColor:(UIColor *)color Offset:(CGSize)offset ShadowOpacity:(CGFloat)opacity{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath = shadowPath.CGPath;
}

-(void)setBezierPathRectCorner:(UIRectCorner)rectCorner CornerRadius:(CGSize)cornerRadius{
    UIBezierPath *topMaskPath=[UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(rectCorner) cornerRadii:cornerRadius];
    CAShapeLayer *topMaskLayer=[[CAShapeLayer alloc]init];
    self.layer.masksToBounds = YES;
    topMaskLayer.frame=self.bounds;
    topMaskLayer.path=topMaskPath.CGPath;
    self.layer.mask=topMaskLayer;
    
}

//虚线四角边框
-(void)setBorderStrokeColor:(UIColor *)color LineWidth:(CGFloat)lineWidth LineDashPattern:(NSArray *)lineDashPattern CornerRadius:(CGFloat)cornerRadius{
    
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = color.CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    //设置路径
    border.path = path.CGPath;
    
    border.frame = self.bounds;
    //虚线的宽度
    border.lineWidth = lineWidth;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = lineDashPattern;
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    
    [self.layer addSublayer:border];
    
}

-(void)addLineWithColor:(UIColor *)color Weight:(CGFloat)weight Position:(NSInteger)position{
    switch (position) {
        case LineLocation_Top:{
            UIView *line = (UIView *)[self viewWithTag:Tag_Line_Top];
            if (line) {
                [self removeLinePosition:position];
            }
            line = [MTools createViewWithColor:color];
            line.tag = Tag_Line_Top;
            line.frame = CGRectMake(0, 0, self.frameWidth, weight);
            [self addSubview:line];
            [self bringSubviewToFront:line];
            
        }break;
        case LineLocation_Left:{
            UIView *line = (UIView *)[self viewWithTag:Tag_Line_Left];
            if (line) {
                [self removeLinePosition:position];
            }
            line = [MTools createViewWithColor:color];
            line.tag = Tag_Line_Left;
            line.frame = CGRectMake(0, 0, weight, self.frameHeight);
            [self addSubview:line];
            [self bringSubviewToFront:line];
        }break;
        case LineLocation_Right:{
            UIView *line = (UIView *)[self viewWithTag:Tag_Line_Right];
            if (line) {
                [self removeLinePosition:position];
            }
            line = [MTools createViewWithColor:color];
            line.tag = Tag_Line_Right;
            line.frame = CGRectMake(self.frameWidth - weight, 0, weight, self.frameHeight);
            [self addSubview:line];
            [self bringSubviewToFront:line];
        }break;
        case LineLocation_Bottom:{
            UIView *line = (UIView *)[self viewWithTag:Tag_Line_Bottom];
            if (line) {
                [self removeLinePosition:position];
            }
            line = [MTools createViewWithColor:color];
            line.tag = Tag_Line_Bottom;
            line.frame = CGRectMake(0, self.frameHeight - weight, self.frameWidth, weight);
            [self addSubview:line];
            [self bringSubviewToFront:line];
        }break;
        default:
            break;
    }
}

-(void)removeLinePosition:(NSInteger)position{
    switch (position) {
        case LineLocation_Top:{
            UIView *line = (UIView *)[self viewWithTag:Tag_Line_Top];
            if (line) {
                [line removeFromSuperview];
            }
        }break;
        case LineLocation_Left:{
            UIView *line = (UIView *)[self viewWithTag:Tag_Line_Left];
            if (line) {
                [line removeFromSuperview];
            }
        }break;
        case LineLocation_Right:{
            UIView *line = (UIView *)[self viewWithTag:Tag_Line_Right];
            if (line) {
                [line removeFromSuperview];
            }
        }break;
        case LineLocation_Bottom:{
            UIView *line = (UIView *)[self viewWithTag:Tag_Line_Bottom];
            if (line) {
                [line removeFromSuperview];
            }
        }break;
        default:
            break;
    }
}

//设置渐变背景色
-(void)setGradientLayerStartColor:(UIColor *)startColor endColor:(UIColor *)endColor cornerRadius:(CGFloat)cornerRadius{
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, self.frameWidth, self.frameHeight);
    gl.startPoint = CGPointMake(0, 0.5);
    gl.endPoint = CGPointMake(1, 0.5);
    gl.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gl.locations = @[@(0), @(1.0f)];
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    [self.layer addSublayer:gl];
    
}
//开始弹框动画
-(void)beginAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
    animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.5;
    //    animation.delegate = self;
    //    [animation setValue:completion forKey:@"handler"];
    [self.layer addAnimation:animation forKey:@"bouce"];
}

//弹框动画消失
-(void)dismissAnimation{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(1), @(1.2), @(0.01)];
    animation.keyTimes = @[@(0), @(0.4), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.35;
//    animation.delegate = self;
//    [animation setValue:completion forKey:@"handler"];
    [self.layer addAnimation:animation forKey:@"bounce"];
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
}

@end
