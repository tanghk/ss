//
//  IntegrHomeHeadView.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "IntegrHomeHeadView.h"
#import "IntegrHeadTopView.h"
#import "IntegrHeadBottomView.h"

@interface IntegrHomeHeadView ()

@property (nonatomic, strong) IntegrHeadTopView *topView;
@property (nonatomic, strong) IntegrHeadBottomView *bottomView;

@end

@implementation IntegrHomeHeadView

- (void)configSubView{
    
    self.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
}

- (void)layout{
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(53);
    }];
}

- (void)configureCellWithModel:(id)contentModel{
    
    
}

/*
 * creat topView
 */
- (IntegrHeadTopView *)topView{
    
    if (!_topView) {
        _topView = [[IntegrHeadTopView alloc] initWithFrame:CGRectZero];
    }
    
    return _topView;
}

/*
 * creat bottomView
 */
- (IntegrHeadBottomView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[IntegrHeadBottomView alloc] initWithFrame:CGRectZero];
    }
    
    return _bottomView;
}

@end
