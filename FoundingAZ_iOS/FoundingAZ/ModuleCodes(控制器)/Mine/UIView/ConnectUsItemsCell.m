//
//  ConnectUsItemsCell.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "ConnectUsItemsCell.h"


@interface ConnectUsItemsCell ()
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *telLabel;
@end

@implementation ConnectUsItemsCell

- (void)configSubView{
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectZero];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 4;
    [self addSubview:whiteView];
    self.whiteView = whiteView;
    UIColor *color =[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.12];
    ViewShadow(self.whiteView, color, CGSizeMake(0, 0), 6, 1);

    UIImageView *iconImageView =[UIImageView createImageViewWithFrame:CGRectZero image:[UIImage imageNamed:@""]];
    [self.whiteView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_12] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] text:@"发布需求"];
    [self.whiteView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UILabel *telLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_10] textColor:Color_Font  textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor whiteColor] text:@""];
    [self.whiteView addSubview:telLabel];
    self.telLabel = telLabel;
}

- (void)layout{
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.bottom.equalTo(self).offset(0);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.whiteView);
        make.top.equalTo(self.whiteView.mas_top).with.offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.whiteView);
        make.top.equalTo(self.iconImageView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(17);
    }];
    
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.whiteView);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(4);
        make.height.mas_equalTo(14);
    }];
}
-(void)configureCellWithModel:(ConnectUsModel *)contentModel{

    self.titleLabel.text = FormatString(contentModel.title);
    self.iconImageView.image =kImage(contentModel.iconImageStr);
    self.telLabel.text = FormatString(contentModel.tel);
    
}

@end

