//
//  YiUploadImageRequest.m
//  YiNetwork
//
//  Created by coderyi on 15/9/15.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "YiUploadImageRequest.h"

@implementation YiUploadImageRequest{
    UIImage *_image;
}


- (id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}
- (AFConstructingBlock)constructingBodyBlock {
    return ^(id<AFMultipartFormData> formData) {
        NSData *data = UIImageJPEGRepresentation(_image, 0.9);
        NSString *name = @"image";
        NSString *formKey = @"image";
        NSString *type = @"image/jpeg";
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}
@end
