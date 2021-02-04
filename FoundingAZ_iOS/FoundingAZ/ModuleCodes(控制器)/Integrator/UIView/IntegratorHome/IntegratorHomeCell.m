//
//  IntegratorHomeCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "IntegratorHomeCell.h"

@interface IntegratorHomeCell ()

@property (nonatomic, strong) UIImageView *conImageV;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation IntegratorHomeCell

- (void)configSubView{
        
    UIImageView *conImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"case_place"];
    conImageV.backgroundColor = [UIColor whiteColor];
    ViewRadius(conImageV, 4.0);
    [self addSubview:conImageV];
    self.conImageV = conImageV;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_14] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@"海天注塑机在汽车外壳"];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)layout{
    
    [self.conImageV mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(12);
        make.bottom.mas_equalTo(-20-8);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)configureCellWithModel:(id)contentModel{
    
    
}

@end
