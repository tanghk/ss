//
//  ConnectUsModel.h
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, ConnectUsType){
    
    ConnectUsType_WeChat,
    ConnectUsType_Email,
    ConnectUsType_Phone,

};


typedef NS_ENUM(NSInteger, AddressType){
    
    AddressType_Beijing,
    AddressType_Shanghai,
    AddressType_Hangzhou,

};
@interface ConnectUsModel : BaseModel
@property (nonatomic, strong) NSString *iconImageStr;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *conStr;
@property (nonatomic, assign) ConnectUsType connectUsType;
@property (nonatomic, assign) AddressType  addressType;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *tel;

+ (NSMutableArray *)getWithConnectUsData;
+ (NSMutableArray *)getWithAddressData;

@end

NS_ASSUME_NONNULL_END
