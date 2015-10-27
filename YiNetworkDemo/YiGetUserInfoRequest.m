//
//  YiGetUserInfoRequest.m
//  YiNetwork
//
//  Created by coderyi on 15/9/16.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "YiGetUserInfoRequest.h"
#import "YiUserInfoModel.h"

@implementation YiGetUserInfoRequest
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
- (NSString *)pathName
{
    return @"users/coderyi";
}
- (YiHTTPRequestMethod)requestMethod
{
    return YiHTTPRequestMethodGet;
}
- (YiBaseModel *)responseModelWithData:(id)data
{
    
    return [[YiUserInfoModel alloc] initWithDictionary:data error:nil];
}
@end
