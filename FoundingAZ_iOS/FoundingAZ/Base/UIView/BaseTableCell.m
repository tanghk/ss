//
//  BaseTableCell.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/22.
//

#import "BaseTableCell.h"

@implementation BaseTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self configSubView];
        [self layout];
    }
    return self;
}

#pragma mark 添加子视图
- (void)configSubView{}

#pragma mark 布局子视图
- (void)layout{}

#pragma mark 赋值
- (void)configureCellWithModel:(id)contentModel{}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
