//
//  UIView+convenience.m
//  JobApp
//

#import "UIView+convenience.h"

@implementation UIView (convenience)

-(CGFloat)frameX
{
    return self.frame.origin.x;
}

-(void)setFrameX:(CGFloat)frameX
{
    self.frame = CGRectMake(frameX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(CGFloat)frameY
{
    return self.frame.origin.y;
}

-(void)setFrameY:(CGFloat)frameY
{
    self.frame = CGRectMake(self.frame.origin.x, frameY, self.frame.size.width, self.frame.size.height);
}

-(CGFloat)frameWidth
{
    return self.frame.size.width;
}

-(void)setFrameWidth:(CGFloat)frameWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, frameWidth, self.frame.size.height);
}

-(CGFloat)frameHeight
{
    return self.frame.size.height;
}

-(void)setFrameHeight:(CGFloat)frameHeight
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, frameHeight);
}

-(CGFloat)frameRight
{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setFrameRight:(CGFloat)frameRight
{
    self.frame = CGRectMake(frameRight-self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

-(CGFloat)frameBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setFrameBottom:(CGFloat)frameBottom
{
    self.frame = CGRectMake(self.frame.origin.x, frameBottom-self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

-(CGFloat)centerY
{
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY
{
    self.center = CGPointMake(self.center.x, centerY);
}

@end
