//
//  Strings.h
//  YPOneLoginDemo
//
//  Created by qipeng_yuhao on 2019/11/13.
//  Copyright © 2019 QiPeng. All rights reserved.
//

#ifndef Strings_h
#define Strings_h

//appid
#define AppIDKey @"98b482fc9efa45ddb141e6fd8804cb01"

//开发者替换为自己服务器
//#define TEST_HOST @"https://mobileauth.yunpian.com"
#define TEST_HOST @"http://115.159.115.175:8071"
#define TEST_ACQUIREPHONE  [NSString stringWithFormat:@"%@%@", TEST_HOST, @"/api/mobileauth/customer/acquirePhone"]


static  NSString *GlobelS_NOTICEINFO = @"使用本机号码校验，即代表您已同意授权云片通过中国三大运营商为您提供本机号码校验服务";

#endif /* Strings_h */
