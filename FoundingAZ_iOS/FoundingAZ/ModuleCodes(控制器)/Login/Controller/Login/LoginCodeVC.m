//
//  LoginCodeVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "LoginCodeVC.h"
#import "LoginPassVC.h"
#import "BaseWKWebView.h"
#define TextFiledTag 1000
#define ClearTag 2000

@interface LoginCodeVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UIView *whiteCornerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UIButton *sendCodeBtn;
@property (nonatomic, strong) UIButton *clearBtn;
@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UIImageView *phoneImageV;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *nextUnBtn;
@property (nonatomic, strong) UIButton *passLoginBtn;
@property (nonatomic, strong) UITextField *vCodeField;
@property (nonatomic, strong) UIButton *vCodeClearBtn;
@property (nonatomic, strong) UIImageView *vCodeImageV;
@property (nonatomic, strong) UIImageView *vCodeLineImageV;
@property (nonatomic, strong) YYLabel *ruleLabel;
@property (nonatomic, strong) UIImageView *bottomLineImageV;
@property (nonatomic, strong) UILabel *wayLabel;
@property (nonatomic, strong) UIButton *wechatBtn;

@end

@implementation LoginCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (self.fromeType == 1) {
        LoginPassVC *vc = [[LoginPassVC alloc] init];
        vc.phoneStr = self.phoneStr;
        [self.navigationController pushViewController:vc animated:NO];
    }
    
    // Do any additional setup after loading the view.
}

#pragma mark 返回按钮点击事件
- (void)closeBtnClick{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark 发送验证码按钮点击事件
- (void)sendCodeBtnClick{
    
    if (self.phoneStr) {
        [self.phoneField resignFirstResponder];
        VerifycodeVC *verifycodeVC = [[VerifycodeVC alloc] init];
        @weakify(self);
        verifycodeVC.verifycodeDismiss = ^(NSDictionary * _Nonnull dic) {
            @strongify(self);
            [self getVeriftCodeData:dic];
        };
        [getKeyWindow() addSubview:verifycodeVC.view];
        
    }else{
        
        [MBProgressHUD showMessageInWindow:@"请输入您的手机号"];
    }
}
-(void)getVeriftCodeData:(NSDictionary *)dic{
    NSString *phone = [NSString stringWithFormat:@"%@",self.phoneStr];
    NSString *ticket = [NSString stringWithFormat:@"%@",dic[@"ticket"]];
    NSString *randstr = [NSString stringWithFormat:@"%@",dic[@"randstr"]];
    
    NSDictionary * getDic=@{
        @"phone": phone,
        @"ticket":ticket,
        @"randstr":randstr,
        @"Content-Type":@"application/json"
        
    };
    @weakify(self);
   
    NSMutableDictionary *codeDic= [NSMutableDictionary dictionaryWithDictionary:getDic ];
    [HttpTool postRequestWithUrl:@"/send-verify-code"
                          Params:codeDic
                         success:^(id returnData) {
        @strongify(self);
        [self begainTimerCountDown];
        
    } error:^(NSString *error, NSInteger errorCode) {
        
    }];
    
    
    
}
#pragma mark 清除按钮点击事件
- (void)clearBtnClick:(UIButton*)btn{
    if (btn.tag-ClearTag ==1) {
        self.phoneStr = @"";
        self.phoneField.text = @"";
        self.clearBtn.hidden = YES;
    }else{
        self.codeStr = @"";
        self.vCodeField.text = @"";
        self.vCodeClearBtn.hidden = YES;
    }
    self.inteIndex = 0;
    self.nextBtn.hidden = YES;
    self.nextUnBtn.hidden = NO;
}

#pragma mark 登录按钮点击事件
- (void)nextBtnClick{
    
    if (self.phoneStr.length < 11) {
        
        [MBProgressHUD showMessageInWindow:@"请输入手机号"];
        return;
    }
    
    
    if (self.codeStr.length < 6) {
        
        [MBProgressHUD showMessageInWindow:@"请输入验证码"];
        return;
    }
    
    NSString *phone = [NSString stringWithFormat:@"%@",self.phoneStr];
    
    NSInteger code = [self.codeStr  integerValue];
    
    NSDictionary * getDic=@{
        @"phone": phone,
        @"code": self.codeStr
    };
    @weakify(self);
    
    NSMutableDictionary *codeDic= [NSMutableDictionary dictionaryWithDictionary:getDic ];
    [HttpTool postRequestWithUrl:@"/app/login"
                          Params:codeDic
                         success:^(id returnData) {
        
        @strongify(self);
        NSDictionary *returnDic =returnData[@"data"];
        NSString *token =FormatString(returnDic[@"token"]);
        [Utility saveUserToken:token];
        [self upInfoData];
    } error:^(NSString *error, NSInteger errorCode) {
        [MBProgressHUD showMessageInWindow:error];
    }];
    
}
#pragma mark 上传设备信息
-(void)upInfoData{
    
    NSString *system_version = [[UIDevice currentDevice] systemVersion];
    NSDictionary *infoDic = [[NSBundle mainBundle]infoDictionary];
    NSString *device_version = [infoDic objectForKey:@"CFBundleShortVersionString"];
    // 重新安装的时候会变
    NSString * uuid =[FCUUID uuidForInstallation];
    NSDictionary *token =@{
        @"uuid":uuid,
        @"app_version":device_version,
        @"device_name": @"ios",
        @"system_version": system_version,
        
    };
    NSLog(@"字典%@",token);
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:token ];
    @weakify(self);
    [HttpTool postRequestWithUrl:@"/app/report/device_info"
                          Params:newdic
                         success:^(id returnData) {
        
        @strongify(self);
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    } error:^(NSString *error, NSInteger errorCode) {
        
        
        
    }] ;
    
}
#pragma mark 微信登录按钮点击事件
- (void)wechatBtnClick{
    [MBProgressHUD showMessageInWindow:@"微信登录按钮"];
}
#pragma mark 开始倒计时
- (void)begainTimerCountDown {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    
    NSTimeInterval seconds = 60;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds];
    
    dispatch_source_set_event_handler(_timer, ^{
        
        int interval = [endTime timeIntervalSinceNow];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (interval > 0) {
                self.sendCodeBtn.enabled = NO;
                [self.sendCodeBtn setTitleColor:Color_MainGray forState:UIControlStateNormal];
                self.sendCodeBtn.backgroundColor= Color_Separator;
                [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%ds",interval] forState:UIControlStateNormal];
            }else {
                self.sendCodeBtn.enabled = YES;
                [self.sendCodeBtn setTitleColor:Color_MainRed forState:UIControlStateNormal];
                self.sendCodeBtn.backgroundColor= Color_Whitle;
                [self.sendCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                
                dispatch_source_cancel(_timer);
            }
        });
    });
    
    dispatch_resume(_timer);
}

