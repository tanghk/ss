//
//  HttpTool.m
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//


#import "HttpTool.h"
#import "AFNetworking.h"
#import "UIDeviceHardware.h"
#import "AFNetworkReachabilityManager.h"


@implementation HttpTool
+(void)getRequestWithUrl:(NSString *)strUrl Params:(NSMutableDictionary *)paramDic success:(void (^)(id returnData))successBlock error:(void (^)(NSString *error,NSInteger errorCode))errorBlock;{
    
    NSLog(@"网络状态 %@",@([Reachability reachabilityForInternetConnection].currentReachabilityStatus));
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus != NotReachable) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
        //设置请求超时时间
        [manager.requestSerializer setValue:@"H5" forHTTPHeaderField:@"User-Agent"];
        NSString *urlStr =[NSString stringWithFormat:@"%@%@",SERVERS_URL,strUrl];
      [paramDic setValue:@"H5" forKey:@"from"];
        NSLog(@"请求地址：%@",urlStr);
        NSLog(@"请求参数：strUrl%@-%@",strUrl,paramDic);
        [manager GET:urlStr  parameters:paramDic headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求返回数据%@----%@",strUrl,responseObject);
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                errorBlock(@"返回值不是字典",-1);
            }else{
                
                successBlock(responseObject);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            errorBlock(@"请求异常，请重试",0);
            NSLog(@"请求返回值：%@",error);
        }];
        
        
    }
}

+(void)postRequestWithUrl:(NSString *)strUrl Params:(NSMutableDictionary *)paramDic success:(void (^)(id returnData))successBlock error:(void (^)(NSString *error,NSInteger errorCode))errorBlock
{
    NSLog(@"网络状态 %@",@([Reachability reachabilityForInternetConnection].currentReachabilityStatus));
    if ([Reachability reachabilityForInternetConnection].currentReachabilityStatus != NotReachable) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSString *token =[Utility getUserToken];
        if (token.length>0) {
            
            [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"]; //请求头
            
        }
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
        //设置请求超时时间
        manager.requestSerializer.timeoutInterval=30;
        NSString *urlStr =[NSString stringWithFormat:@"%@%@",SERVERS_URL,strUrl];
        [paramDic setValue:@"APP" forKey:@"from"];
        
        
        NSLog(@"请求地址：%@",urlStr);
        NSLog(@"请求参数：%@",paramDic);
        
        
        [manager POST:urlStr  parameters:paramDic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSDictionary *dic =[self dictionaryForJsonData:responseObject];
           
            NSLog(@"请求返回值：%@",dic);
            NSLog(@"请求返回数据%@----%@",strUrl,dic);
            if (![dic isKindOfClass:[NSDictionary class]]) {
                errorBlock(@"返回值不是字典",-1);
            }else {
                NSInteger code =[dic[@"code"] integerValue];
                if (code==0) {
                    successBlock(dic);
                }else{
                    errorBlock(dic[@"message"],0);
                }
                
            }
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            errorBlock(@"请求异常，请重试",0);
            NSLog(@"请求返回值：%@",error);
        }];
        
    }else{
        dismissHUD();
        errorBlock(@"请检查当前网络是否可用！",-100);
    }
}
+ (NSDictionary *)dictionaryForJsonData:(NSData *)jsonData

{
    
    if (![jsonData isKindOfClass:[NSData class]] || jsonData.length < 1) {
        
        return nil;
        
    }
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    
    if (![jsonObj isKindOfClass:[NSDictionary class]]) {
        
        return nil;
        
    }
    
    return [NSDictionary dictionaryWithDictionary:(NSDictionary *)jsonObj];
    
}
+(void)postProgressRequestWithUrl:(NSString *)strUrl Params:(NSMutableDictionary *)paramDic Progress:(void (^)(NSProgress *progress))progress success:(void (^)(id returnData))successBlock error:(void (^)(NSString *error,NSInteger errorCode))errorBlock{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable) {
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
        //设置请求超时时间
        //        manager.requestSerializer.timeoutInterval=15;
        NSLog(@"请求地址：%@",strUrl);
        NSLog(@"请求参数：%@",paramDic);
        [manager POST:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:paramDic headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"请求返回值：%@",responseObject);
            
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                errorBlock(@"返回值不是字典",-1);
            }else if ([FormatString(responseObject[@"Status"]) isEqualToString:@"1"]) {
                
                successBlock(responseObject);
            }
            else {
                errorBlock(null(responseObject[@"Content"], @"暂无数据"),[FormatString(responseObject[@"ReturnValue"]) integerValue]);
                NSLog(@"请求失败：%@",responseObject[@"Content"]);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            errorBlock(@"请求异常，请重试",0);
            NSLog(@"请求返回值：%@",error);
        }];
    }else{
        errorBlock(@"请检查当前网络是否可用！",-2);
    }
}

+(void)uploadImageFileWithImage:(UIImage *)img RequestUrl:(NSString *)strUrl ParamDic:(NSMutableDictionary *)paramDic SuccessBlock:(void (^)(id returnData))successBlock FailBlock:(void (^)(NSString *error,NSInteger errorCode))errorBlock{
    //    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable){
    //
    //        AFHTTPSessionManager * manger=[AFHTTPSessionManager manager];
    //        manger.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",nil];
    //        manger.requestSerializer=[AFJSONRequestSerializer serializer];
    //
    //        NSLog(@"请求地址：%@",strUrl);
    //        NSLog(@"请求参数：%@",paramDic);
    //        [manger POST:strUrl parameters:paramDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
    //         {
    //             if (img!=nil) {
    //                 [formData appendPartWithFileData:UIImageJPEGRepresentation(img, 0.5) name:@"file" fileName:@"image.png" mimeType:@"image/jpeg"];
    //             }
    //
    //         } progress:^(NSProgress * _Nonnull uploadProgress) {
    //
    //         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    //             NSLog(@"请求返回值：%@",responseObject);
    //
    //             if (![responseObject isKindOfClass:[NSDictionary class]]) {
    //                 errorBlock(@"返回值不是字典",-1);
    //             }else if ([FormatString(responseObject[@"Status"]) isEqualToString:@"1"]) {
    //                 successBlock(responseObject);
    //             }else {
    //                 errorBlock(null(responseObject[@"Content"], @""),[responseObject[@"Status"] integerValue]);
    //             }
    //
    //
    //         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    //             errorBlock(@"请求异常，请重试",0);
    //             NSLog(@"请求返回值：%@",error);
    //         }];
    //    }else{
    //        errorBlock(@"请检查当前网络是否可用！",-2);
    //    }
}

@end
