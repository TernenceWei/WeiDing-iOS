//
//  UrlDefine.h
//  WeiLvDJS
//
//  CreatWed by jyc on 16/9/1.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//


#ifndef UrlDefine_h
#define UrlDefine_h

//#define ONTEST 
#define ONDEV

#ifdef ONDEV

/*************************  开发服务器接口地址  ************************************/

#define BaseUrl  @"http://dev.nawanr.com/api"
#define LoginBaseUrl BaseUrl @"/User"

/** 通讯录模块基础URL */
#define CompanyBaseUrl BaseUrl @"/Contacts"
/** 好友基础URL */
#define FriendBaseUrl BaseUrl @"/SocialFriend"

/** 司机接口基础Url */
#define DriverBaseUrl @"http://dcd.nawanr.com/Api/Driver"
/** 司机订单基础Url */
#define DriverOrderBaseUrl DriverBaseUrl @"/Order"
/** 司机帐单基础Url */
#define DriverBillBaseUrl DriverBaseUrl @"/Bill"


/*图片接口url*/
#define DriverPhotoUrl @"http://dcd.nawanr.com"

#define PersonCenterUrl BaseUrl @"/PersonCenter"

/** 好友基础URL */
#define FriendBaseUrl BaseUrl @"/SocialFriend"
/** 通讯录模块基础URL */
#define CompanyBaseUrl BaseUrl @"/Contacts"
//导游开发环境
#define TouristGuideBaseURL               @"http://guide.nawanr.com/api"
//房销开发环境
#define HotelBaseURL                      @"http://djd.nawanr.com/api"
/******************************************************************************/

#elif defined ONTEST

/*************************  测试服务器接口地址  ************************************/
//测试环境
#define BaseUrl  @"http://dream.nawanr.com/api"

#define LoginBaseUrl BaseUrl @"/User"
/** 司机接口基础Url */

//测试环境
#define DriverBaseUrl @"http://tcd.nawanr.com/Api/Driver"

/** 消息基础Url */
#define MessageBaseUrl BaseUrl @"/SocialFriend"

/** 司机订单基础Url */
#define DriverOrderBaseUrl DriverBaseUrl @"/Order"
/** 司机帐单基础Url */
#define DriverBillBaseUrl DriverBaseUrl @"/Bill"
/*图片接口url*/

//测试环境
#define DriverPhotoUrl @"http://tcd.nawanr.com"
#define PersonCenterUrl BaseUrl @"/PersonCenter"

#define FriendBaseUrl BaseUrl @"/SocialFriend"
#define CompanyBaseUrl BaseUrl @"/Contacts"

//导游测试环境
#define TouristGuideBaseURL               @"http://guideDream.nawanr.com/api"
//房销测试环境
#define HotelBaseURL                      @"http://tjd.nawanr.com/api"
/******************************************************************************/
#else

/*************************  t.vding.wang南京使用服务器接口地址  ************************************/
//测试环境
#define BaseUrl  @"http://t.vding.wang/api"

#define LoginBaseUrl BaseUrl @"/User"
/** 司机接口基础Url */

//测试环境
#define DriverBaseUrl @"http://t.car.vding.wang/Api/Driver"

/** 消息基础Url */
#define MessageBaseUrl BaseUrl @"/SocialFriend"

/** 司机订单基础Url */
#define DriverOrderBaseUrl DriverBaseUrl @"/Order"
/** 司机帐单基础Url */
#define DriverBillBaseUrl DriverBaseUrl @"/Bill"
/*图片接口url*/

//测试环境
#define DriverPhotoUrl @"http://t.car.vding.wang"
#define PersonCenterUrl BaseUrl @"/PersonCenter"

#define FriendBaseUrl BaseUrl @"/SocialFriend"
#define CompanyBaseUrl BaseUrl @"/Contacts"

//导游测试环境
#define TouristGuideBaseURL               @"http://t.guide.vding.wang/api"
//房销环境
#define HotelBaseURL                      @"http://t.hotel.vding.wang/api"
/******************************************************************************/

#endif

/****************************** 登录注册 ****************************************/
/** 登录Url */
#define LoginUrl  LoginBaseUrl @"/login"

