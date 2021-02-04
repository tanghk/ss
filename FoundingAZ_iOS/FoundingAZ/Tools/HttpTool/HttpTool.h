//
//  HttpTool.h
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"


@interface HttpTool : NSObject

+(void)getRequestWithUrl:(NSString *)strUrl Params:(NSMutableDictionary *)paramDic success:(void (^)(id returnData))successBlock error:(void (^)(NSString *error,NSInteger errorCode))errorBlock;
+(void)postRequestWithUrl:(NSString *)strUrl Params:(NSMutableDictionary *)paramDic success:(void (^)(id returnData))successBlock error:(void (^)(NSString *error,NSInteger errorCode))errorBlock;

+(void)postProgressRequestWithUrl:(NSString *)strUrl Params:(NSMutableDictionary *)paramDic Progress:(void (^)(NSProgress *progress))progress success:(void (^)(id returnData))successBlock error:(void (^)(NSString *error,NSInteger errorCode))errorBlock;

+(void)uploadImageFileWithImage:(UIImage *)image RequestUrl:(NSString *)strUrl ParamDic:(NSMutableDictionary *)paramDic SuccessBlock:(void (^)(id returnData))successBlock FailBlock:(void (^)(NSString *error,NSInteger errorCode))errorBlock;




@end
