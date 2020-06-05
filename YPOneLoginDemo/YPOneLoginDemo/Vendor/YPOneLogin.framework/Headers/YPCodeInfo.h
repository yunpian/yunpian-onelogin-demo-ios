//
//  YPCodeInfo.h
//  YPOneLogin
//
//  Created by qipeng_yuhao on 2020/3/26.
//  Copyright © 2020 QiPeng. All rights reserved.
//

#ifndef YPCodeInfo_h
#define YPCodeInfo_h

#pragma mark - status code

#define kYPO_SuccessMsg @"success"
#define kYPO_SuccessCode 200

#define kYPO_SdkInitErrorMsg @"初始化 SDK 失败"
#define kYPO_SdkInitErrorCode 20000

#define kYPO_UndefinedErrorMsg @"未知错误"
#define kYPO_UndefinedErrorCode 20001

#define kYPO_AppIdEmptyErrorMsg @"AppId 不能为空，请检查是否初始化 SDK"
#define kYPO_AppIdEmptyErrorCode 20002

#define kYPO_SubmitTokenErrorMsg @"submit token error"
#define kYPO_SubmitTokenErrorCode 20003

#define kYPO_PergetCidEmptyErrorMsg @"预取号 cid 为空"
#define kYPO_PergetCidEmptyErrorCode 20004



#pragma mark - 登录事件回调code

#define KYPO_LoginEventCode_Back 66661 // 点击返回按钮
#define KYPO_LoginEventMsg_Back @"您点击了返回按钮"
#define KYPO_LoginEventCode_Switch 66662 // 点击切换按钮
#define KYPO_LoginEventMsg_Switch @"您点击了切换按钮"


#endif /* YPCodeInfo_h */