/** 发送验证码Url*/
#define CaptchaUrl  LoginBaseUrl @"/getVerify"

/** 校验验证码是否正确Url */
#define CheckVerifyUrl LoginBaseUrl @"/checkVerify"

/** 注册接口Url */
#define RegisterUrl LoginBaseUrl @"/register"

/** 获取公司列表Url */
#define MyCompanyListUrl LoginBaseUrl @"/myCompanyList"

/** 忘记登录密码Url */
#define FindLoginPassUrl PersonCenterUrl @"/findLoginPass"


/****************************** 个人中心 ****************************************/

/** 个人中心首页Url */

#define  MinePersonCenterHomeUrl  PersonCenterUrl @"/UserIndex"

/** 验证原密码Url */
#define VerificationOldPasswordUrl PersonCenterUrl @"/checkOldPass"

/** 重新绑定手机号Url */
#define ChangeNewPhoneUrl PersonCenterUrl @"/relationMobile"

/********个人资料************/
/*个人资料信息获取*/
#define PersonInfoMationUrl PersonCenterUrl @"/userInformation"

/*个人资料编辑*/
#define PersonInfoMationEditUrl PersonCenterUrl @"/editUserInfo"

/*修改头像*/
#define PersonInfoChangeHeadImageUrl  LoginBaseUrl @"/setUserAdver"

/*城市列表获取*/
#define PersonInfoCityListUrl PersonCenterUrl @"/regionsList"

/*实名认证*/
#define PersonInfoUserValidateUrl PersonCenterUrl @"/userValidate"


/*** 资金账户 *********/

/** 设置支付密码Url */
#define  MinePayPassWordUrl  PersonCenterUrl @"/setPayPassword"

/** 检查是否设置过支付密码Url */
#define  CheckPassWordUrl  PersonCenterUrl @"/checkIspayPass"

/** 检查是否 通过实名认证Url */
#define  CheckRealNameUrl  PersonCenterUrl @"/checkRealName"

/** 检查是否绑定了银行卡Url */
#define   CheckBindBankUrl  PersonCenterUrl @"/checkBindBank"

/** 修改支付密码Url */
#define  EditPassWordUrl  PersonCenterUrl @"/editPayPassword"

/** 验证身份证，验证码等信息Url */
#define  ForgetPayPassUrl  PersonCenterUrl @"/forgetPayPass"

/** 修改密码 */
#define ChangeNewPassowrdUrl PersonCenterUrl @"/editLoginPass"

/** 添加银行卡 */
#define  AddBankCardUrl  PersonCenterUrl @"/addBankCard"

/** 添加银行卡 */
#define  AddBankCardUrl  PersonCenterUrl @"/addBankCard"

/** 获取我的银行卡列表 */
#define  GetBankCardListUrl  PersonCenterUrl @"/getBankCardList"

/** 交易记录 */
#define  FinanceRecordUrl  PersonCenterUrl @"/financeLog"

/** 冻结记录 */
#define  FreezeLogRecordUrl  PersonCenterUrl @"/freezeLog"

/** 请求生成支付宝订单 */
#define  AlipayPayRsaUrl  BaseUrl @"/AlipayPayRsa/alipayConfig"

/** 更新交易操作状态 */
#define  AlipayPayUpdateRechargeFUrl  BaseUrl @"/AlipayPayRsa/updateRechargeFail"

/** 提现接口 */
#define  AccountWithdrawalUrl  PersonCenterUrl @"/withdrawal"

/****************************** 应用 ****************************************/


/** 导游首页导游认证状态 */
#define GuiderStatusUrl  @"http://guideDream.nawanr.com/api/Guide/getIndexGuideInfo"
/** 公司列表 */
#define MyCompanyListUrl LoginBaseUrl @"/myCompanyList"
/** 查看我的公司角色(没有部门要求) */
#define MyCompanyRoles LoginBaseUrl @"/myCompanyRoles"
/** 司机应用司机与车辆状态 */
#define DriverHomeUrl DriverBaseUrl @"/Home/index"
/** 司机信息 */
#define DriverinfoUrl DriverBaseUrl @"/Driver/getDriver"

