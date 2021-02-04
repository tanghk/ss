//
//  LoginPhoneVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "LoginPhoneVC.h"
#import "LoginCodeVC.h"
#import "BaseWKWebView.h"

@interface LoginPhoneVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *whiteCornerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UIImageView *phoneImageV;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *nextUnBtn;
@property (nonatomic, strong) YYLabel *ruleLabel;

@property (nonatomic, assign) NSInteger inteIndex;

@end

@implementation LoginPhoneVC

- (void)initWithData{
    [super initWithData];
    
    self.inteIndex = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.fromeType == 1) {
        LoginCodeVC *vc = [[LoginCodeVC alloc] init];
        vc.fromeType = 1;
        vc.phoneStr = self.phoneStr;
        [self.navigationController pushViewController:vc animated:NO];
    }
    
    // Do any additional setup after loading the view.
}

#pragma mark 关闭按钮点击事件
- (void)closeBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 下一步按钮点击事件
- (void)nextBtnClick{
    
    NSString *tStr = self.phoneField.text;
    tStr = [tStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (tStr.length < 11) {
        return;
    }
    
    LoginCodeVC *vc = [[LoginCodeVC alloc] init];
    vc.phoneStr = tStr;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark 清除按钮点击事件
- (void)clearBtnClick{
    
    self.phoneField.text = @"";
    self.clearBtn.hidden = YES;
    self.nextBtn.hidden = YES;
    self.nextUnBtn.hidden = NO;
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidChange:(UITextField *)textField{
    
    self.nextBtn.hidden = YES;
    self.nextUnBtn.hidden = NO;
    if (textField.text.length > self.inteIndex) {
        if (textField.text.length == 1 && ![textField.text isEqualToString:@"1"]) {
            [MBProgressHUD showMessageInWindow:@"请输入正确的手机号码"];
            textField.text = @"";
        }
        if (textField.text.length >= 4) {//输入
            NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
            if ([[textField.text substringWithRange:NSMakeRange(3, 1)] isEqualToString:@" "]) {
                //不做处理
            }else{
               [str insertString:@" " atIndex:3];
            }
            textField.text = str;
        }
        if (textField.text.length >= 9) {//输入
            NSMutableString * str = [[NSMutableString alloc ] initWithString:textField.text];
            if ([[textField.text substringWithRange:NSMakeRange(8, 1)] isEqualToString:@" "]) {
                //不做处理
            }else{
               [str insertString:@" " atIndex:8];
            }
            textField.text = str;
        }
        if (textField.text.length >= 13 ) {//输入完成
            textField.text = [textField.text substringToIndex:13];
            self.nextBtn.hidden = NO;
            self.nextUnBtn.hidden = YES;
        }
        self.inteIndex = textField.text.length;
        
    }else if (textField.text.length < self.inteIndex){//删除
        if (textField.text.length == 4 || textField.text.length == 9) {
            textField.text = [NSString stringWithFormat:@"%@",textField.text];
            textField.text = [textField.text substringToIndex:(textField.text.length-1)];
        }
        self.inteIndex = textField.text.length;
    }
    
    if ([NSString stringIsEmpty:textField.text]) {
        self.clearBtn.hidden = YES;
    }else{
        self.clearBtn.hidden = NO;
    }
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
    [self.view addSubview:self.headImageV];
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.whiteCornerView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.subTitleLabel];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.clearBtn];
    [self.view addSubview:self.lineImageV];
    [self.view addSubview:self.phoneImageV];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.nextUnBtn];
    [self.view addSubview:self.ruleLabel];
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreen_Width*208/375);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20-10);
        make.top.mas_equalTo(kStatusBarHeight+10-10);
        make.size.mas_equalTo(CGSizeMake(44, 44));//24*24
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(25);
        make.top.equalTo(self.headImageV.mas_bottom).with.offset(14);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(33);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(25);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(6);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(22);
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(25+24+16);
        make.top.equalTo(self.subTitleLabel.mas_bottom).with.offset(20);
        make.right.mas_equalTo(-60);
        make.height.mas_equalTo(64);
    }];
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(44, 44));//16*16
        make.centerY.equalTo(self.phoneField);
        make.right.mas_equalTo(-25+14);
    }];
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(25);
        make.top.equalTo(self.phoneField.mas_bottom).with.offset(1);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.phoneImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(25);
        make.centerY.equalTo(self.phoneField);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.equalTo(self.lineImageV.mas_bottom).with.offset(30+52+20);
        make.height.mas_equalTo(17);
    }];
}

/*
 * creat headImageV
 */
- (UIImageView *)headImageV{
    
    if (!_headImageV) {
        _headImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"L_phone_groud"];
    }
    
    return _headImageV;
}

/*
 * creat closeBtn
 */
- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        _closeBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"G_close_white"];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _closeBtn;
}

/*
 * creat whiteCornerView
 */
- (UIView *)whiteCornerView{
    
    if (!_whiteCornerView) {
        _whiteCornerView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Width*208/375-10, kScreen_Width, 24)];
        [_whiteCornerView roundCorner:UIRectCornerTopLeft | UIRectCornerTopRight radius:8.0];
        _whiteCornerView.backgroundColor = [UIColor whiteColor];
    }
    
    return _whiteCornerView;
}

/*
 * creat titleLabel
 */
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_24] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"请输入手机号"];
    }
    
    return _titleLabel;
}

/*
 * creat subTitleLabel
 */
- (UILabel *)subTitleLabel{
    
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_16] textColor:Color_MainGray textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"未注册过的手机号将自动创建账号"];
    }
    
    return _subTitleLabel;
}

/*
 * creat
 */
- (UITextField *)phoneField{
    
    NSString *mString = @"";
    if (![NSString stringIsEmpty:self.phoneStr]) {
        self.nextBtn.hidden = NO;
        self.nextUnBtn.hidden = YES;
        
        mString = self.phoneStr;
        
        if (mString.length >= 4) {//输入
            NSMutableString * str = [[NSMutableString alloc ] initWithString:mString];
            [str insertString:@" " atIndex:3];
            mString = str;
        }
        if (mString.length >= 9) {//输入
            NSMutableString * str = [[NSMutableString alloc ] initWithString:mString];
            [str insertString:@" " atIndex:8];
            mString = str;
        }
    }
    
    if (!_phoneField) {
        _phoneField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneField.delegate = self;
        _phoneField.text = mString;
        _phoneField.placeholder = @"请输入手机号码";
        _phoneField.textColor = Color_MainBlack;
        _phoneField.font = [UIFont M_PingFang_RegularOfSize:Font_16];;
        _phoneField.textAlignment = NSTextAlignmentLeft;
        _phoneField.returnKeyType = UIReturnKeyDone;
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneField.clearButtonMode = UITextFieldViewModeNever;
        _phoneField.backgroundColor = [UIColor whiteColor];
        
        [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _phoneField;
}

/*
 * creat clearBtn
 */
- (UIButton *)clearBtn{
    
    if (!_clearBtn) {
        _clearBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"G_Field_clear"];
        [_clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _clearBtn.hidden = YES;
        _clearBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _clearBtn;
}

/*
 * creat lineImageV
 */
- (UIImageView *)lineImageV{
    
    if (!_lineImageV) {
        _lineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
        _lineImageV.backgroundColor = Color_Separator;
    }
    
    return _lineImageV;
}

/*
 * creat phoneImageV
 */
- (UIImageView *)phoneImageV{
    
    if (!_phoneImageV) {
        _phoneImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"L_phone_img"];
    }
    
    return _phoneImageV;
}

/*
 * creat nextBtn
 */
- (UIButton *)nextBtn{
    
    if (!_nextBtn) {
        _nextBtn = [UIButton createButtonWithFrame:CGRectMake(25, kScreen_Width*208/375+14+33+6+22+20+64+1.5+30, kScreen_Width-2*25, 52) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainBlue title:@"下一步"];
        ViewShadow(_nextBtn, Color_MainBlue, CGSizeMake(0, 2), 6, 0.3);
        _nextBtn.layer.cornerRadius = 8.0;
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.hidden = YES;
        
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
        _nextUnBtn = [UIButton createButtonWithFrame:CGRectMake(25, kScreen_Width*208/375+14+33+6+22+20+64+1.5+30, kScreen_Width-2*25, 52) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainGray_one title:@"下一步"];
        ViewRadius(_nextUnBtn, 8.0);
        [_nextUnBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextUnBtn.hidden = NO;
    }
    
    return _nextUnBtn;
}

/*
 * creat
 */
- (YYLabel *)ruleLabel{
    
    if (!_ruleLabel) {
        
        NSString *contentStr = @"注册登录表示已阅读并同意《自动化服务条款》";
        
        _ruleLabel = [YYLabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@""];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        attributedStr.yy_font = [UIFont M_PingFang_RegularOfSize:Font_12];
        attributedStr.yy_color = Color_MainGray_one;
        attributedStr.yy_alignment = NSTextAlignmentCenter;
        
        NSRange range1 =[contentStr rangeOfString:@"《自动化服务条款》" options:NSCaseInsensitiveSearch];
        YYTextDecoration *decoration = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@(1) color:Color_MainBlue];
        [attributedStr yy_setTextUnderline:decoration range:range1];
        
        
        @weakify(self);
        NSRange range = NSMakeRange(12, 9);
        [attributedStr yy_setTextHighlightRange:range color:Color_MainBlue backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
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
