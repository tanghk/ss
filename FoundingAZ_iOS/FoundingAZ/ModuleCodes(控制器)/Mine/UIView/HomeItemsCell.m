//
//  HomeItemsCell.m
//  FoundingAZ
//
//  Created by mark on 2021/1/27.
//

#import "HomeItemsCell.h"

@interface HomeItemsCell ()

@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end
@implementation HomeItemsCell

- (void)configSubView{
    UIImageView *iconImageView =[UIImageView createImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
    
    iconImageView.backgroundColor = [UIColor randomColor];
    iconImageView.layer.cornerRadius = 50/2;
    iconImageView.clipsToBounds = YES;
    [self addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_14] textColor:Color_MainGray_one textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] text:@"发布需求"];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

- (void)layout{
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.top.mas_equalTo(5);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.top.equalTo(self.iconImageView.mas_bottom).with.offset(4);
        make.height.mas_equalTo(20);
    }];
}

- (void)configureCellWithModel:(id)contentModel{
    self.titleLabel.text = contentModel;
    
}

@end
