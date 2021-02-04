//
//  MessageButton.m
//  iMuGou
//

#import "MessageButton.h"

@implementation MessageButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.lblNum];
        
    }
    return self;
}

-(void)setTheFrame:(CGRect)theFrame{
    
    _theFrame = theFrame;
    self.frame = theFrame;
    
    _lblNum.frame = CGRectMake(self.frameWidth - 10, -4, 10, 10);
    _lblNum.layer.cornerRadius = _lblNum.frameHeight/2;
    _lblNum.clipsToBounds = YES;
}

-(void)setNumber:(NSString *)number{
    if (isNil(number)) {
        _lblNum.hidden = YES;
    }else{
        _lblNum.hidden = NO;
        _lblNum.text = number;
        _lblNum.frameWidth = getLabelTextWidth(_lblNum) + 3;
        _lblNum.layer.cornerRadius = _lblNum.frameHeight/2;
    }
}


-(UILabel *)lblNum{
    if (!_lblNum) {
        _lblNum = [MTools creatLblWithFont:kFont(10) TextColor:kColor(whiteColor)];
        _lblNum.backgroundColor = kColor(redColor);
        _lblNum.textAlignment = NSTextAlignmentCenter;
        _lblNum.hidden = YES;
    }
    return _lblNum;
}

@end
