//
//  IntegEnterFootView.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "IntegEnterFootView.h"
#import "BaseWKWebView.h"

@interface IntegEnterFootView ()

@property (nonatomic, strong) YYLabel *ruleLabel;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *nextUnBtn;

@end

@implementation IntegEnterFootView

- (void)configSubView{
        
    [self addSubview:self.ruleLabel];
    [self addSubview:self.nextBtn];
    [self addSubview:self.nextUnBtn];
}

- (void)layout{
    
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.top.mas_equalTo(18);
        make.height.mas_equalTo(17);
    }];
}

- (void)configureCellWithModel:(id)contentModel{
    
    
}

#pragma mark 入驻按钮点击事件
- (void)nextBtnClick{
    
    if (self.IntegEnterNextBtnBlock) {
        self.IntegEnterNextBtnBlock();
    }
}

/*
 * creat ruleLabel
 */
- (YYLabel *)ruleLabel{
    
    if (!_ruleLabel) {
        
        NSString *contentStr = @"入驻视为已阅读并同意《集成商入驻协议》";
        
        _ruleLabel = [YYLabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@""];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        attributedStr.yy_font = [UIFont M_PingFang_RegularOfSize:Font_12];
        attributedStr.yy_color = Color_MainGray_one;
        attributedStr.yy_alignment = NSTextAlignmentLeft;
        
        @weakify(self);
        NSRange range = NSMakeRange(10, 9);
        [attributedStr yy_setTextHighlightRange:range color:Color_MainBlue backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            @strongify(self);
            
            BaseWKWebView *vc = [[BaseWKWebView alloc] init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }];
        _ruleLabel.attributedText = attributedStr;
    }
    
    return _ruleLabel;
}

/*
 * creat nextBtn
 */
- (UIButton *)nextBtn{
    
    if (!_nextBtn) {
        _nextBtn = [UIButton createButtonWithFrame:CGRectMake(16, 18+17+24, kScreen_Width-2*16, 48) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_RegularOfSize:Font_18] backgroundColor:Color_MainBlue title:@"同意协议并入驻"];
        ViewShadow(_nextBtn, Color_MainBlue, CGSizeMake(0, 2), 6, 0.3);
        _nextBtn.layer.cornerRadius = 8.0;
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.hidden = NO;
        
        NSArray *colorArray = @[(id)[HEXACOLOR(0x36A8FF, 1.0) CGColor],
                                (id)[HEXACOLOR(0x2A71FF, 1.0) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.nextBtn.bounds), CGRectGetHeight(self.nextBtn.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:8.0];
        [_nextBtn.layer addSublayer:nextBtnLayer];
        [_nextBtn.layer insertSublayer:nextBtnLayer atIndex:0];
    }
    
    return _nextBtn;
}

/*
 * creat nextUnBtn
 */
- (UIButton *)nextUnBtn{
    
    if (!_nextUnBtn) {
        _nextUnBtn = [UIButton createButtonWithFrame:CGRectMake(16, 18+17+24, kScreen_Width-2*16, 48) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainGray_one title:@"同意协议并入驻"];
        ViewRadius(_nextUnBtn, 8.0);
        [_nextUnBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextUnBtn.hidden = YES;
    }
    
    return _nextUnBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
