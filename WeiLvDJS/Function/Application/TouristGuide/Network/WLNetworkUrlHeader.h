//
//  WLNetworkUrlHeader.h
//  WeiLvDJS
//
//  Created by ternence on 16/10/9.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#ifndef WLNetworkUrlHeader_h
#define WLNetworkUrlHeader_h

#pragma mark tourist guide

#define TouristGuideOauthStatusURL        @"/Guide/getIndexGuideInfo"
#define TouristGuidePersonnalInfoURL      @"/Guide/getGuideInfo"
#define TouristGuideSubmmitInfoURL        @"/Guide/editGuideInfo"
#define TouristGuideDeleteImgURL          @"/Guide/delImg"
#define TouristGuideDeletePriceURL        @"/Guide/delPrice"

#define TouristGuideOnGroupIDURL          @"/guide/isGuideChuQu"

#define TouristGuideOrderListURL          @"/GroupList/getGroupList"
#define TouristGuideAccpetOrderURL        @"/GroupList/isAccept"
#define TouristGuideClearOrderListURL     @"/GroupList/clearGroupList"
#define TouristGuideGroupInfoURL          @"/GroupList/getGroupInfo"
#define TouristGuideLineInfoURL           @"/GroupList/getLineInfo"
#define TouristGuideListURL               @"/GroupList/getGuideList"

#define TouristGuideGroupSummaryDetailURL @"/GroupList/getGroupDetail"
#define TouristGuideGroupDetailURL        @"/GroupList/getChangeChecklist"

#define TouristGuideBillDetailURL         @"/GroupList/getGuideDetail"
#define TouristGuideSubmitBillDetailURL   @"/Guide/guideSubmit"
#define TouristGuideRefundURL             @"/Guide/guideRefund"

#define TouristGuideVisitorListURL        @"/Visitor/lists"
#define TouristGuideVisitorDetailURL      @"/Visitor/detail"

#define TouristGuideRequestScheduleURL    @"/Schedule/getSchedule"
#define TouristGuideSetScheduleURL        @"/Schedule/setMySchedule"
#define TouristGuideModifyGroupStatusURL  @"/Schedule/setGroupState"

#define TouristGuideMyIncomelistURL       @"/Bill/getBillList"
#define TouristGuideStatisticsURL         @"/Bill/getBillStatistics"

#define TouristGuideChargeUpURL           @"/Bill/editItemBill"
#define TouristGuideRequestChargeUpURL    @"/Bill/getItemBillInfo"
#define TouristGuideRequestGroupInfoURL   @"/Bill/getItemBillDetails"
#define TouristGuideDeleteChargeupImgURL  @"/Bill/delBillImg"
#define TouristGuideDeleteChargeupScheduleListURL  @"/Bill/delPriceList"



#pragma mark hotel

#define HotelRequestOrderListURL          @"/Room/Order/orders"
#define HotelDeleteOrderURL               @"/Room/Order/del"
#define HotelModifyOrderStatusURL         @"/Room/Order/ustatus"
#define HotelQuoteURL                     @"/Room/Order/quote"
#define HotelBillListURL                  @"/Room/Bill/statistics"
#define HotelBillDetailURL                @"/Room/Bill/detail"





#endif /* WLNetworkUrlHeader_h */
