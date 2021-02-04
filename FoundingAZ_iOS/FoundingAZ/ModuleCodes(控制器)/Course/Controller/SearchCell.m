//
//  SearchCell.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "SearchCell.h"

@interface SearchCell()

@property (weak, nonatomic) UILabel *titleLabel;

@end
@implementation SearchCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self changeStyleWith:NO];
    }
    return self;
}

- (void)configUI {
    UILabel *label = [UILabel new];
    label.font = [UIFont M_PingFang_RegularOfSize:Font_13];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];
    self.titleLabel = label;
    
    self.layer.cornerRadius = 15;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
}

- (void)changeStyleWith:(BOOL)heightLight {
    self.backgroundColor = heightLight ? [UIColor colorWithHexString:@"#00BC71" alpha:0.1] : [UIColor colorWithHexString:@"F7F7F7" alpha:1];
    self.titleLabel.textColor = heightLight ? [UIColor colorWithHexString:@"#00BC71" alpha:1] : [UIColor colorWithHexString:@"494949" alpha:1];
}

- (void)setHeightLight:(BOOL)heightLight {
    _heightLight = heightLight;
    [self changeStyleWith:heightLight];
}

- (void)setTitle:(NSString *)title {
    _title = title.copy;
    self.titleLabel.text = title;
}

@end
