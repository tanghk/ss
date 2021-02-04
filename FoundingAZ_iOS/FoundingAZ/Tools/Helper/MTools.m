//
//  MTool.m
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//


#import "MTools.h"
//#import "PopoverView.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"
#import "NSData+ImageContentType.h"

@implementation MTools


#pragma mark - 参数字典转换请求参数
+(NSString *)parseDictionaryToFormattedString:(NSDictionary *)dic
{
    NSMutableArray *tempArray = [NSMutableArray array];
    NSArray *keyArray = [[dic allKeys] sortedArrayUsingSelector:@selector(compare:)];
    for (NSString *key in keyArray) {
        NSString *valueString = [dic objectForKey:key];
        NSString *formattedString = [NSString stringWithFormat:@"%@=%@", key, valueString];
        [tempArray addObject:formattedString];
    }
    NSString *finalString = [tempArray componentsJoinedByString:@"&"];
    return finalString;
}

#pragma mark - 将a=1&b=2&c=3 格式字符串转换成字典

+ (NSDictionary*)dictionaryFromQuery:(NSString*)query usingEncoding:(NSStringEncoding)encoding {
    
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    
    NSScanner* scanner = [[NSScanner alloc]initWithString:query];
    
    while(![scanner isAtEnd]) {
        
        NSString* pairString =nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
        
        if(kvPair.count==2) {
            NSString* key = [[kvPair objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:encoding];
            [pairs setObject:value forKey:key];
        }
    }
    return[NSDictionary dictionaryWithDictionary:pairs];
}

#pragma mark - 字典转json字符串
+(NSString *)parseToJsonString:(id)jsonObject{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

#pragma mark - 解析json字符串
+(NSDictionary *)dictionaryWithString:(NSString *)string{
    
    if (string == nil) {
        
        return nil;
        
    }
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    ;
    return dic;
}

+(NSArray *)arrayWithJsonString:(NSString *)string{
    if (string == nil) {
        
        return nil;
        
    }
    NSData *jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    
    return array;
}

#pragma mark -  创建Label

+(UILabel *)creatLblWithFont:(UIFont *)font TextColor:(UIColor *)textColor{
    UILabel * lbl=[UILabel new];
    lbl.textColor=textColor;
    lbl.font=font;
    lbl.textAlignment=NSTextAlignmentLeft;
    return lbl;
}


/*
 方法:网络图片转换为图片对象
 */
+ (UIImage *)getImageFromUrl:(NSString *)imgUrl{
    
    NSData * data = [NSData dataWithContentsOfURL:kURL(imgUrl) options:0 error:nil];
    
    UIImage *result = [UIImage imageWithData:data];
    
    return result;
}

#pragma mark - 创建UIButton

+(UIButton *)createButtonWithTitle:(NSString *)title Font:(UIFont *)font TitleColor:(UIColor *)titleColor{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    
    return button;
}

+(UIButton *)createButtonWithImage:(UIImage *)image{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

#pragma mark - 创建颜色View
+(UIView *)createViewWithColor:(UIColor *)color{
    UIView *view = [UIView new];
    view.backgroundColor = color;
    
    return view;
}

#pragma mark - 绘制虚线

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

//首页更改新春色新增的方法
+(UIButton *)createGradentNewButtonWithTitle:(NSString *)title Font:(UIFont *)font TitleColor:(UIColor *)titleColor frame:(CGRect)frame{
    
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    [button setGradientLayerStartColor:kColorFromHex(@"#FF7740") endColor:kColorFromHex(@"#FF0000") cornerRadius:0];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
//    [button setBackgroundImage:kImage(@"button_bg_highlighted") forState:UIControlStateHighlighted];
    return button;
}
@end
