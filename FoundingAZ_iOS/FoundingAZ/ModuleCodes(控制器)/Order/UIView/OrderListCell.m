//
//  OrderListCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "OrderListCell.h"

@interface OrderListCell ()

@property (nonatomic, strong) UIView *groudView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageV;
@property (nonatomic, strong) UILabel *stateLabel;

@end

@implementation OrderListCell

- (void)configSubView{
    
    self.backgroundColor = Color_MainGroud;
    
    UIView *groudView = [[UIView alloc] initWithFrame:CGRectZero];
    ViewRadius(groudView, 8.0);
    groudView.backgroundColor = [UIColor whiteColor];
    [self addSubview:groudView];
    self.groudView = groudView;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_16] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"六轴机器人自动化项目"];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIImageView *arrowImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"G_arrow_right"];
    [self addSubview:arrowImageV];
    self.arrowImageV = arrowImageV;
    
    UILabel *stateLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_12] textColor:Color_MainGray textAlignment:NSTextAlignmentRight backgroundColor:[UIColor whiteColor] text:@"2个报名，5个推荐"];
    [self addSubview:stateLabel];
    self.stateLabel = stateLabel;
}

- (void)layout{
    
    [self.groudView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.groudView.mas_left).with.offset(12);
        make.top.equalTo(self.groudView.mas_top).with.offset(16);
        make.height.mas_equalTo(22);
        make.right.equalTo(self.groudView.mas_right).with.offset(-160);
        make.bottom.mas_equalTo(-150);
    }];
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.titleLabel);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.right.equalTo(self.groudView.mas_right).with.offset(-12);
    }];
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.arrowImageV.mas_left);
        make.height.mas_equalTo(17);
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
