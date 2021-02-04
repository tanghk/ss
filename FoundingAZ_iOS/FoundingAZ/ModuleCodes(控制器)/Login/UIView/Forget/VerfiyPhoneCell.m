//
//  VerfiyPhoneCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "VerfiyPhoneCell.h"
#import "VerfiyPhoneModel.h"

@interface VerfiyPhoneCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *phoneImageV;
@property (nonatomic, strong) UIImageView *lineImageV;

@end

@implementation VerfiyPhoneCell

- (void)configSubView{
        
    UIImageView *phoneImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    phoneImageV.backgroundColor = [UIColor whiteColor];
    [self addSubview:phoneImageV];
    self.phoneImageV = phoneImageV;
    
    UITextField *phoneField = [[UITextField alloc] initWithFrame:CGRectZero];
    phoneField.delegate = self;
    phoneField.text = @"";
    phoneField.placeholder = @"";
    phoneField.textColor = Color_MainBlack;
    phoneField.font = [UIFont M_PingFang_RegularOfSize:Font_16];;
    phoneField.textAlignment = NSTextAlignmentLeft;
    phoneField.returnKeyType = UIReturnKeyDone;
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.clearButtonMode = UITextFieldViewModeNever;
    phoneField.backgroundColor = [UIColor whiteColor];
    //[phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:phoneField];
    self.phoneField = phoneField;
    
    UIButton *sendCodeBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainBlue font:[UIFont M_PingFang_RegularOfSize:Font_16] backgroundColor:[UIColor whiteColor] title:@"发送验证码"];
    [self addSubview:sendCodeBtn];
    self.sendCodeBtn = sendCodeBtn;
    
    UIButton *clearBtn = [UIButton createButtonWithFrame:CGRectZero normalImage:@"G_Field_clear"];
    clearBtn.hidden = YES;
    clearBtn.backgroundColor = [UIColor whiteColor];
    [self addSubview:clearBtn];
    self.clearBtn = clearBtn;
    
    UIImageView *lineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    lineImageV.backgroundColor = Color_Separator;
    [self addSubview:lineImageV];
    self.lineImageV = lineImageV;
}

- (void)layout{
    
    [self.phoneImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(25);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(24, 24));
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
        make.left.equalTo(self.phoneImageV.mas_right).with.offset(16);
        make.right.mas_equalTo(-25);
    }];
    
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.bottom.equalTo(self.phoneField);
        make.right.mas_equalTo(-25);
    }];
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(32, 32));//16*16
        make.centerY.equalTo(self.sendCodeBtn);
        make.right.equalTo(self.sendCodeBtn.mas_left).with.offset(-16+8);
    }];
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)configureCellWithModel:(VerfiyPhoneModel *)contentModel{
    
    self.phoneImageV.image = [UIImage imageNamed:contentModel.iconImageStr];
    self.phoneField.placeholder = contentModel.placeHolderStr;
    self.phoneField.text = contentModel.conStr;
    
    //
    if ([NSString stringIsEmpty:contentModel.conStr]) {
        self.clearBtn.hidden = YES;
    }else{
        self.clearBtn.hidden = NO;
    }
    
    //
    if (contentModel.VerfiyPhoneType == VerfiyPhoneType_phone){
        if (contentModel.conStr.length < 13) {
            [self.sendCodeBtn setTitleColor:Color_MainGray_one forState:UIControlStateNormal];
            self.sendCodeBtn.enabled = NO;
        }else{
            if ([self.sendCodeBtn.currentTitle isEqualToString:@"发送验证码"]) {
                [self.sendCodeBtn setTitleColor:Color_MainBlue forState:UIControlStateNormal];
                self.sendCodeBtn.enabled = YES;
            }else{
                [self.sendCodeBtn setTitleColor:Color_MainGray_one forState:UIControlStateNormal];
                self.sendCodeBtn.enabled = NO;
            }
        }
    }
    
    //
    if (contentModel.VerfiyPhoneType == VerfiyPhoneType_phone) {
        self.sendCodeBtn.hidden = NO;
        [self.phoneField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-110-16-16-20);
        }];
        [self.clearBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(32, 32));//16*16
            make.centerY.equalTo(self.sendCodeBtn);
            make.right.equalTo(self.sendCodeBtn.mas_left).with.offset(-16+8);
        }];
    }else if (contentModel.VerfiyPhoneType == VerfiyPhoneType_code){
        self.sendCodeBtn.hidden = YES;
        [self.phoneField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-25-16-40);
        }];
        [self.clearBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(32, 32));//16*16
            make.centerY.equalTo(self.phoneField);
            make.right.mas_equalTo(-25+8);
        }];
    }
}

#pragma mark 倒计时按钮赋值
- (void)setWithCodeBtnTime:(NSInteger)afterTime isExistAfterTime:(BOOL)state{
    
    if (state) {//存在倒计时
        NSString *str = [NSString stringWithFormat:@"%ld秒后重发",afterTime];
        [self.sendCodeBtn setTitle:str forState:UIControlStateNormal];
        [self.sendCodeBtn setTitleColor:Color_MainGray_one forState:UIControlStateNormal];
        self.sendCodeBtn.enabled = NO;
        
    }else{//正常状态，没有倒计时
        [self.sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self.sendCodeBtn setTitleColor:Color_MainBlue forState:UIControlStateNormal];
        self.sendCodeBtn.enabled = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
