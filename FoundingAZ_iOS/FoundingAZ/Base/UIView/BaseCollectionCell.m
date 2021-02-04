//
//  BaseCollectionCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell

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

#pragma mark 赋值
- (void)configureCellWithModel:(id)contentModel{}

@end
