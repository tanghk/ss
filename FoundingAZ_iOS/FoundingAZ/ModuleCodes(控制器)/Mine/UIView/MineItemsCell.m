//
//  MineItemsCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "MineItemsCell.h"

@interface MineItemsCell ()

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MineItemsCell

- (void)configSubView{
    UIImageView *iconImageView =[UIImageView createImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_13] textColor:Color_MainGray textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] text:@"发布需求"];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)layout{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(22);
        make.height.mas_equalTo(22);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom).with.offset(6);
        make.height.mas_equalTo(18);
    }];
}
-(void)configureCellWithModel:(MineModel *)contentModel{

    self.titleLabel.text = FormatString(contentModel.title);
    self.iconImageView.image =kImage(contentModel.iconImageStr);
}

@end
