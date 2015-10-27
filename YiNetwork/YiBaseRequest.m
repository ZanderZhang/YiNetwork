//
//  YiBaseRequest.m
//  YiNetwork
//
//  Created by coderyi on 15/9/15.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "YiBaseRequest.h"
static NSInteger globalRequestSeqID = 1;
@interface YiBaseRequest()
@property (nonatomic, strong)AFHTTPSessionManager *manager;

@property (nonatomic, strong)NSURLSessionTask *task;

/**
 *  成功回调
 */
@property (nonatomic, copy) RequestSuccess requestSuccess;
/**
 *  失败回调
 */
@property (nonatomic, copy) RequestFailed requestFailed;
/**
 *  请求 ID
 */
@property (nonatomic, assign) NSInteger requestSeqID;
@end

@implementation YiBaseRequest
#pragma mark - Lifecycle
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
#pragma mark - Public
- (void)cancelAllOperations{
    [_manager.operationQueue cancelAllOperations];
}
- (void)cancel
{
    [self.task cancel];
    
    self.requestSuccess = nil;
    self.requestFailed = nil;
    self.task = nil;
}
- (NSString *)rootUrl{
    return @"https://api.github.com/";
}
- (NSString *)pathName{
    return @"";
}
- (YiHTTPRequestMethod)requestMethod{
    return YiHTTPRequestMethodGet;
}
- (AFConstructingBlock)constructingBodyBlock {
    return nil;
}

- (YiBaseModel *)responseModelWithData:(id)data{
    return [[YiBaseModel alloc] initWithDictionary:data error:nil];
}

- (void)requestWithSuccess:(void(^)(YiBaseModel *model,NSURLSessionTask *task))success
                   failure:(void(^)(NSError *error,NSURLSessionTask *task))failure{
    self.requestSeqID = globalRequestSeqID;
    globalRequestSeqID++;
    self.requestSuccess = success;
    self.requestFailed = failure;
    switch (self.requestMethod) {
        case YiHTTPRequestMethodGet:{
            
            //可以进行一些公共参数设置
        }
            break;
            
        case YiHTTPRequestMethodPost:{
            
            //可以进行一些公共参数设置
        }
            break;
    }
    
    [self request];
}
#pragma mark - Private
- (void)request{
    if (self.requestMethod==YiHTTPRequestMethodGet) {
        self.task=[self.manager GET:[self buildRequestUrl] parameters:self.getParams success:^(NSURLSessionDataTask *task, id responseObject){
//            NSLog(@"JSON: %@", responseObject);
            YiBaseModel *baseModel=[self responseModelWithData:responseObject];
            if(self.requestSuccess)
            {
                _requestSuccess(baseModel,task);
            }

        } failure:^(NSURLSessionDataTask *task, NSError *error){
//            NSLog(@"Error: %@", error);
            if (self.requestFailed)
            {
                
                [self reRequestWithError:error task:task];
                
            }

        }];
        
    }else if (self.requestMethod==YiHTTPRequestMethodPost){
        

        if (!self.constructingBodyBlock) {
        
            self.task =
            [self.manager POST:[self buildRequestUrl] parameters:self.postParams success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSLog(@"JSON: %@", responseObject);
                YiBaseModel *baseModel=[self responseModelWithData:responseObject];

                if(self.requestSuccess)
                {
                    _requestSuccess(baseModel,task);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                NSLog(@"Error: %@", error);
                if (self.requestFailed)
                {
                    
                    [self reRequestWithError:error task:task];
                    
                }
            }];
        }else{
            self.task =
            [self.manager POST:[self buildRequestUrl] parameters:self.postParams constructingBodyWithBlock:self.constructingBodyBlock success:^(NSURLSessionDataTask *task, id responseObject) {
//                NSLog(@"Success: %@", responseObject);
                YiBaseModel *baseModel = [self responseModelWithData:responseObject];
                if(self.requestSuccess)
                {
                    _requestSuccess(baseModel,nil);
                }
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
//                NSLog(@"Error: %@", error);
                if (self.requestFailed)
                {
                    
                    [self reRequestWithError:error task:task];
                    
                }
            }];
        }
        
    }
    
}

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
        // a mime type list:http://www.freeformatter.com/mime-types-list.html
        if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus==AFNetworkReachabilityStatusNotReachable) {
            _manager.requestSerializer.cachePolicy=NSURLRequestReturnCacheDataDontLoad;

        }else{
            _manager.requestSerializer.cachePolicy=NSURLRequestUseProtocolCachePolicy;

        }
    }
    return _manager;
}

- (NSString *)buildRequestUrl{
    NSString *detailUrl = [self pathName];
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    NSString *requesturl = nil;
    if ([self.rootUrl hasSuffix:@"/"] ) {
        requesturl = [NSString stringWithFormat:@"%@%@", self.rootUrl, detailUrl];
    }else{
        requesturl = [NSString stringWithFormat:@"%@/%@", self.rootUrl, detailUrl];
    }
    
    return requesturl;
}
- (NSMutableDictionary *)getParams
{
    if (!_getParams)
    {
        _getParams = [NSMutableDictionary dictionary];
    }
    return _getParams;
}

- (NSMutableDictionary *)postParams{
    if (!_postParams) {
        _postParams = [NSMutableDictionary dictionary];
    }
    return _postParams;
}
- (void)reRequestWithError:(NSError *)error task:(NSURLSessionTask *)task{
    if (_retryCount>0) {
        --_retryCount;
        _retryIndex++;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self request];
        });
    }else{
        _requestFailed(error,task);
        
        
    }
}
@end
