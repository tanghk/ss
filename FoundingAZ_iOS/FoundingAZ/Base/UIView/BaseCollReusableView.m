//
//  BaseCollReusableView.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseCollReusableView.h"

@implementation BaseCollReusableView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self configSubView];
        [self layout];
    }
    
    return self;
}

#pragma mark 添加子视图
- (void)configSubView{}

#pragma mark 布局子视图
- (void)layout{}

- (void)configureCellWithModel:(id)tempModel{}

@end
