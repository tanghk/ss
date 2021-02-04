//
//  ConnectUsCell.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "ConnectUsCell.h"
#import "ConnectUsModel.h"

@interface ConnectUsCell ()

@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) UIImageView *iconImageV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *arrowImageV;
@property (nonatomic, strong) UILabel *conLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UILabel *telLabel;

@end

@implementation ConnectUsCell

- (void)configSubView{
    
    self.backgroundColor = Color_Whitle;
    
    
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectZero];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 4;
    [self addSubview:whiteView];
    self.whiteView = whiteView;
    UIColor *color =[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.12];
    ViewShadow(self.whiteView, color, CGSizeMake(0, 0), 6, 1);
    
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_MediumOfSize:Font_15] textColor:Color_MainBlack textAlignment:NSTextAlignmentLeft backgroundColor:[UIColor whiteColor] text:@""];
    [self.whiteView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    
    UIImageView *iconImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"ConnectUs_Address"];
    [self.whiteView addSubview:iconImageV];
    self.iconImageV = iconImageV;
    
    UIImageView *arrowImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"ConnectUs_Tel"];
    [self.whiteView addSubview:arrowImageV];
    self.arrowImageV = arrowImageV;
    
    UILabel *telLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:Color_MainGray_one textAlignment:NSTextAlignmentRight backgroundColor:[UIColor whiteColor] text:@""];
    [self.whiteView addSubview:telLabel];
    self.telLabel = telLabel;
    
    
    UILabel *addressLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:Font_12] textColor:Color_MainGray_one textAlignment:NSTextAlignmentRight backgroundColor:[UIColor whiteColor] text:@""];
    
    [self.whiteView addSubview:addressLabel];
    self.addressLabel = addressLabel;
}

- (void)layout{
    
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.whiteView.mas_left).with.offset(15);
        make.top.equalTo(self.whiteView.mas_top).with.offset(15);
        make.height.mas_equalTo(22);
    }];
    
    [self.iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(11);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    
    
    [self.arrowImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(15);
        make.top.equalTo(self.iconImageV.mas_bottom).with.offset(11);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageV.mas_right).offset(5);
        make.centerY.equalTo(self.iconImageV.mas_centerY);
        make.height.mas_equalTo(17);
    }];
    
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.arrowImageV.mas_right).offset(5);
        make.centerY.equalTo(self.arrowImageV.mas_centerY);
        make.height.mas_equalTo(17);
    }];
}

- (void)configureCellWithModel:(ConnectUsModel *)contentModel withIndexPath:(NSIndexPath *)indexPath withArray:(NSArray *)array{
    
    self.titleLabel.text = contentModel.title;
    self.telLabel.text = contentModel.tel;
    self.addressLabel.text = contentModel.address;
    //    if (contentModel.mineViewType == MineViewType_university) {
    //        self.conLabel.hidden = NO;
    //        self.conLabel.text = contentModel.conStr;
    //        self.conLabel.textColor = rgba(223, 153, 118, 1);
    //    }else{
    //        self.conLabel.hidden = YES;
    //    }
    //
    //    if (indexPath.row == 0) {
    //        ViewRadius(self.topCornerView, 6.0);
    //        if (array.count == 1) {
    //            ViewRadius(self.bottomCornerView, 6.0);
    //        }else{
    //            ViewRadius(self.bottomCornerView, 0.0);
    //        }
    //    }else if(indexPath.row == array.count -1){
    //        ViewRadius(self.topCornerView, 0.0);
    //        ViewRadius(self.bottomCornerView, 6.0);
    //    }else{
    //        ViewRadius(self.topCornerView, 0.0);
    //        ViewRadius(self.bottomCornerView, 0.0);
    //    }
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

