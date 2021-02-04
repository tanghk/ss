//
//  CMethod.m
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//


#import "CMethod.h"
#include <stdio.h>
#include <sys/time.h>
#import "SVProgressHUD.h"

static NSDateFormatter *dateFormat;

#pragma mark - 获取当前Window

UIWindow *getKeyWindow(){
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - 判断字符串空的操作

/*
 strContent:要判断是否为空的字符串
 strReplace:如果strContent为空时的替换字符串
 */
NSString * null(NSString *strContent,NSString *strReplace){
    if (FormatString(strContent).length==0||[FormatString(strContent) isEqualToString:@"<null>"]||[FormatString(strContent) isEqual:[NSNull null]]||[FormatString(strContent) isEqualToString:@""]||[FormatString(strContent) isEqualToString:@"(null)"]||[FormatString(strContent) isEqualToString:@"null"]) {
        return strReplace;
    }else{
        return FormatString(strContent);
    }
    return strContent;

}

BOOL isNil(NSString *strContent){
    if (FormatString(strContent).length==0||[FormatString(strContent) isEqualToString:@"<null>"]||[FormatString(strContent) isEqual:[NSNull null]]||[FormatString(strContent) isEqualToString:@""]||[FormatString(strContent) isEqualToString:@"(null)"]||[FormatString(strContent) isEqualToString:@"null"]) {
        return YES;
    }else{
        return NO;
    }
    return YES;
}

#pragma mark - 请求提示框

//不带文字，一直提示，需和 dismissHUD（）一起使用
void showHUD(){
    [SVProgressHUD show];
}

void dismissHUD(){
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

//带文字提示，需和 dismissHUD（）一起使用
void showWithText(NSString* text){
    [SVProgressHUD showWithStatus:text];
}

//以下默认有显示时间，会自动消失
void showErrorTips(NSString *tips){
    [SVProgressHUD showErrorWithStatus:tips];
}

void showSuccessTips(NSString *tips){
    [SVProgressHUD showSuccessWithStatus:tips];
}

void showInfoTips(NSString *tips){
    [SVProgressHUD showInfoWithStatus:tips];
}

#pragma mark - 画线(返回一个UIView对象)

UIView * drawHLine(UIColor *color,CGRect lineFrame){
    UIView *hLine=[[UIView alloc]initWithFrame:lineFrame];
    hLine.backgroundColor=color;
    return hLine;
}

#pragma mark - 获取Label文字宽度
CGFloat getLabelTextWidth(UILabel *label){
    
    if (label) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:label.font};
        CGSize textSize=[label.text sizeWithAttributes:attributes];
        
        return ceil(textSize.width);//textSize.width + 1;//ceilf(textSize.width);
    }
    return 0;
}

#pragma mark - 获取文字的高度
CGFloat getTextHeight(NSString *content,UIFont *font,CGFloat width){
    if (content) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        //    paragraphStyle.lineSpacing=10;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize textSize=[content boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
        return ceil(textSize.height);// + 1;
    }
    //NSStringDrawingTruncatesLastVisibleLine|[content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
    return 0;
    
}
#pragma mark - 获取文字的高度带行高
CGFloat getTextHeightWithLineHeight(NSString *content,UIFont *font,CGFloat width, CGFloat lineHeight){
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    if (lineHeight != 0) {
        paragraphStyle.lineSpacing = lineHeight;
    }
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize textSize=[content boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    return ceil(textSize.height);
    
}

#pragma mark - 单行文本高度

CGFloat tHeightByFont(UIFont* font){
    if (font) {
        return [@"单行" sizeWithAttributes:@{NSFontAttributeName:font}].height + 1;
    }
    return 10;
    
}

#pragma mark - 单行文本宽度

//CGFloat tWidthByFont(CGFloat fontSize,NSString *content){
//
//   return  [content sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width + 1;
//}
CGFloat tWidthByFont(UIFont *font,NSString *content){
    return  ceilf([content sizeWithAttributes:@{NSFontAttributeName:font}].width);
}
#pragma mark - 获取2倍3倍图片尺寸适配比例

CGFloat getRealPx(CGFloat f){
    if ([UIScreen mainScreen].scale > 2.0) {
        return f * 1.5;
    }
    return f;
}

#pragma mark - NavigationBarButtonItem 间距

UIBarButtonItem *spaceButtonItem(CGFloat spaceWidth) {
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = -spaceWidth;
    
    return space;
}

#pragma mark - 返回到指定的页面

void popToViewController(Class toVC, UIViewController *currentVC,BOOL animate){
    for(UIViewController *temVC in currentVC.navigationController.viewControllers){
        if ([temVC isKindOfClass:toVC]){
            [currentVC.navigationController popToViewController:temVC animated:animate];
        }
    }
}
//返回到上级页面
void popViewController(UIViewController *currentVC,BOOL animate){
    [currentVC.navigationController popViewControllerAnimated:animate];
}

//跳转到下级页面
void pushToViewController(UIViewController *currentVC,UIViewController *toView,BOOL animate){
    [currentVC.navigationController pushViewController:toView animated:animate];
}

#pragma mark - TableViewCell 图片扩展

UIImageView *customAccessoryView(NSString *imgName, CGSize size){
    UIImageView *accessoryImage = [UIImageView new];//箭头尺寸：8*14，但是由于字体图标有白边，故用11*14。
    accessoryImage.frame = CGRectMake(0,0, size.width,size.height);
    accessoryImage.image = kImage(imgName);
    
    return accessoryImage;
}

#pragma mark - 日期格式转化
/*
 strDate:日期字符串
 format:日期格式
 */
NSDate * stringToDate(NSString *strDate,NSString *format){
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:strDate];
}

