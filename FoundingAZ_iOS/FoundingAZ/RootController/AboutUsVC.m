//
//  AboutUsVC.m
//  FoundingAZ
//
//  Created by mark on 2021/1/29.
//

#import "AboutUsVC.h"

@interface AboutUsVC ()
@property (nonatomic, strong) UIImageView *logoImageV;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *copyrightLabel;
@property (nonatomic, strong) UILabel *companyLabel;
@property (nonatomic, strong) YYLabel *ruleLabel;
@end

@implementation AboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"关于我们" isShowBack:YES hasLine:NO];
}

#pragma mark - 页面布局
- (void)initWithMainUI{
    [super initWithMainUI];
    [self.view addSubview:self.logoImageV];
    [self.view addSubview:self.subTitleLabel];
    [self.view addSubview:self.copyrightLabel];
    [self.view addSubview:self.companyLabel];
    [self.view addSubview:self.ruleLabel];
    
    [self.logoImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(80, 80));//16*16
        make.top.mas_equalTo(kTopHeight+70);
    }];
    
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.logoImageV.mas_bottom).with.offset(15);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(147.5);
    }];
    
    [self.copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-30-kBottomHeight);
        make.centerX.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(17);
        
    }];
    
    [self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.copyrightLabel.mas_top).with.offset(-5);
        make.centerX.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(17);
    }];
    
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.companyLabel.mas_top).with.offset(-20);
        make.centerX.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(17);
    }];
    
}
/*
 * creat phoneImageV
 */
- (UIImageView *)logoImageV{
    
    if (!_logoImageV) {
        _logoImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"Mine_About_Logo"];
    }
    
    return _logoImageV;
}

/*
 * creat subTitleLabel
 */
- (UILabel *)subTitleLabel{
    
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:Color_MainGray textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"未注册过的手机号码将自动注册"];
        
        UILabel *label = [[UILabel alloc] init];
        
        label.numberOfLines = 0;
        
        NSString *version =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        NSString *str = [NSString stringWithFormat:@"陪伴与成就商业新领袖一站式企业服务平台  \n\n当前版本V%@",version];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.000000]} range:NSMakeRange(0, 22)];
        
        [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:244/255.0 green:87/255.0 blue:42/255.0 alpha:1.000000]} range:NSMakeRange(23, 5+version.length)];
        
        label.attributedText = string;
        label.textAlignment = NSTextAlignmentCenter;
        label.alpha = 1.0;
        _subTitleLabel =label;
        
    }
    
    return _subTitleLabel;
}

/*
 *copyrightLabel
 */
- (UILabel *)copyrightLabel{
    
    if (!_copyrightLabel) {
        _copyrightLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_12] textColor:Color_MainGray textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@"Copyright © 2014-2021 foundingaz.All rights reserved."];
    }
    
    return _copyrightLabel;
}
/*
 *companyLabel
 */
- (UILabel *)companyLabel{
    
    if (!_companyLabel) {
        _companyLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_12] textColor:Color_MainGray textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@"北京创业酵母管理咨询有限公司 版权所有"];
    }
    
    return _companyLabel;
}
/*
 * creat
 */
- (YYLabel *)ruleLabel{
    
    if (!_ruleLabel) {
        
        NSString *contentStr = @"《用户协议》和《隐私协议》";
        
        _ruleLabel = [YYLabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@""];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        attributedStr.yy_font = [UIFont M_PingFang_RegularOfSize:Font_12];
        attributedStr.yy_color = Color_MainGray;
        attributedStr.yy_alignment = NSTextAlignmentCenter;
        
        @weakify(self);
        NSRange range = NSMakeRange(0, 6);
        [attributedStr yy_setTextHighlightRange:range color:Color_MainRed backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            @strongify(self);
            
            BaseWKWebView *vc = [[BaseWKWebView alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        
        NSRange range0 = NSMakeRange(7, 6);
        [attributedStr yy_setTextHighlightRange:range0 color:Color_MainRed backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            @strongify(self);
            
            BaseWKWebView *vc = [[BaseWKWebView alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        _ruleLabel.attributedText = attributedStr;
    }
    
    return _ruleLabel;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