/** 更新司机图片信息 */
#define DriverPhotoImageUrl DriverBaseUrl @"/Driver/optDriverPhoto"

/** 第一次提交司机信息 */
#define DriverOperationUrl DriverBaseUrl @"/Driver/addDriver"


/** 编辑司机信息 */
#define DriverEditDriverUrl DriverBaseUrl @"/Driver/editDriver"

/** 司机订单列表Url */
#define DriverOrderListUrl DriverOrderBaseUrl @"/orderList"
/** 清空司机已失效订单列表Url */
#define DriverOrderClearFailureListUrl DriverOrderBaseUrl @"/deleteInvalidOrder"
/** 司机订单更新订单状态Url */
#define DriverOrderUpdateOrderUrl DriverOrderBaseUrl @"/updateOrder"

/** 司机账单列表Url */
#define DriverBillListUrl DriverBillBaseUrl @"/bill"

/** 司机账单统计Url */
#define DriverBillStatisticsUrl DriverBillBaseUrl @"/statistics"

/** 司机订单详情Url */
#define DriverOrderDetailUrl DriverOrderBaseUrl @"/orderDetail"

/** 获取支付记录Url */
#define DriverGetOrderPayRecordUrl DriverOrderBaseUrl @"/getOrderPayRecord"

/** 车辆 */

/*******操作车辆图片*********/
#define PhotoChangeurl DriverBaseUrl @"/Car/editCarPhoto"
/*******新增车辆信息*********/
#define addCarInfomationUrl DriverBaseUrl @"/Car/addCar"

/*******编辑车辆信息*********/
#define editCarInfomationUrl DriverBaseUrl @"/Car/editCar"

/*******获取车辆公司信息*********/
#define getCompanysCarInfomationUrl DriverBaseUrl @"/Car/getCompanys"

/*******获取车辆列表*********/
#define getCarListCarInfomationUrl DriverBaseUrl @"/Car/getCarList"

/*******获取车辆信息*********/
#define getCarDataCarInfomationUrl DriverBaseUrl @"/Car/getCarData"

/*******更改车辆状态*********/
#define setCarInfomationUrl DriverBaseUrl @"/Car/setCar"

/*******删除车辆列表中的某一条*********/
#define deleteCarInfomationUrl DriverBaseUrl @"/Car/deleteCar"

/*******获取司机信息*********/
#define DriverInfomationUrl DriverBaseUrl @"/Driver/driverinfo"

/*******修改司机信息*********/
#define operationDriverInfomationUrl DriverBaseUrl @"/Driver/operation"

/** 获取行程日历Url */
#define DriverGetScheduleUrl DriverOrderBaseUrl @"/getSchedule"

/**根据日期获取行程信息Url */
#define DriverGetScheduleOrder DriverOrderBaseUrl @"/getScheduleOrder"

/** 更改日历设置Url */
#define DriverUpdateScheduleUrl DriverOrderBaseUrl @"/updateSchedule"

/** 增加收款纪录Url */
#define DriverAddOrderPayRecordUrl DriverOrderBaseUrl @"/addOrderPayRecord"

/****************************** 搜索 ****************************************/

/** 私信搜索 */
#define SocialGroupCreateChatUrl BaseUrl @"/SocialGroup/CreateChat"

/** 搜索联系人群组 */
#define SearchSearchUrl BaseUrl @"/Search/search"

/** 消息首页搜索 */
#define SearchsearchMessageUrl BaseUrl @"/Search/searchMessage"

/****************************** 消息 ****************************************/

/** 公告url */
#define NoticeNoticeBannerUrl BaseUrl @"/Notice/NoticeBanner"

/** 全部公告列表url */
#define NoticeNoticeListUrl BaseUrl @"/Notice/noticeList"

/** 公告详情url */
#define NoticeDetailUrl BaseUrl @"/Notice/NoticeDetail?nId="

/** 消息列表 */
#define MessageGetMessageListUrl BaseUrl @"/Message/getMessageList"

/** 消息列表删除 */
#define MessageDeleteMessageUrl BaseUrl @"/Message/deleteMessage"