/*
 strDate:日期字符串
 format:日期格式
 toFormat:转换的日期格式
 */
NSString *FormatDateString(NSString *strDate,NSString *Format,NSString *toFormat){
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc]init];
    }
    dateFormat.dateFormat=Format;
    NSDate *date=[dateFormat dateFromString:strDate];
    
    [dateFormat setDateFormat:toFormat];
    NSString *timeStr=[dateFormat stringFromDate:date];
    
    return timeStr;
}

/*
 strFormat:日期格式
 */
NSString *FormatCurrentDate(NSString *strFormat){
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc]init];
    }
    [dateFormat setDateFormat:strFormat];
    NSString *timeStr=[dateFormat stringFromDate:[NSDate date]];
    
    return timeStr;
}

/*
 date:日期
 strFormat:日期格式
 */
NSString *FormatDate(NSDate *date,NSString *strFormat){
    if (!dateFormat) {
        dateFormat = [[NSDateFormatter alloc]init];
    }
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateFormat setDateFormat:strFormat];
    NSString *timeStr=[dateFormat stringFromDate:date];
    
    return timeStr;
}

/*
 time:时间戳
 strFormat:日期格式
 */
NSString *FormatDateTimeInterval(NSTimeInterval time,NSString *strFormat){

    NSDate *date = FormatTimeIntervalToDate(time);
        
    NSString *strDate = FormatDate(date, strFormat);
    
    return null(strDate, @"");
}

/*
 方法:时间戳转换为日期
 time:时间戳
 */
NSDate *FormatTimeIntervalToDate(NSTimeInterval time){
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time + 28800];
    
    
    return date;
}

/*
 方法:获取指定日期的前n天或后n天
 date:日期
 n:(正数表示后n天，负数表示前n天)
 */
NSDate *getLastDayByDate(NSDate *date,NSInteger n){
    NSDate *lastDay = [NSDate dateWithTimeInterval:n*24*60*60 sinceDate:date];//前一天
    return lastDay;
}

#pragma mark - 文件操作

/*
 方法:获取沙盒路径
 */
NSString *getDocumentPath(void){
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject];
    
    return path;
}

/*
 方法:获取并创建自定义文件夹路径
 */
NSString *getDirectoryPath(NSString *fileDirectory){
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileDirectory];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

/*
 方法:通过文件名获取文件路径
 superPath:上级文件夹路径
 fileName:文件名
 */
NSString *getFilePathByName(NSString *superPath,NSString *fileName){
    
   
    return [superPath stringByAppendingPathComponent:fileName];
}

/*
 方法:删除文件
 superPath:上级文件夹路径
 fileName:文件名
 */
BOOL deleteFileByName(NSString *superPath,NSString *fileName)
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //判断要删除的路径是否存在
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:getFilePathByName(superPath, fileName)];
    if (!blHave) {
        NSLog(@"不存在此路径文件");
        return NO;
    }else {
        BOOL blDele= [fileManager removeItemAtPath:getFilePathByName(superPath, fileName) error:nil];
        if (blDele) {
            NSLog(@"文件删除成功");
            return YES;
        }else {
            return NO;
        }
    }
}

/*
 方法:保存文件
 fileData:文件流
 superPath:上级文件夹路径
 fileName:文件名
 */
BOOL saveFileWithName(NSData *fileData, NSString *superPath,NSString *fileName)
{
    
    //文件是否已经存在（如果存在就删除）
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:getFilePathByName(superPath, fileName)];
    if (blHave) {
        deleteFileByName(superPath, fileName);
    }
    //写入文件是否成功
    BOOL result = [fileData writeToFile:getFilePathByName(superPath, fileName) atomically:YES];
    if (result) {
        NSLog(@"文件保存成功");
        return YES;
    }else {
        NSLog(@"文件保存失败");
        return NO;
    }
}

/*
 方法:读取保存在本地路径的图片
 superPath:上级文件夹路径
 fileName:文件名
 */
UIImage *getPhotoFileByName(NSString *superPath,NSString *fileName)
{
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:getFilePathByName(superPath, fileName)];
    if (!blHave) {
        return nil;
    }else{
        NSData *data = [NSData dataWithContentsOfFile:getFilePathByName(superPath, fileName)];
        UIImage *img = [[UIImage alloc] initWithData:data];
        return img;
    }
    return nil;
}

/*
 方法:返回文件大小
 filePath:文件路径
 */
