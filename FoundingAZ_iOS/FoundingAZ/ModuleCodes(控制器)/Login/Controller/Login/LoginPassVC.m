//
//  LoginPassVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "LoginPassVC.h"
#import "VerfiyPhoneVC.h"
#import "LoginPhoneVC.h"

@interface LoginPassVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *whiteCornerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIButton *eyeBtn;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UIImageView *phoneImageV;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *nextUnBtn;
@property (nonatomic, strong) UIButton *codeLoginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIImageView *vLineImageV;

@end

@implementation LoginPassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

#pragma mark 返回按钮点击事件
- (void)closeBtnClick{
    
    for (UIViewController *ctrl in self.navigationController.viewControllers) {
        if ([ctrl isKindOfClass:[LoginPhoneVC class]]) {
            [self.navigationController popToViewController:ctrl animated:YES];
            return;;
        }
    }
}

#pragma mark 眼睛按钮点击事件
- (void)eyeBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        self.phoneField.secureTextEntry = NO;
    }else{
        self.phoneField.secureTextEntry = YES;
    }
}

#pragma mark 清除按钮点击事件
- (void)clearBtnClick{
    
    self.phoneField.text = @"";
    self.clearBtn.hidden = YES;
    self.nextBtn.hidden = YES;
    self.nextUnBtn.hidden = NO;
}

#pragma mark 登录按钮点击事件
- (void)nextBtnClick{
    
    if ([NSString stringIsEmpty:self.phoneField.text]) {
        return;
    }
    [MBProgressHUD showMessageInWindow:@"登录按钮"];
}

#pragma mark 验证码登录按钮点击事件
- (void)codeLoginBtnClick{
    
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark 忘记密码按钮点击事件
- (void)forgetBtnClick{
    
    VerfiyPhoneVC *vc = [[VerfiyPhoneVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidChange:(UITextField *)textField{
    
    if ([NSString stringIsEmpty:textField.text]) {
        self.clearBtn.hidden = YES;
        self.nextBtn.hidden = YES;
        self.nextUnBtn.hidden = NO;
    }else{
        self.clearBtn.hidden = NO;
        self.nextBtn.hidden = NO;
        self.nextUnBtn.hidden = YES;
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
    [self.view addSubview:self.eyeBtn];
    [self.view addSubview:self.clearBtn];
    [self.view addSubview:self.lineImageV];
    [self.view addSubview:self.phoneImageV];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.nextUnBtn];
    [self.view addSubview:self.codeLoginBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.vLineImageV];
    
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
        make.right.mas_equalTo(-90);
        make.height.mas_equalTo(64);
    }];
    
    [self.eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(32, 32));//16*16
        make.centerY.equalTo(self.phoneField);
        make.right.mas_equalTo(-25+8);
    }];
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(32, 32));//16*16
        make.centerY.equalTo(self.phoneField);
        make.right.equalTo(self.eyeBtn.mas_left).with.offset(-16+8+8);
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
    
    [self.codeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-kScreen_Width/2-1-24);
        make.top.equalTo(self.lineImageV.mas_bottom).with.offset(30+52+10);
        make.height.mas_equalTo(34);
    }];
    
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.codeLoginBtn.mas_right).with.offset(24+24);
        make.right.mas_equalTo(-25);
        make.top.equalTo(self.codeLoginBtn);
        make.height.mas_equalTo(34);
    }];
    
    [self.vLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(0.5);
        make.centerY.equalTo(self.codeLoginBtn);
        make.height.mas_equalTo(14);
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
        _closeBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"G_Nav_back_white"];
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
        _titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_24] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"账号密码登录"];
    }
    
    return _titleLabel;
}

/*
 * creat subTitleLabel
 */
- (UILabel *)subTitleLabel{
    
    if (!_subTitleLabel) {
        
        NSString *pStr = [NSString M_replacePhoneMid4String:self.phoneStr];
        
        _subTitleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_16] textColor:Color_MainGray textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:[NSString stringWithFormat:@"请使用%@账号密码登录",pStr]];
    }
    
    return _subTitleLabel;
}

/*
 * creat
 */
- (UITextField *)phoneField{
    
    if (!_phoneField) {
        _phoneField = [[UITextField alloc] initWithFrame:CGRectZero];
        _phoneField.delegate = self;
        _phoneField.text = @"";
        _phoneField.placeholder = @"请输入密码";
        _phoneField.textColor = Color_MainBlack;
        _phoneField.font = [UIFont M_PingFang_RegularOfSize:Font_16];;
        _phoneField.textAlignment = NSTextAlignmentLeft;
        _phoneField.returnKeyType = UIReturnKeyDone;
        _phoneField.keyboardType = UIKeyboardTypeDefault;
        _phoneField.clearButtonMode = UITextFieldViewModeNever;
        _phoneField.secureTextEntry = YES;
        _phoneField.backgroundColor = [UIColor whiteColor];
        
        [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _phoneField;
}

/*
 * creat eyeBtn
 */
- (UIButton *)eyeBtn{
    
    if (!_eyeBtn) {
        _eyeBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"L_UnEye_img" selectedImage:@"L_Eye_img"];
        [_eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _eyeBtn.backgroundColor = [UIColor whiteColor];
    }
    
    return _eyeBtn;
}

/*
 * creat clearBtn
 */
- (UIButton *)clearBtn{
    
    if (!_clearBtn) {
        _clearBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"G_Field_clear"];
        [_clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _clearBtn.hidden = YES;
        _clearBtn.backgroundColor = [UIColor whiteColor];
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
        _phoneImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"L_pass_img"];
    }
    
    return _phoneImageV;
}

/*
 * creat nextBtn
 */
- (UIButton *)nextBtn{
    
    if (!_nextBtn) {
        _nextBtn = [UIButton createButtonWithFrame:CGRectMake(25, kScreen_Width*208/375+14+33+6+22+20+64+1.5+30, kScreen_Width-2*25, 52) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainBlue title:@"登录"];
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
        _nextUnBtn = [UIButton createButtonWithFrame:CGRectMake(25, kScreen_Width*208/375+14+33+6+22+20+64+1.5+30, kScreen_Width-2*25, 52) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainGray_one title:@"登录"];
        ViewRadius(_nextUnBtn, 8.0);
        [_nextUnBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextUnBtn.hidden = NO;
    }
    
    return _nextUnBtn;
}

/*
 * creat codeLoginBtn
 */
- (UIButton *)codeLoginBtn{
    
    if (!_codeLoginBtn) {
        _codeLoginBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainGray font:[UIFont M_PingFang_MediumOfSize:Font_16] backgroundColor:[UIColor whiteColor] title:@"验证码登录"];
        [_codeLoginBtn addTarget:self action:@selector(codeLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_codeLoginBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    
    return _codeLoginBtn;
}

/*
 * creat forgetBtn
 */
- (UIButton *)forgetBtn{
    
    if (!_forgetBtn) {
        _forgetBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainGray font:[UIFont M_PingFang_MediumOfSize:Font_16] backgroundColor:[UIColor whiteColor] title:@"忘记密码"];
        [_forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_forgetBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    
    return _forgetBtn;
}

/*
 * creat vLineImageV
 */
- (UIImageView *)vLineImageV{
    
    if (!_vLineImageV) {
        _vLineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
        _vLineImageV.backgroundColor = Color_MainGray_Two;
    }
    
    return _vLineImageV;
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