/** 私信列表 */
#define LetterListUrl BaseUrl @"/Letter/letterList"

/** 私信详情 */
#define LetterDetailUrl BaseUrl @"/Letter/letterDetail"

/** 私信添加回复 */
#define LetterAddReplyUrl BaseUrl @"/Letter/addReply"

/** 添加或者取消收藏 */
#define LetterHandelCollectUrl BaseUrl @"/Letter/handelCollect"

/** 私信删除url */
#define LetterDelLetterUrl BaseUrl @"/Letter/delLetter"

/** 发送私信url */
#define LetterAddLetterPrivate BaseUrl @"/Letter/addLetterPrivate"

/** 查看公司列表url */
#define UserMyCompanyListUrl BaseUrl @"/User/myCompanyList"

/** 获取好友个数url */
#define SocialFriendCountFriendUrl BaseUrl @"/SocialFriend/countFriend"

/** 常用联系人列表url */
#define ContactsUsuallyContactsListUrl BaseUrl @"/Contacts/usuallyContactsList"

/** 获取公司下一级部门url */
#define UserGetMyCompanyDepartmentListUrl BaseUrl @"/User/getMyCompanyDepartmentList"


/****************************** 通讯录 ****************************************/
/** 常用联系人列表 */
#define MyContactListUrl CompanyBaseUrl @"/usuallyContactsList"
/** 公司列表 */
#define CompanyListUrl CompanyBaseUrl @"/companyList"
/** 企业详情 */
#define CompanyDetailUrl BaseUrl @"/Company/viewCompanyInfo"
/** 常用联系人详情 */
#define LinkManDetailUrl CompanyBaseUrl @"/viewFrindDetail"
/** 添加好友接口 */
#define AddFriendUrl FriendBaseUrl @"/addFriend"
/** 修改备注名称接口 */
#define ChangeRemarkNameUrl  CompanyBaseUrl  @"/editRemarkName"
/** 解除好友关系 */
#define EditingFriendUrl FriendBaseUrl @"/delFriend"
/** 微叮好友列表 */
#define MyFriendListUrl FriendBaseUrl @"/myFriendList"
/** 申请添加新好友的列表 */
#define NewFriendListUrl FriendBaseUrl @"/newFriendList"
/**  接受并同意对方加为好友 */
#define AgreeFriendUrl FriendBaseUrl @"/agreeFriend"
/** 关注企业Url */
#define CompanyFollowUrl FriendBaseUrl @"/companyFollow"

/** 查看公司列表url */
#define UserMyCompanyListUrl BaseUrl @"/User/myCompanyList"

/** 获取好友个数url */
#define SocialFriendCountFriendUrl BaseUrl @"/SocialFriend/countFriend"
/** 获取手机通讯录中已经注册并且不是好友的列表url */
#define IsNoRegInMyAddressBook BaseUrl @"/SocialFriend/isNotReg"
/** 删除单个好友请求记录的url */
#define DeleteNewFriendRecordUrl BaseUrl @"/SocialFriend/delFriendApply"
/** 统计等待同意好友记录的数量的url */
#define CountNewFriendUrl BaseUrl @"/SocialFriend/countNewFriend"
/** 常用联系人列表url */
#define ContactsUsuallyContactsListUrl BaseUrl @"/Contacts/usuallyContactsList"
/** 搜索手机号码添加好友接口 */
#define addSearchFriendsUrl BaseUrl @"/Search/addSearchFriends"
/** 联系人首页搜索接口 */
#define WLSearchUrl BaseUrl @"/Search/searchContants"

/** 联系人组织架构内搜索接口 */
#define WLSearchCompanyUserUrl BaseUrl @"/Search/searchCompanyUser"

/** 获取部门的下一级子部门以及当前部门员工 */
#define GetMyCompanyDepartmentListUrl LoginBaseUrl @"/getMyCompanyDepartmentList"
/** 定位自己 */
#define GetMyselfPositionUrl LoginBaseUrl @"/getMyselfPosition"

/** 关注的企业列表 */
#define FollowCompanyListUrl CompanyBaseUrl @"/getMyFollowCompany"

#endif /* UrlDefine_h */