#pragma mark 账号密码登录按钮点击事件
- (void)passLoginBtnClick{
    
    LoginPassVC *vc = [[LoginPassVC alloc] init];
    vc.phoneStr = self.phoneStr;
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.tag-TextFiledTag==1) {
        
        
        if (textField.text.length >= 11 ) {//输入完成
            textField.text = [textField.text substringToIndex:11];
            self.phoneStr =textField.text;
            
        }else{
            
        }
        
        if ([NSString stringIsEmpty:textField.text]) {
            self.clearBtn.hidden = YES;
        }else{
            self.clearBtn.hidden = NO;
        }
        
    }else{
        
        if (textField.text.length >= 6 ) {//输入完成
            textField.text = [textField.text substringToIndex:6];
            self.codeStr =textField.text;
            
        }else{
            
        }
        
        if ([NSString stringIsEmpty:textField.text]) {
            self.vCodeClearBtn.hidden = YES;
        }else{
            self.vCodeClearBtn.hidden = NO;
        }
        
    }
    
    
    if (self.phoneStr.length>0&&self.codeStr.length>0) {
        self.nextBtn.hidden = NO;
        self.nextUnBtn.hidden = YES;
    }else{
        self.nextBtn.hidden = YES;
        self.nextUnBtn.hidden = NO;
    }
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
}
#pragma mark - 页面布局
- (void)initWithMainUI{
    [super initWithMainUI];
    
    
    [self.view addSubview:self.headImageV];
    [self.view addSubview:self.closeBtn];
    [self.view addSubview:self.whiteCornerView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.subTitleLabel];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.clearBtn];
    [self.view addSubview:self.lineImageV];
    [self.view addSubview:self.nextBtn];
    [self.view addSubview:self.nextUnBtn];
    [self.view addSubview:self.vCodeField];
    [self.view addSubview:self.vCodeClearBtn];
    [self.view addSubview:self.vCodeImageV];
    [self.view addSubview:self.vCodeLineImageV];
    [self.view addSubview:self.passLoginBtn];
    [self.view addSubview:self.ruleLabel];
    [self.view addSubview:self.bottomLineImageV];
    [self.view addSubview:self.wayLabel];
    [self.view addSubview:self.wechatBtn];
    
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(kScreen_Width*208/375);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(20-10);
        make.top.mas_equalTo(kStatusBarHeight+10);
        make.size.mas_equalTo(CGSizeMake(44, 44));//24*24
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(kTopHeight+30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(27);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(30);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(9);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(17);
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(35);
        make.top.equalTo(self.subTitleLabel.mas_bottom).with.offset(20);
        make.right.mas_equalTo(-35+15/2-30);
        make.height.mas_equalTo(35);
    }];
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));//16*16
        make.centerY.equalTo(self.phoneField);
        make.left.equalTo(self.phoneField.mas_right).with.offset(15/2);
        
    }];
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(30);
        make.top.equalTo(self.phoneField.mas_bottom).with.offset(1);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.vCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(35);
        make.top.equalTo(self.lineImageV.mas_bottom).with.offset(43);
        make.right.mas_equalTo(-30-90-25-30+15/2);
        make.height.mas_equalTo(35);
    }];
    
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.vCodeField);
        make.size.mas_equalTo(CGSizeMake(90, 28));//16*16
        make.right.mas_equalTo(-30);
    }];
    
    [self.vCodeClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(30, 30));//16*16
        make.centerY.equalTo(self.sendCodeBtn);
        make.right.equalTo(self.sendCodeBtn.mas_left).with.offset(-25);
    }];
    
    [self.vCodeLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(30);
        make.top.equalTo(self.vCodeField.mas_bottom).with.offset(1);
        make.right.equalTo(self.sendCodeBtn.mas_left).with.offset(-20);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.top.equalTo(self.vCodeLineImageV.mas_bottom).with.offset(20);
        make.height.mas_equalTo(17);
    }];
    
    [self.bottomLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(25);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-140-kBottomHeight+20);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.wayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.bottomLineImageV);
        make.centerX.equalTo(self.bottomLineImageV);
        make.width.mas_equalTo(92);
        make.height.mas_equalTo(17);
    }];
    
    [self.wayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.bottomLineImageV);
        make.centerX.equalTo(self.bottomLineImageV);
        make.width.mas_equalTo(92);
        make.height.mas_equalTo(17);
    }];
    
    [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.bottomLineImageV);
        make.top.equalTo(self.wayLabel.mas_bottom).offset(34);
        make.size.mas_equalTo(CGSizeMake(47, 47));//24*24
    }];
    
    
}