long long fileSizeAtPath(NSString* filePath){
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/*
 方法:返回文件夹大小
 folderPath:文件夹路径
 */
float folderSizeAtPath(NSString* folderPath){
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += fileSizeAtPath(fileAbsolutePath);
    }
    return folderSize/(1024.0*1024.0);
}

#pragma mark - 获取可变属性字体

/*
 方法:向已有的可变属性字体添加新的属性
 mStrAttribute:可变属性字体
 strAttribute:添加属性的内容
 attrColor:属性颜色
 attrFontSize:属性字体大小
 */
void addAttributeString(NSMutableAttributedString *mStrAttribute,NSString *strAttribute,UIColor *attrColor,CGFloat attrFontSize){
    
    NSRange attributeRange=[mStrAttribute.string rangeOfString:strAttribute];
    if (attributeRange.location!=NSNotFound) {
        [mStrAttribute addAttribute:NSForegroundColorAttributeName value:attrColor range:NSMakeRange(attributeRange.location, attributeRange.length)];
        [mStrAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attrFontSize] range:attributeRange];
    }
}

/*
 方法:返回设置的可变属性字体
 strContent:内容
 strAttribute:添加属性的内容
 attrColor:属性颜色
 attrFontSize:属性字体大小
 */
NSMutableAttributedString * getMutableAttributeString(NSString *strContent,NSString *strAttribute,UIColor *attrColor,CGFloat attrFontSize){
    if (!isNil(strContent)) {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strContent];
        if (null(strAttribute, @"").length != 0) {
            NSRange attributeRange=[strContent rangeOfString:strAttribute];
            if (attributeRange.location!=NSNotFound) {
                [str addAttribute:NSForegroundColorAttributeName value:attrColor range:NSMakeRange(attributeRange.location, attributeRange.length)];
                [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attrFontSize] range:attributeRange];
            }
            return str;
        }
        return str;
    }
    return [[NSMutableAttributedString alloc] initWithString:@""];
}

/*
 方法:返回设置的带行高的可变属性字体
 strContent:内容
 strAttribute:添加属性的内容
 attrColor:属性颜色
 attrFontSize:属性字体大小
 lineHeight:行高
 */
NSMutableAttributedString * getMutableAttributeStringWithLineHeight(NSString *strContent,NSString *strAttribute,UIColor *attrColor,CGFloat attrFontSize, CGFloat lineHeight){
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strContent];
    
    if (lineHeight != 0) {
        NSRange attributeRange=[strContent rangeOfString:strContent];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        paragraphStyle.lineSpacing = lineHeight;
        [str addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:attributeRange];
    }
    if (null(strContent, @"").length!=0) {
        NSRange attributeRange=[strContent rangeOfString:strAttribute];
        if (attributeRange.location!=NSNotFound) {
            [str addAttribute:NSForegroundColorAttributeName value:attrColor range:NSMakeRange(attributeRange.location, attributeRange.length)];
            [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:attrFontSize] range:attributeRange];

        }
        return str;
    }
    return str;
}

/*
 方法:文字添加删除线
 strContent:文字内容
 lineColor:删除线颜色
 */
NSMutableAttributedString * getDeleteLineString(NSString *strContent,UIColor *lineColor){
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:strContent];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(1)  range:NSMakeRange(0, strContent.length)];
    [attri addAttribute:NSBaselineOffsetAttributeName value: @(0) range:NSMakeRange(0, strContent.length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:lineColor range:NSMakeRange(0, strContent.length)];
    return attri;
}

/*
 方法:返回设置行高的内容
 strContent:文字内容
 lineHeight:行高
 */
NSMutableAttributedString * getAttributeStringWithLineHeight(NSString *strContent, CGFloat lineHeight){
    if (isNil(strContent)) {
        return [@"" mutableCopy];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strContent];
    
    NSRange attributeRange=[strContent rangeOfString:strContent];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineHeight;
    [str addAttributes:@{NSParagraphStyleAttributeName:paragraphStyle} range:attributeRange];
    
    return str;
}

/*
 方法:为标签内容设置行高（必须先设置label.text，只设置一个属性内容）
 strContent:内容
 strAttribute:添加属性的内容
 attrColor:属性颜色
 attrFontSize:属性字体大小
 lineHeight:行高
 */
void setLabelAttributeString(UILabel *label,NSString *strAttribute,UIColor *attrColor,CGFloat attrFontSize){
    NSMutableAttributedString *attribute = getMutableAttributeString(label.text, strAttribute, attrColor, attrFontSize);
    label.attributedText = attribute;
}

#pragma mark - 打开网址,跳出应用

void openUrl(NSString *strUrl){
    if (!isNil(strUrl)) {
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strUrl]];
    }
}

#pragma mark - 校验身份证号

BOOL checkIdentityNumber(NSString *identityNumber){
    if (identityNumber.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityNumber]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityNumber substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityNumber substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]|| ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - 校验手机号

BOOL checkMobileValid(NSString *mobile){
    
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11){
        return NO;
    }else{

        NSString *CM_NUM = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";


        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];

        
        BOOL isMatch3 = [pred1 evaluateWithObject:mobile];

        if (isMatch3) {
            return YES;
        }else{
            return NO;
        }
    }
}


@implementation CMethod

@end
