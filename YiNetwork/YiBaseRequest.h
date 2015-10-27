//
//  YiBaseRequest.h
//  YiNetwork
//
//  Created by coderyi on 15/9/15.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#import "YiBaseModel.h"
/**
 *  HTTP method enum
 */
typedef NS_ENUM(NSUInteger, YiHTTPRequestMethod){
    /**
     *  Get method
     */
    YiHTTPRequestMethodGet = 0,
    /**
     *  Post method
     */
    YiHTTPRequestMethodPost
};

typedef void (^AFConstructingBlock)(id<AFMultipartFormData> formData);

typedef void (^ RequestSuccess)(YiBaseModel *model,NSURLSessionTask *task);
typedef void (^ RequestFailed)(NSError *error,NSURLSessionTask *task);

@interface YiBaseRequest : NSObject

/**
 *  get 参数
 */
@property (nonatomic, strong) NSMutableDictionary *getParams;
/**
 *  post 参数
 */
@property (nonatomic, strong) NSMutableDictionary *postParams;
/**
 *  重试次数 默认为0
 */
@property (nonatomic, assign) NSInteger retryCount;

// 正在重试第几次
@property (nonatomic, assign) NSInteger retryIndex;

/**
 *  数据请求方法
 *
 *  @param success 成功的回调
 *  @param failure 错误的回调
 */
- (void)requestWithSuccess:(void(^)(YiBaseModel *model,NSURLSessionTask *task))success
                   failure:(void(^)(NSError *error,NSURLSessionTask *task))failure;





- (YiHTTPRequestMethod)requestMethod;
//处理请求到得数据
- (YiBaseModel *)responseModelWithData:(id)data;
- (NSString *)pathName;

- (NSString *)rootUrl;
// 当POST的内容带有文件时使用
- (AFConstructingBlock)constructingBodyBlock;
/**
 *  cancel HTTP
 */
- (void)cancel;
@end