#pragma mark - 懒加载
/*
 * creat closeBtn
 */
- (UIButton *)closeBtn{
    
    if (!_closeBtn) {
        _closeBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"login_Close"];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _closeBtn;
}

/*
 * creat titleLabel
 */
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        _titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_22] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"登录/注册"];
    }
    
    return _titleLabel;
}

/*
 * creat subTitleLabel
 */
- (UILabel *)subTitleLabel{
    
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:Color_MainGray textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"未注册过的手机号码将自动注册"];
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
        _phoneField.placeholder = @"请输入您的手机号";
        _phoneField.tag =TextFiledTag+1;
        _phoneField.textColor = Color_MainBlack;
        _phoneField.font = [UIFont M_PingFang_RegularOfSize:Font_15];;
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
 * creat sendCodeBtn
 */
- (UIButton *)sendCodeBtn{
    
    if (!_sendCodeBtn) {
        _sendCodeBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainRed font:[UIFont M_PingFang_RegularOfSize:Font_13] backgroundColor:[UIColor whiteColor] title:@"获取验证码"];
        _sendCodeBtn.layer.cornerRadius = 28/2;
        _sendCodeBtn.layer.borderWidth = 1;
        _sendCodeBtn.layer.borderColor = [Color_Separator CGColor];
        _sendCodeBtn.backgroundColor = Color_Whitle;
        [_sendCodeBtn addTarget:self action:@selector(sendCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _sendCodeBtn;
}

/*
 * creat clearBtn
 */
- (UIButton *)clearBtn{
    
    if (!_clearBtn) {
        _clearBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"login_Clear"];
        [_clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _clearBtn.tag = ClearTag +1;
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
        _phoneImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"L_phone_img"];
    }
    
    return _phoneImageV;
}

/*
 * creat
 */
- (UITextField *)vCodeField{
    
    if (!_vCodeField) {
        _vCodeField = [[UITextField alloc] initWithFrame:CGRectZero];
        _vCodeField.delegate = self;
        _vCodeField.text = @"";
        _vCodeField.placeholder = @"请输入验证码";
        _vCodeField.textColor = Color_MainBlack;
        _vCodeField.font = [UIFont M_PingFang_RegularOfSize:Font_15];;
        _vCodeField.textAlignment = NSTextAlignmentLeft;
        _vCodeField.returnKeyType = UIReturnKeyDone;
        _vCodeField.keyboardType = UIKeyboardTypeNumberPad;
        _vCodeField.clearButtonMode = UITextFieldViewModeNever;
        _vCodeField.backgroundColor = [UIColor whiteColor];
        [_vCodeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _vCodeField;
}
/*
 * creat clearBtn
 */
- (UIButton *)vCodeClearBtn{
    
    if (!_vCodeClearBtn) {
        _vCodeClearBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"login_Clear"];
        [_vCodeClearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _vCodeClearBtn.hidden = YES;
        _vCodeClearBtn.backgroundColor = [UIColor whiteColor];
    }
    
    return _vCodeClearBtn;
}


/*
 * creat phoneImageV
 */
- (UIImageView *)vCodeImageV{
    
    if (!_vCodeImageV) {
        _vCodeImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"L_code_img"];
    }
    
    return _vCodeImageV;
}
/*
 * creat vCodeLineImageV
 */
- (UIImageView *)vCodeLineImageV{
    
    if (!_vCodeLineImageV) {
        _vCodeLineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
        _vCodeLineImageV.backgroundColor = Color_Separator;
    }
    
    return _vCodeLineImageV;
}

/*
 * creat nextBtn
 */
- (UIButton *)nextBtn{
    
    if (!_nextBtn) {
        _nextBtn = [UIButton createButtonWithFrame:CGRectMake(60, 359+kStatusBarHeight, kScreen_Width-2*60, 45) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainRed title:@"登录"];
        ViewShadow(_nextBtn, Color_MainRed, CGSizeMake(0, 2), 6, 0.3);
        _nextBtn.layer.cornerRadius = 45.0/2;
        [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.hidden = YES;
        
        NSArray *colorArray = @[(id)[rgba(239, 69, 2, 1) CGColor],
                                (id)[rgba(255, 107, 48, 1) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.nextBtn.bounds), CGRectGetHeight(self.nextBtn.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:45.0/2];
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
        _nextUnBtn = [UIButton createButtonWithFrame:CGRectMake(60, 359+kStatusBarHeight, kScreen_Width-2*60, 45) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainRed title:@"登录"];
        ViewShadow(_nextUnBtn, Color_MainRed, CGSizeMake(0, 2), 6, 0.3);
        _nextUnBtn.layer.cornerRadius = 45.0/2;
        [_nextUnBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _nextUnBtn.hidden = NO;
        _nextUnBtn.alpha = 0.5;
        NSArray *colorArray = @[(id)[rgba(239, 69, 2, 1) CGColor],
                                (id)[rgba(255, 107, 48, 1) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.nextUnBtn.bounds), CGRectGetHeight(self.nextUnBtn.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:45.0/2];
        [_nextUnBtn.layer addSublayer:nextBtnLayer];
        [_nextUnBtn.layer insertSublayer:nextBtnLayer atIndex:0];
    }
    
    return _nextUnBtn;
}

/*
 * creat passLoginBtn
 */
- (UIButton *)passLoginBtn{
    
    if (!_passLoginBtn) {
        _passLoginBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainGray font:[UIFont M_PingFang_MediumOfSize:Font_16] backgroundColor:[UIColor whiteColor] title:@"账号密码登录"];
        [_passLoginBtn addTarget:self action:@selector(passLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _passLoginBtn;
}


/*
 * creat
 */
- (YYLabel *)ruleLabel{
    
    if (!_ruleLabel) {
        
        NSString *contentStr = @"登录即表示同意《用户协议》和《隐私协议》";
        
        _ruleLabel = [YYLabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@""];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
        attributedStr.yy_font = [UIFont M_PingFang_RegularOfSize:Font_12];
        attributedStr.yy_color = Color_MainGray;
        attributedStr.yy_alignment = NSTextAlignmentLeft;
        
        @weakify(self);
        NSRange range = NSMakeRange(7, 6);
        [attributedStr yy_setTextHighlightRange:range color:Color_MainRed backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            @strongify(self);
            
            BaseWKWebView *vc = [[BaseWKWebView alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
        
        NSRange range0 = NSMakeRange(14, 6);
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
 * creat bottomLineImageV
 */
- (UIImageView *)bottomLineImageV{
    
    if (!_bottomLineImageV) {
        _bottomLineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
        _bottomLineImageV.backgroundColor = Color_Separator;
    }
    
    return _bottomLineImageV;
}
/*
 * creat subTitleLabel
 */
- (UILabel *)wayLabel{
    
    if (!_wayLabel) {
        _wayLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:Color_MainGray textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@"其它方式登录"];
    }
    
    return _wayLabel;
}

/*
 * creat wechatBtn
 */
- (UIButton *)wechatBtn{
    
    if (!_wechatBtn) {
        _wechatBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"login_Wechat"];
        [_wechatBtn addTarget:self action:@selector(wechatBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _wechatBtn.backgroundColor = [UIColor clearColor];
    }
    
    return _wechatBtn;
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
