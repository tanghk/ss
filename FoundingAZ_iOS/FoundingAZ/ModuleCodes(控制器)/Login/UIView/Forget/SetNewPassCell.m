//
//  SetNewPassCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "SetNewPassCell.h"
#import "SetNewPassModel.h"

@interface SetNewPassCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *phoneImageV;
@property (nonatomic, strong) UIImageView *lineImageV;

@end

@implementation SetNewPassCell

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
    phoneField.keyboardType = UIKeyboardTypeDefault;
    phoneField.clearButtonMode = UITextFieldViewModeNever;
    phoneField.backgroundColor = [UIColor whiteColor];
    //[phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:phoneField];
    self.phoneField = phoneField;
    
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
        make.right.mas_equalTo(-25-16-30);
    }];
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(32, 32));//16*16
        make.centerY.equalTo(self.phoneField);
        make.right.mas_equalTo(-25);
    }];
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)configureCellWithModel:(SetNewPassModel *)contentModel{
    
    self.phoneImageV.image = [UIImage imageNamed:contentModel.iconImageStr];
    self.phoneField.placeholder = contentModel.placeHolderStr;
    self.phoneField.text = contentModel.conStr;
    
    //
    if ([NSString stringIsEmpty:contentModel.conStr]) {
        self.clearBtn.hidden = YES;
    }else{
        self.clearBtn.hidden = NO;
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
