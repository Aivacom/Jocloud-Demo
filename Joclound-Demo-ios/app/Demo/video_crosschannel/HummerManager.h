//
//  HummerManager.h
//  AFNetworking
//
//  Created by Huan on 2020/6/14.
//

#import <Foundation/Foundation.h>
#import <Hmr/Hmr.h>
#import <HMRRts/HMRRts.h>

NS_ASSUME_NONNULL_BEGIN

@interface HummerManager : NSObject

+ (instancetype)sharedManager;

/// 获取版本号
/// Get version
+ (NSString *)sdkVersion;

/// 获取region
/// Get region
- (NSString *)region;

/// 初始化SDK
/// Init SDK
- (void)startWithAppId:(uint64_t)appId appVersion:(NSString *)appVer eventObserver:(id<HMREventObserver>)observer;

/// 设置日志存储路径
/// Set log file path
- (void)setLoggerFilePath:(NSString *)path;

/// 登录
/// Login
- (void)loginWithUid:(uint64_t)uid region:(NSString *)region token:(NSString *)token completion:(HMRRequestCompletion)completion;

/// 退出
/// Logout
- (void)logout;

/// 发送点对点消息
/// Send peer message
- (void)sendPeerMessageToUser:(NSString *)uid
                      content:(NSString *)content
                         type:(NSString *)type
                       extras:(NSDictionary *)extras
                 completionHandler:(void (^ _Nullable)(NSError * _Nullable error))completionHandler;

/// 添加监听
/// Add observer
- (void)addObserver:(id<HMRPeerServiceObserver>)observer;
@end

NS_ASSUME_NONNULL_END
