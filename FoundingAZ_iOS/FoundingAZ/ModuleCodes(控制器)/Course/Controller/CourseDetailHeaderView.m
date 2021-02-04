//
//  CourseDetailHeaderView.m
//  FoundingAZ
//
//  Created by mark on 2021/2/3.
//


@interface CourseDetailHeaderView ()

@property (nonatomic, strong) UIImageView *groudImageV;
@property (nonatomic, strong) UIImageView *headImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *saleLabel;
@property (nonatomic, strong) UIImageView *hLineImageV;

@end

@implementation CourseDetailHeaderView

- (void)configSubView{
    
    self.backgroundColor = Color_Whitle;
    
    
    UIImageView *headImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"Mine_Header"];
    ViewRadius(headImageV, 35.0);
    
    [self addSubview:headImageV];
    self.headImageV = headImageV;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_17] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor clearColor] text:@"组织创新，企业决策者的第一工程速认为问巍峨很尴尬热热热速度"];
    titleLabel.numberOfLines = 0;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    [self addSubview:self.desLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.saleLabel];
    UIImageView *hLineImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@""];
    hLineImageV.backgroundColor = Color_MainGroud;
    [self addSubview:hLineImageV];
    self.hLineImageV = hLineImageV;
    
    
}

- (void)layout{
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(kScreen_Width, kScreen_Width*211/375));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self.headImageV.mas_bottom).offset(15);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(9);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self.desLabel.mas_bottom).offset(9);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).with.offset(15);
        make.height.mas_equalTo(17);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(9);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.height.mas_equalTo(17);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(9);
    }];
    
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.moneyLabel.mas_left).with.offset(-20);
        make.height.mas_equalTo(17);
        make.top.equalTo(self.dateLabel.mas_bottom).offset(9);
    }];
    
    [self.hLineImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(10);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}
-(UILabel *)desLabel{
    if (!_desLabel) {
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"以企业经营的人、才、务为内容主线，40小时+的课程，从战略、文化到财务、资本、股权设计等方面全方位的介绍课程速度速度速度速度。"attributes: @{NSFontAttributeName: [UIFont M_PingFang_RegularOfSize:14],NSForegroundColorAttributeName:Color_Font    }];
        label.attributedText = string;
        label.textAlignment = NSTextAlignmentLeft;
        label.alpha = 1.0;
        _desLabel = label;
    }
    return  _desLabel;
}

-(UILabel *)dateLabel{
    if (!_dateLabel) {
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"课程有效期：2020.11.22 — 2020.12.22"attributes: @{NSFontAttributeName: [UIFont M_PingFang_RegularOfSize:13],NSForegroundColorAttributeName: Color_MainGray}];
        label.attributedText = string;
        label.textAlignment = NSTextAlignmentLeft;
        label.alpha = 1.0;
        _dateLabel = label;
    }
    return  _dateLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        NSString *string  =  @"已更新193期  |  7890人已购";
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:string attributes: @{NSFontAttributeName: [UIFont M_PingFang_RegularOfSize:13],NSForegroundColorAttributeName:Color_MainGray}];
        label.attributedText = mutableString;
        label.textAlignment = NSTextAlignmentLeft;
        label.alpha = 1.0;
        _countLabel = label;
    }
    return  _countLabel;
    
}


- (UILabel *)moneyLabel{
    
    if (!_moneyLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        NSString *string  =  @"¥9.90";
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:string attributes: @{NSFontAttributeName: [UIFont M_PingFang_RegularOfSize:17],NSForegroundColorAttributeName:Color_CourseRed}];
        [mutableString addAttribute:NSFontAttributeName value:[UIFont M_PingFang_RegularOfSize:11] range:NSMakeRange(0,1)];
    
        label.attributedText = mutableString;
        label.textAlignment = NSTextAlignmentRight;
        label.alpha = 1.0;
        _moneyLabel = label;
    
    }
    
    return _moneyLabel;
}

-(UILabel *)saleLabel{
    if (!_saleLabel) {
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        NSString *string  =  @"¥18.90";
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc] initWithString:string attributes: @{NSFontAttributeName: [UIFont M_PingFang_RegularOfSize:17],NSForegroundColorAttributeName:Color_MainGray,NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]}];
        [mutableString addAttribute:NSFontAttributeName value:[UIFont M_PingFang_RegularOfSize:11] range:NSMakeRange(0,1)];
    
       
        label.attributedText = mutableString;
        label.textAlignment = NSTextAlignmentRight;
        label.alpha = 1.0;
        _saleLabel = label;
    }
    return  _saleLabel;
    
}



- (void)configureViewWithModel:(id)contentModel{
    
    
    
    
}


@end
