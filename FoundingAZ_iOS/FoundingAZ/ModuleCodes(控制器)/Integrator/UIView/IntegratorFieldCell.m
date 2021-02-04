//
//  IntegratorFieldCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/24.
//

#import "IntegratorFieldCell.h"
#import "IntegrEnterModel.h"

@interface IntegratorFieldCell ()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *lineImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *conField;

@property (nonatomic, strong) IntegrEnterModel *tModel;

@end

@implementation IntegratorFieldCell

- (void)configSubView{
    
    UIImageView *lineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    lineImageV.backgroundColor = Color_Separator;
    [self addSubview:lineImageV];
    self.lineImageV = lineImageV;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:16.0] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@""];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UITextField *conField = [[UITextField alloc] initWithFrame:CGRectZero];
    conField.delegate = self;
    conField.text = @"";
    conField.placeholder = @"";
    conField.textColor = Color_MainBlack;
    conField.font = [UIFont M_PingFang_RegularOfSize:16.0];;
    conField.textAlignment = NSTextAlignmentLeft;
    conField.returnKeyType = UIReturnKeyDone;
    conField.keyboardType = UIKeyboardTypeDefault;
    conField.clearButtonMode = UITextFieldViewModeWhileEditing;
    conField.backgroundColor = [UIColor whiteColor];
    [self addSubview:conField];
    self.conField = conField;
    
    [conField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)layout{
    
    [self.lineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
        make.width.mas_equalTo(64);
    }];
    
    [self.conField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.titleLabel.mas_right).with.offset(24);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
        make.right.mas_equalTo(-16);
    }];
}

- (void)configureCellWithModel:(IntegrEnterModel *)contentModel{
    
    self.tModel = contentModel;
    
    self.titleLabel.text = contentModel.title;
    
    self.conField.attributedPlaceholder=[[NSAttributedString alloc]initWithString:contentModel.placeHolderStr attributes:@{NSForegroundColorAttributeName:Color_MainGray_one,NSFontAttributeName:self.conField.font}];
    self.conField.placeholder = contentModel.placeHolderStr;
    self.conField.text = contentModel.conStr;
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField{
    
    if (textField.markedTextRange) {
        return;
    }
    
    self.tModel.conStr = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.conField resignFirstResponder];
    
    return YES;
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
