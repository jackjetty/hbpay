

#ifndef hbpay_Constant_h
#define hbpay_Constant_h

#define SERVERURL @"http://115.239.134.175:80/AppServer"

#define STORE_FIRSTLOAD @"FIRSTLOAD"
#define STORE_PHONENUMBER @"PHONENUMBER"

#define STORE_QQNUMBER @"QQNUMBER"
#define STORE_PASSWORD @"PASSWORD"
#define STORE_REMEMBER @"REMEMBER"
#define STORE_QCOINPAYTIP @"QCOINPAYTIP"
#define STORE_QMONTHPAYTIP @"QMONTHPAYTIP"
#define STORE_QMEMBERPAYTIP @"QMEMBERPAYTIP"

#define QCOINBUSID @"100"
#define VCOINBUSID @"101"
#define TCOINBUSID @"102"
#define QMONTHBUSID @"103"
#define QMEMBERBUSID @"104"
#define FLOWBUSID @"105"
#define BILLBUSID @"106"

//登入
#define LOGIN_METHOD @"/user/login"

//获取短信验证码
#define GETSMSCODE_METHOD @"/user/getSMSCode"

//获取打折优惠信息
#define REBATE_METHOD @"/user/rebate"

//注册
#define REGISTER_METHOD @"/user/register"

//找回密码
#define FINDPWD_METHOD  @"/user/changePassword"

//首页信息
#define HOME_METHOD @"/iOS/homePage"

//图片地址
#define PIC_METHOD @"/image/getIOSSalesInfoImage"

//Q币直充
#define QCURENCY_CHARGE @"/charge/takeOrder"

//Q币直充确认
#define QCURENCYCONFIRM_CHARGE @"/charge/pay"

//短信验证码验证
#define CHECKSMS_METHOD @"/SMSCode/check"

//包月
#define QMONTH_CHARGE @"/charge/takeQQPerMonthOrder"

//包月提交
#define QMONTHSUBMIT_CHARGE @"/charge/payQQPerMonth"

//包月取消
#define QMONTHCANCEL_CHARGE @"/charge/cancelQQPerMonthOrder"

//包月查询
#define QMONTHSEARCH_CHARGE @"/charge/checkQQPerMonth"

//充值记录
#define CHARGELIST_TRADE @"/trade/simpleList"

//常见问题
#define FAQ_METHOD @"/faq/get"

//意见反馈
#define FEEDBACK_METHOD @"/feedBack/record"

//查询并验证包月    取消包月前的操作
#define CHECKQMONTH_CHARGE @"/charge/checkQQPerMonthWithSecurityCode"

//QQ会员充值续费下单
#define TAKEQQVIPORDER_CHARGE @"/charge/takeQQVIPOrder"

//QQ会员充值续费支付接口
#define PAYQQVIP @"/charge/payQQVIP"

//获取优惠信息
#define GETYOUHUI @"/salesInfo/get"

//获取消息
#define GETMSG @"/publicInfo/getMessage"

//获取剩余可用金额
#define GETLEFTMONEY @"/check/getLeftMoney"





#endif
