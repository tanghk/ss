//
//  BaseView.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self initWithData];
        [self configSubView];
        [self layout];
    }
    
    return self;
}

- (void)initWithData{}

#pragma mark 配置样式
- (void)configSubView{}

#pragma mark 写布局
- (void)layout{}

#pragma mark 赋值
- (void)configureViewWithModel:(id)contentModel{}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
