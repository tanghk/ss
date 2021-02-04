//
//  CourseListCell.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "CourseListCell.h"
@interface CourseListCell ()
@property (nonatomic, strong) UIImageView *iconImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation CourseListCell


- (void)configSubView{
    
    self.backgroundColor = Color_MainGroud;
    
    
    UIImageView *iconImageV = [[UIImageView alloc] init];
    iconImageV.frame = CGRectMake(15,169,120,90);
    [UIImage imageNamed:@"71600055497_.pic.png"];
    iconImageV.backgroundColor = [UIColor randomColor];
    [self.contentView addSubview:iconImageV];
    self.iconImageV =iconImageV;
    
  
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    [self addSubview:label];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"组织创新学企业决策者的企的说三道四的"attributes: @{NSFontAttributeName: [UIFont M_PingFang_MediumOfSize:Font_15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    label.attributedText = string;
    label.textAlignment = NSTextAlignmentLeft;
    label.alpha = 1.0;
    self.titleLabel = label;
    
    
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(145,220,195,16);
    timeLabel.numberOfLines = 0;
    NSMutableAttributedString *time = [[NSMutableAttributedString alloc] initWithString:@"课程有效期：2020.12.12-2021.12.11"attributes: @{NSFontAttributeName: [UIFont M_PingFang_RegularOfSize:Font_12],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];

    timeLabel.attributedText = time;
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.alpha = 1.0;
    [self.contentView addSubview:timeLabel];
    self.timeLabel =timeLabel;
    
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.numberOfLines = 0;

    NSMutableAttributedString *count = [[NSMutableAttributedString alloc] initWithString:@"648家企业在学"attributes: @{NSFontAttributeName: [UIFont M_PingFang_RegularOfSize:Font_12],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];

    countLabel.attributedText = count;
    countLabel.textAlignment = NSTextAlignmentLeft;
    countLabel.alpha = 1.0;

    [self.contentView addSubview:countLabel];

    self.countLabel = countLabel;

}

- (void)layout{
    
    [ self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(120, 90));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).with.offset(10);
        make.top.mas_equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).with.offset(10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(7);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.mas_equalTo(16);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).with.offset(10);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(7);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.height.mas_equalTo(16);
    }];
}

- (void)configureCellWithModel:(id)contentModel{
    
    
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
