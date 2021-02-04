//
//  XZTabBarItem.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "XZTabBarItem.h"

#define IconImageWidth  24

@interface XZTabBarItem ()

@end

@implementation XZTabBarItem

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubViewsInview];
        [self layOutSubiewsInview];
    }
    
    return self;
}

#pragma mark 添加子视图
- (void)addSubViewsInview{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.iconImage];
    [self addSubview:self.redImageV];
    [self addSubview:self.barViewBtn];
}

#pragma mark 布局子视图
- (void)layOutSubiewsInview{
        
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.centerY.equalTo(self.mas_centerY).with.offset(IconImageWidth/2+2/1);
        make.height.mas_equalTo(14);
    }];
    
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.titleLabel.mas_top).with.offset(-2/1);
        make.size.mas_equalTo(CGSizeMake(IconImageWidth, IconImageWidth));
    }];
    
    [self.redImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.iconImage.mas_right).with.offset(3);
        make.top.equalTo(self.iconImage.mas_top).with.offset(-3);
        make.size.mas_equalTo(CGSizeMake(8, 8));
    }];

    [self.barViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.top.mas_equalTo(0);
        make.right.bottom.mas_equalTo(0);
    }];
}

/*
 * creat titleLabel
 */
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont M_PingFang_RegularOfSize:Font_11];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    
    return _titleLabel;
}

/*
 * creat iconImage
 */
- (UIButton *)iconImage{
    
    if (!_iconImage) {
        _iconImage = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconImage.backgroundColor = [UIColor whiteColor];
    }
    
    return _iconImage;
}

/*
 * creat redImageV
 */
- (UIImageView *)redImageV{
    
    if (!_redImageV) {
        _redImageV = [[UIImageView alloc] init];
        ViewRadius(_redImageV, 4);
        _redImageV.hidden = YES;
        _redImageV.backgroundColor = [UIColor redColor];
    }
    
    return _redImageV;
}

/*
 * creat barViewBtn
 */
- (UIButton *)barViewBtn{
    
    if (!_barViewBtn) {
        _barViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _barViewBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _barViewBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
