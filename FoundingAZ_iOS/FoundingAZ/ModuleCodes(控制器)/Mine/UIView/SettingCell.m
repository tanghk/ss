//
//  SettingCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "SettingCell.h"
#import "SettingModel.h"

@interface SettingCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageV;

@end

@implementation SettingCell

- (void)configSubView{
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_16] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@""];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *arrowImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"G_arrow_right"];
    [self addSubview:arrowImageV];
    self.arrowImageV = arrowImageV;
}

- (void)layout{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16-18-10);
        make.top.bottom.mas_equalTo(0);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.mas_equalTo(-16);
    }];
}

- (void)configureCellWithModel:(SettingModel *)contentModel{
    
    self.titleLabel.text = contentModel.title;
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
