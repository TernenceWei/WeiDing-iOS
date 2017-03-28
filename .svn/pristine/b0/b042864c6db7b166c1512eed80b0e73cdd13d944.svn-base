//
//  WL_Application_TourGuide_info_ViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/10/13.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "WL_Application_TourGuide_info_ViewController.h"
#import "WL_Application_TourGuide_BasicInfo_TableViewCell.h"
#import "WL_Application_TourGuide_Picure_TableViewCell.h"
#import "WL_Application_TourGuide_Price_TableViewCell.h"
#import "WL_Application_TourGuide_Remark_TableViewCell.h"

#import "WL_Application_TourGuide_Price_TableViewCell1.h"
#import "WL_Application_TourGuide_Price_TableViewCell2.h"
#import "WL_Application_TourGuide_Price_TableViewCell3.h"
#import "WL_Application_TourGuide_Price_TableViewCell4.h"

//报价详情
#import "WLApplicationGuidePriceDetailTableViewCell.h"

//导游信息模型
#import "WLTouristGuideInfo.h"
#import "WLPriceListObject.h"
#import "WLNetworkUrlHeader.h"
#import "WLNetworkManager.h"
#import "WLNetworkTouristHandler.h"

#import "WLApplicationGuideChangeInformatonViewController.h"//填信息
#import "WL_Mine_personInfo_regionViewController.h"//选择地区
#import "WLApplicationGuidePriceDetailViewController.h"//自定义报价详情
#import "WLApplicationGuideShowPriceViewController.h"//展示报价

#import "WLPhotoCheckView.h" // 照片查看器


@interface WL_Application_TourGuide_info_ViewController()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,WLApplicationGuideChangeInformatonViewControllerDelegate,WLApplicationGuidePriceDetailViewControllerDelegate>

@property(nonatomic,strong)UITableView *informationTableView;

//左侧信息
@property(nonatomic,strong)NSMutableArray *leftTitleAllArr;//左侧信息
@property(nonatomic,strong)NSMutableArray *leftTitleTopArr;//基本信息
@property(nonatomic,strong)NSMutableArray *leftTitleCenterArr;//导游信息
@property(nonatomic,strong)NSMutableArray *leftTitlePriceArr;//报价信息
@property(nonatomic,strong)NSMutableArray *leftTitleBottomArr;//备注信息
//右侧信息
@property(nonatomic,strong)NSMutableArray *rightTitleAllArr;//右侧信息
@property(nonatomic,strong)NSMutableArray *rightTitleTopArr;//右侧信息
@property(nonatomic,strong)NSMutableArray *rightTitleCenterArr;//右侧信息
@property(nonatomic,strong)NSMutableArray *rightTitleBottomArr;//右侧信息

@property(nonatomic,assign)NSInteger indexSection;
@property(nonatomic,assign)NSInteger indexTag;

//选择器视图
@property(nonatomic,strong)UIView *pickBackView;
@property(nonatomic,strong)UIPickerView *chosePickView;

//选择器数据源
@property(nonatomic,strong)NSMutableArray *arrSex;//性别
@property(nonatomic,strong)NSMutableArray *arrAge;//年龄
//@property(nonatomic,strong)NSMutableArray *arrGuideAge;//导龄
@property(nonatomic,strong)NSMutableArray *arrWorkYears;//从业时长
@property(nonatomic,strong)NSMutableArray *arrLevel;//导游级别
@property(nonatomic,strong)NSMutableArray *arrLanguage;//导游语种

//用属性记录来判断isEqualToString
@property(nonatomic,strong)NSString *choseType;
//给模型传数据存储和给右侧数据源传数据展示
@property(nonatomic,strong)NSString *didSelectStr;

//数据是否为空
@property(nonatomic,assign)BOOL IsInfomation;

@property(nonatomic,strong)UIImageView *imageView1;//身份证正面
@property (nonatomic, assign) BOOL isimageView1nil;
@property(nonatomic,strong)UIImageView *imageView2;//身份证反面
@property (nonatomic, assign) BOOL isimageView2nil;
@property(nonatomic,strong)UIImageView *imageView3;//导游证正面
@property (nonatomic, assign) BOOL isimageView3nil;
@property(nonatomic,strong)UIImageView *imageView4;//导游证反面
@property (nonatomic, assign) BOOL isimageView4nil;

@property(nonatomic,strong)WL_TipAlert_View *AlertTitle;//弹出提示框

@property(nonatomic,strong)WLTouristGuideInfo *guideInfoModel;//导游个人信息
@property(nonatomic,strong)WLTouristGuideInfo *SaveguideInfoModel;//导游个人信息
@property (nonatomic, assign) BOOL isChangPhoto;
@property(nonatomic,strong)WLPriceListObject *priceList;//导游报价信息
@property(nonatomic,strong) WLTouristGuideInfo * DeletepriceList;//导游报价信息

@property(nonatomic,strong)NSMutableArray *priceListArray;//报价信息数组

@property (nonatomic, copy) NSString * bottomremark;

@property (nonatomic, assign) BOOL isSixnil;
@property (nonatomic, assign) BOOL isWYnil;
@property (nonatomic, assign) BOOL isLvnil;
@property (nonatomic, assign) BOOL isChangPrice;
@property (nonatomic, assign) NSInteger reIndex;

@property (nonatomic, assign) BOOL isNoInfo;

@property (nonatomic, strong) NSMutableArray * saveArr;

// 审核结果信息
@property (nonatomic, assign) BOOL iSshowcertificationStr;
@property (nonatomic, copy) NSString * certificationStr;

@property (nonatomic, strong) WLPhotoCheckView *checkView ;

//定义一个属性来做记录
@property(nonatomic, assign)NSInteger addCellRow;

@property (nonatomic, assign) NSUInteger selectedIndex;


@property (nonatomic, assign) BOOL hasChangePhoto1;
@property (nonatomic, assign) BOOL hasChangePhoto2;
@property (nonatomic, assign) BOOL hasChangePhoto3;
@property (nonatomic, assign) BOOL hasChangePhoto4;


@property (nonatomic, assign) BOOL isAllEditor;

@property (nonatomic, assign) BOOL isRunning;

@end

@implementation WL_Application_TourGuide_info_ViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    self.addCellRow = 0;
    self.indexTag = 101;
    self.indexSection = 0;
    self.selectedIndex = 0;
    
    _isChangPhoto = NO;
    _isChangPrice = NO;
    _isNoInfo = NO;
    _isAllEditor = NO;
    _iSshowcertificationStr = NO;
    _priceListArray = [[NSMutableArray alloc] init];
    _SaveguideInfoModel = [[WLTouristGuideInfo alloc] init];
    _saveArr = [[NSMutableArray alloc] init];
    
    //注册观察者---修改地址的回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GuidechangeAddressBack:) name:@"GuideChangeAddress" object:nil];
    [self setUpNav];
    //创建tableView
    [self.view addSubview:self.informationTableView];
    //创建数据源
    [self creatDataSourceArr];
    //创建选择器
    [self creatTimePickView];
    //图片中转
    [self creatUiImageViewImage];
    //创建弹出提示框
    [self creatPersonAlertView];
    //进入时加载数据(获取审核状态)
    [self loadGuideInfoFromServer];
    
    //WLNetworkTouristHandler *handle = [WLNetworkTouristHandler sharedInstance];
    
    [self getInfo];
}

-(void)viewWillAppear:(BOOL)animated{
    //监听键盘高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

-(void)viewDidDisappear:(BOOL)animated{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)setUpNav{
    self.title = @"导游资料";
    self.view.backgroundColor = BgViewColor;
    [self setNavigationRightTitle:@"编辑" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
}


#pragma mark-----左侧数据源
-(NSMutableArray *)leftTitleTopArr{
    //基本信息
    if (_leftTitleTopArr == nil) {
        _leftTitleTopArr = [[NSMutableArray alloc] initWithObjects:@"姓名",@"年龄",@"性别",@"联系电话",@"现居城市",@"详细地址",@"身份证号",@"身份证照片",nil];
    }
    return _leftTitleTopArr;
}

-(NSMutableArray *)leftTitleCenterArr{
    //导游信息
    if (_leftTitleCenterArr == nil) {
        _leftTitleCenterArr = [[NSMutableArray alloc] initWithObjects:@"导游级别",@"导游证编号",@"导游语种",@"从业时长",@"导游证照片", nil];
    }
    return _leftTitleCenterArr;
}



-(NSMutableArray *)leftTitlePriceArr{
    //报价信息
    if (_leftTitlePriceArr == nil) {
        _leftTitlePriceArr = [[NSMutableArray alloc] initWithObjects:@"", nil];
    }
    return _leftTitlePriceArr;
}

-(NSMutableArray *)leftTitleBottomArr{
    //备注信息
    if (_leftTitleBottomArr == nil) {
        _leftTitleBottomArr = [[NSMutableArray alloc] initWithObjects:@"", nil];
    }
    return _leftTitleBottomArr;
}

-(NSMutableArray *)leftTitleAllArr{
    if (_leftTitleAllArr == nil) {
        _leftTitleAllArr = [[NSMutableArray alloc] initWithObjects:self.leftTitleTopArr,self.leftTitleCenterArr,self.leftTitlePriceArr,self.leftTitleBottomArr, nil];
    }
    return _leftTitleAllArr;
}

#pragma mark-----右侧数据源
-(NSMutableArray *)rightTitleTopArr{
    if (_rightTitleTopArr == nil) {
        _rightTitleTopArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    }
    return _rightTitleTopArr;
}

-(NSMutableArray *)rightTitleCenterArr
{
    //中间
    if (_rightTitleCenterArr == nil) {
        _rightTitleCenterArr = [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"", nil];
    }
    return _rightTitleCenterArr;
}

-(NSMutableArray *)rightTitleBottomArr
{
    //底层
    if (_rightTitleBottomArr ==nil) {
        _rightTitleBottomArr = [[NSMutableArray alloc] initWithObjects:@"", nil];
    }
    return _rightTitleBottomArr;
}


-(NSMutableArray *)rightTitleAllArr{
    if (_rightTitleAllArr == nil) {
        _rightTitleAllArr = [[NSMutableArray alloc] initWithObjects:self.rightTitleTopArr,self.rightTitleCenterArr,self.rightTitleBottomArr,@"", nil];
    }
    return _rightTitleAllArr;
}

// 添加报价的数组
//-(NSMutableArray *)priceListArray{
//    if (_priceListArray == nil) {
//        _priceListArray = [NSMutableArray array];
//    }
//    return _priceListArray;
//}

#pragma mark ----- 创建tableview
-(UITableView *)informationTableView{
    if (_informationTableView == nil) {
        _informationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64) style:UITableViewStylePlain];
        _informationTableView.delegate = self;
        _informationTableView.dataSource = self;
        _informationTableView.tableHeaderView = [[UIView alloc] init];
        _informationTableView.tableHeaderView.backgroundColor = [UIColor greenColor];
        _informationTableView.showsVerticalScrollIndicator = NO;
        _informationTableView.backgroundColor = BgViewColor;
    }
    return _informationTableView;
}

#pragma mark --- tableview 代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.leftTitleAllArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return _priceListArray.count + 1;
    }
    return [[self.leftTitleAllArr objectAtIndex:section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.section == 0 && indexPath.row == 4)  {
    //        if (IsiPhone4 || IsiPhone5) {
    //            return 88;
    //        }else{
    //            return 100;
    //        }
    //    }
    //    else
    if((indexPath.section == 0 && indexPath.row == 7)||(indexPath.section == 1 &&indexPath.row == 4)){
        if (IsiPhone4 || IsiPhone5) {
            return 105;
        }else{
            return 120;
        }
    }
    else if(indexPath.section == 2 ){
        if (IsiPhone4 || IsiPhone5) {
            return 45;
        }else{
            return 50;
        }
    }
    else if(indexPath.section == 3){
        if (IsiPhone4 || IsiPhone5) {
            return 135;
        }else{
            return 150;
        }
    }
    else{
        if (IsiPhone5 || IsiPhone4) {
            return 44;
        }else{
            return 50;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0 && _iSshowcertificationStr) {
        return ScaleH(90);
    }
    
    if (IsiPhone4 || IsiPhone5) {
        return 12;
    }else{
        return 15;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0 && _iSshowcertificationStr) {
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleH(90))];
        headView.backgroundColor = [UIColor whiteColor];
        
        //(ScaleW(10), ScaleH(65), ScaleW(40), ScaleH(40));//WLColor(140, 157, 244, 1).CGColor;
        UILabel * reultLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScaleW(100), ScaleH(15))];
        reultLabel.text = @"审核失败原因:";
        reultLabel.font = WLFontSize(12);
        reultLabel.textColor = [UIColor lightGrayColor];
        [headView addSubview:reultLabel];
        
        UILabel * resultContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(reultLabel.frame.origin.x, reultLabel.frame.origin.y + reultLabel.frame.size.height, headView.frame.size.width - 20, ScaleH(50))];
        resultContentLabel.textColor = [WLTools stringToColor:@"#6f7378"];
        resultContentLabel.text = [NSString stringWithFormat:@"%@",(_certificationStr == NULL)?@"":_certificationStr];
        reultLabel.font = WLFontSize(14);
        resultContentLabel.numberOfLines = 2;
        [headView addSubview:resultContentLabel];
        
        UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, headView.frame.size.height - 10, headView.frame.size.width, 10)];
        lineLabel.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
        [headView addSubview:lineLabel];
        
        return headView;
    }
    
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((indexPath.section == 0 && indexPath.row < 7)||(indexPath.section == 1 && indexPath.row <4)) {
        static NSString *ID1 = @"ID1";
        WL_Application_TourGuide_BasicInfo_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID1];
        if (cell == nil) {
            cell = [[WL_Application_TourGuide_BasicInfo_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID1];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        //标题信息(左边)
        cell.titleName.text = [[self.leftTitleAllArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        //详细信息（右边）
        cell.rightTitleName.text = [[self.rightTitleAllArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }
    else if ((indexPath.section == 0 && indexPath.row == 7)||(indexPath.section == 1 && indexPath.row == 4)){
        static NSString *ID2 = @"ID2";
        WL_Application_TourGuide_Picure_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID2];
        if (cell == nil) {
            cell = [[WL_Application_TourGuide_Picure_TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID2];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = [[_leftTitleAllArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.textColor = [WLTools stringToColor:@"#6f7378"];
            [cell setTextStr:indexPath];
        }
        if (indexPath.section == 0) {
            
            //身份证
            cell.imageView1.image = self.imageView1.image;
            cell.imageView2.image = self.imageView2.image;
            
        }
       
        else if (indexPath.section == 1){
            cell.imageView1.image = self.imageView3.image;
            cell.imageView2.image = self.imageView4.image;
        }
        
        __weak typeof(self)WeakSelfDict = self;
        cell.imageViewBack = ^(NSInteger tag){
            //
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:2];
            WL_Application_TourGuide_Picure_TableViewCell *cell = [WeakSelfDict.informationTableView cellForRowAtIndexPath:path];
            [cell resignFirstResponder];
            //
            //标记行
            WeakSelfDict.indexTag = tag;
            WeakSelfDict.indexSection = indexPath.section;
            
            //设置头像
            if (!_isNoInfo) {
                UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换照片" delegate:WeakSelfDict cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
                [actionSheet showInView:WeakSelfDict.view];
            }
            else
            {
                if (tag == 1) {
                    //cell.imageView1.image = imageData;
                    if (indexPath.section == 0) {
                        //self.imageView1.image = imageData;
                        if (self.guideInfoModel.IDCardImg.count != 0) {
                            WLTouristFileObject *modell = self.guideInfoModel.IDCardImg[0];
                            [self showImg:self.imageView1.image urlstr:modell.fileUrl];
                        }
                        else
                        {
                            [self showImg:self.imageView1.image urlstr:nil];
                        }
                        
                    }
                    else
                    {
                        //self.imageView3.image = imageData;
                        if (self.guideInfoModel.guideCardImg.count != 0) {
                            WLTouristFileObject *modell = self.guideInfoModel.guideCardImg[0];
                            [self showImg:self.imageView3.image urlstr:modell.fileUrl];
                        }
                        else
                        {
                            [self showImg:self.imageView3.image urlstr:nil];
                        }
                    }
                }
                else
                {
                    //cell.imageView2.image = imageData;
                    if (indexPath.section == 0) {
                        //self.imageView2.image = imageData;
                        if (self.guideInfoModel.IDCardImg.count != 0) {
                            WLTouristFileObject *modell = self.guideInfoModel.IDCardImg[1];
                            [self showImg:self.imageView2.image urlstr:modell.fileUrl];
                        }
                        else
                        {
                            [self showImg:self.imageView2.image urlstr:nil];
                        }
                    }
                    else
                    {
                        //self.imageView4.image = imageData;
                        if (self.guideInfoModel.guideCardImg.count != 0) {
                            WLTouristFileObject *modell = self.guideInfoModel.guideCardImg[1];
                            [self showImg:self.imageView4.image urlstr:modell.fileUrl];
                        }
                        else
                        {
                            [self showImg:self.imageView4.image urlstr:nil];
                        }
                    }
                    
                }
            }
            
        };
        return cell;
        
    }
    
    else if (indexPath.section == 2 ){
        if(indexPath.row == 0) {
            WL_Application_TourGuide_Price_TableViewCell4 *cell = [[WL_Application_TourGuide_Price_TableViewCell4 alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            
        }
        else
        {
            static NSString *ID3 = @"ID3";
            WL_Application_TourGuide_Price_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID3];
            if (cell == nil) {
                cell = [[WL_Application_TourGuide_Price_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID3];
                }
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            
            _priceList = [_priceListArray objectAtIndex:indexPath.row-1];
            //估计要改
            cell.rightLabel.text = [NSString stringWithFormat:@"%@/%@",_priceList.price, _priceList.priceName];
            return cell;
        }
    }
    else if(indexPath.section == 3){
        WL_Application_TourGuide_Remark_TableViewCell *cell = [[WL_Application_TourGuide_Remark_TableViewCell alloc] init];
        cell.inputTextView.delegate = self;
        cell.inputTextView.placeholder = @"请输入备注信息";
        cell.inputTextView.text = [NSString stringWithFormat:@"%@",(_bottomremark.length == 0)?@"":_bottomremark];//[self.rightTitleBottomArr objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
}

#pragma mark ---- 点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
    WL_Application_TourGuide_Remark_TableViewCell *cell = [self.informationTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];//使键盘隐藏
    self.selectedIndex = 0;
    
    if (!_isAllEditor) {
        // 弹框提示
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"资料处于不可编辑状态，如需编辑修改，请点击右上角的编辑"
                              delegate:self
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        return ;
    }
    
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    //姓名
                    WLApplicationGuideChangeInformatonViewController *guideVc = [[WLApplicationGuideChangeInformatonViewController alloc] init];
                    guideVc.indexPath = indexPath;
                    guideVc.senderStr = @"请输入您的姓名";
                    guideVc.delegate = self;
                    
                    guideVc.title = [_leftTitleTopArr objectAtIndex:indexPath.row];
                    guideVc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:guideVc animated:YES];
                }
                    break;
                case 1:
                {
                    //年龄
                    self.choseType = @"age";
                    self.didSelectStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    //隐藏动画
                    
                    [self showAndHidden:NO];
                }
                    break;
                    
                    
                case 2:
                {
                    //性别
                    self.choseType = @"sex";
                    self.didSelectStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    //隐藏动画
                    [self showAndHidden:NO];
                    
                }
                    break;
                    
                case 3:
                {
                    //联系电话
                    WLApplicationGuideChangeInformatonViewController *Vc = [[WLApplicationGuideChangeInformatonViewController alloc] init];
                    Vc.indexPath = indexPath;
                    Vc.delegate = self;
                    Vc.senderStr = @"请输入您的联系电话";//占位文字
                    Vc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];//前缀
                    Vc.title = [_leftTitleTopArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:Vc animated:YES];
                }
                    break;
                    
                case 4:{
                    //现居住城市
                    WL_Mine_personInfo_regionViewController *vc = [[WL_Mine_personInfo_regionViewController alloc] init];
                    vc.didStr = [_rightTitleTopArr objectAtIndex:4];
                    vc.proviceId =[WLTools judgeString:self.guideInfoModel.province]?self.guideInfoModel.province:@""; //self.perinfoModel.province_id;
                    vc.cityId = [WLTools judgeString:self.guideInfoModel.city]?self.guideInfoModel.city:@"";
                    vc.personInfo = @"Guide";
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case 5:{
                    //详细地址
                    WLApplicationGuideChangeInformatonViewController *vc = [[WLApplicationGuideChangeInformatonViewController alloc] init];
                    vc.senderStr = @"请输入您的详细地址";
                    vc.indexPath = indexPath;
                    vc.delegate = self;
                    vc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    vc.title = [_leftTitleTopArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                case 6:{
                    //身份证号
                    WLApplicationGuideChangeInformatonViewController *vc = [[WLApplicationGuideChangeInformatonViewController alloc] init];
                    vc.senderStr = @"请输入您的身份证号";
                    vc.indexPath = indexPath;
                    vc.delegate = self;
                    vc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                    vc.title = [_leftTitleTopArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 1:{
            //第二列
            switch (indexPath.row) {
                case 0:
                {
                    //导游级别
                    self.choseType = @"level";
                    self.didSelectStr = [_rightTitleCenterArr objectAtIndex:0];
                    //设置timePickView的hidden属性为NO；
                    [self showAndHidden:NO];
                }
                    break;
                    
                case 1:
                {
                    //导游证编号
                    WLApplicationGuideChangeInformatonViewController *vc = [[WLApplicationGuideChangeInformatonViewController alloc] init];
                    vc.indexPath =indexPath;
                    vc.delegate = self;
                    vc.senderStr = @"请输入的您的导游证编号";
                    //初始化作用
                    vc.infoStr = [_rightTitleCenterArr objectAtIndex:indexPath.row];
                    vc.title = [_leftTitleCenterArr objectAtIndex:indexPath.row];
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                    break;
                    
                case 2:
                {
                    //导游语种
                    self.choseType = @"language";
                    self.didSelectStr = [_rightTitleCenterArr objectAtIndex:indexPath.row];
                    //隐藏动画
                    [self showAndHidden:NO];
        
                }
                    break;
                    
                case 3:
                {
                    //从业时长
                    self.choseType = @"workYears";
                    self.didSelectStr = [_rightTitleCenterArr objectAtIndex:3];
                    //显示动画，pickview隐藏属性为NO
                    [self showAndHidden:NO];
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            WLApplicationGuidePriceDetailViewController *priceVc = [[WLApplicationGuidePriceDetailViewController alloc] init];
            if (indexPath.row == 0) {
                _isChangPrice = NO;
                priceVc.priceList = [[WLPriceListObject alloc] init];//[_priceListArray objectAtIndex:indexPath.row-1];
            }
            else
            {
                priceVc.priceList = [_priceListArray objectAtIndex:indexPath.row-1];
                _isChangPrice = YES;
                _reIndex = indexPath.row-1;
            }
            priceVc.delegate = self;
            [self.navigationController pushViewController:priceVc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}

#pragma mark ---- 左滑删除
//用原生实现左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLPriceListObject * deleteP = _priceListArray[indexPath.row - 1];
    _DeletepriceList = [[WLTouristGuideInfo alloc] init];
    _DeletepriceList.delPriceID = deleteP.priceID;

    if (deleteP.priceID != nil) {
        [self deltePriceList:_DeletepriceList index:indexPath];
    }
    else
    {
        [_priceListArray removeObjectAtIndex:indexPath.row - 1];
        
        // 局部刷新UITableViewRowAnimationFade
        [self.informationTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
//修改delete -> 删除
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)deltePriceList:(WLTouristGuideInfo *)priceID index:(NSIndexPath *)indexP
{
    [WLNetworkManager deleteTouristGuidePriceListWithInfo:priceID result:^(BOOL success, BOOL result) {
        if (success && result) {
            [[WL_TipAlert_View sharedAlert] createTip:@"删除成功"];
            
            [_priceListArray removeObjectAtIndex:indexP.row - 1];
            
            // 局部刷新UITableViewRowAnimationFade
            [self.informationTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexP] withRowAnimation:UITableViewRowAnimationFade];
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"删除失败"];
        }
    }];
    
}

#pragma mark --- 模型
-(WLTouristGuideInfo *)guideInfoModel
{
    if (_guideInfoModel == nil) {
        _guideInfoModel = [[WLTouristGuideInfo alloc] init];
    }
    return _guideInfoModel;
}



#pragma mark----通知改变信息的方法
// 选择城市地址
-(void)GuidechangeAddressBack:(NSNotification *)dict{
    if (dict) {
        self.guideInfoModel.province = dict.userInfo[@"proviceID"];//dict.userInfo[@"proviceName"];
        self.guideInfoModel.city = dict.userInfo[@"cityID"];//dict.userInfo[@"cityName"];
        self.guideInfoModel.area = dict.userInfo[@"countryID"];//dict.userInfo[@"countyName"];
        NSString *strAdd = @"";
        strAdd = dict.userInfo[@"address"];
        [self.rightTitleTopArr replaceObjectAtIndex:4 withObject:strAdd];
        WlLog(@"%@-------------", strAdd);
        
    }
    [self.informationTableView reloadData];
}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark----- 代理回调 WLApplicationGuideChangeInformatonViewControllerDelegate

-(void)changeGuideInformation:(WLApplicationGuideChangeInformatonViewController *)VC str:(NSString *)strImage index:(NSIndexPath *)path{
    
    NSLog(@"==%@",strImage);
    if (path == nil) {
        [_rightTitleCenterArr replaceObjectAtIndex:2 withObject:strImage];
        self.guideInfoModel.language = strImage;
    }
    else if (path.section == 0) {
        
        switch (path.row) {
            case 0:
                self.guideInfoModel.guideName = strImage;
                break;
            
            case 1:
                self.guideInfoModel.birthday = strImage;
                break;
                
            case 3:
                self.guideInfoModel.mobileNO = strImage;
                break;
                
            case 5:
                self.guideInfoModel.address = strImage;
                break;
                
            case 6:
                self.guideInfoModel.IDNO = strImage;
                break;
                
            default:
                break;
        }
        [_rightTitleTopArr replaceObjectAtIndex:path.row withObject:strImage];
    }
    else if (path.section == 1){
        if (path.row == 1) {
            self.guideInfoModel.cardNO = strImage;
        }
        
        [_rightTitleCenterArr replaceObjectAtIndex:path.row withObject:strImage];
    }
    
    [self.informationTableView reloadData];
    
}

// 添加报价的回调
-(void)passPriceInformation:(WLApplicationGuidePriceDetailViewController *)VC obj:(WLPriceListObject *)obj{
    
    if (_isChangPrice) {
        [_priceListArray removeObjectAtIndex:_reIndex];
    }
    [_priceListArray addObject:obj];

    [self.informationTableView reloadData];
}

#pragma mark ---- 选择年龄和性别
#pragma mark ---- 时间选择器
-(void)creatTimePickView
{
    CGFloat height,btnHeight,topHeiht;
    if (IsiPhone5||IsiPhone4) {
        height = 200;
        btnHeight = 35;
        topHeiht = 4;
    }
    else
    {
        height = 250;
        btnHeight = 40;
        topHeiht = 5;
    }
    self.choseType = @"age";
    _pickBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _pickBackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:_pickBackView];
    _pickBackView.hidden = YES;
    //选择器
    //性别选择器
    _chosePickView = [[UIPickerView alloc] init];
    _chosePickView.frame = CGRectMake(0, ScreenHeight-height, ScreenWidth, height);
    _chosePickView.backgroundColor = [UIColor whiteColor];
    _chosePickView.delegate = self;
    _chosePickView.dataSource = self;
    _chosePickView.userInteractionEnabled = YES;
    [_pickBackView addSubview:_chosePickView];
    UITapGestureRecognizer *timeViewHidenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTimeVew)];
    [_pickBackView addGestureRecognizer:timeViewHidenTap];
    //创建日期的轮播
    
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = CGRectMake(0, ScreenHeight-height-btnHeight, ScreenWidth, btnHeight);
    btnView.backgroundColor = [UIColor whiteColor];
    [_pickBackView addSubview:btnView];
    //取消按钮
    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap.frame = CGRectMake(5, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap addTarget:self action:@selector(timeFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap.tag = 801;
    [btnTap setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [btnTap setTitle:@"取消" forState:UIControlStateNormal];
    [btnView addSubview:btnTap];
    //确定按钮
    UIButton *btnTap2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap2.frame = CGRectMake(ScreenWidth-55, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap2 addTarget:self action:@selector(timeFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap2.tag = 802;
    [btnTap2 setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [btnTap2 setTitle:@"确定" forState:UIControlStateNormal];
    [btnView addSubview:btnTap2];
}

-(void)hiddenTimeVew{
    [self showAndHidden:YES];
}

//显示和隐藏的动画
-(void)showAndHidden:(BOOL)isHidden
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [_pickBackView.layer addAnimation:animation forKey:nil];
    _pickBackView.hidden = isHidden;
    
    if (isHidden == YES) {
        self.choseType = @"";
    }
    [self.chosePickView reloadAllComponents];
    
    
}

-(void)timeFrombtn:(UIButton *)btn{
    if (btn.tag == 801) {
        WlLog(@"点击了取消按钮");
    }
    else if(btn.tag == 802)
    {
        NSLog(@"%@",self.didSelectStr);
        //更新数据源
        if ([self.choseType isEqualToString:@"age"]) {
            self.didSelectStr = [self.arrAge objectAtIndex:self.selectedIndex];
            [_rightTitleTopArr replaceObjectAtIndex:1 withObject:self.didSelectStr];
            
            NSInteger date = [[self getDateStringFromDate:[NSDate date]] integerValue];
            NSInteger date2 = [self.didSelectStr integerValue];
            
            self.guideInfoModel.birthday = [NSString stringWithFormat:@"%ld-01-01",date - date2];//self.didSelectStr;//后台返回的是生日，得换算成年龄
        }
        else if ([self.choseType isEqualToString:@"sex"]) {
            self.didSelectStr = [self.arrSex objectAtIndex:self.selectedIndex];
            [_rightTitleTopArr replaceObjectAtIndex:2 withObject:self.didSelectStr];
            //self.guideInfoModel.sex = (NSUInteger)self.didSelectStr;
            //性别修改
            if ([self.didSelectStr isEqualToString:@"女"]) {
                self.guideInfoModel.sex = 0;
                _isSixnil = YES;
            }
            else
            {
                _isSixnil = YES;
                self.guideInfoModel.sex = 1;
            }
            
            
        }
        else if ([self.choseType isEqualToString:@"workYears"]) {
            self.didSelectStr = [self.arrWorkYears objectAtIndex:self.selectedIndex];
            [_rightTitleCenterArr replaceObjectAtIndex:3 withObject:self.didSelectStr];
            _isWYnil = YES;
            self.guideInfoModel.workYears = [self.didSelectStr integerValue];
        }
        else if ([self.choseType isEqualToString:@"level"]) {
            self.didSelectStr = [self.arrLevel objectAtIndex:self.selectedIndex];
            [_rightTitleCenterArr replaceObjectAtIndex:0 withObject:self.didSelectStr];
            _isLvnil = YES;
            if ([self.didSelectStr isEqualToString:@"初级"]) {
                self.guideInfoModel.level = 1;
            }
            else if ([self.didSelectStr isEqualToString:@"中级"])
            {
                self.guideInfoModel.level = 2;
            }
            else if ([self.didSelectStr isEqualToString:@"高级"])
            {
                self.guideInfoModel.level = 3;
            }
        }
        else if ([self.choseType isEqualToString:@"language"]){
            self.didSelectStr = [self.arrLanguage objectAtIndex:self.selectedIndex];
            if ([self.didSelectStr isEqualToString:@"其他语种"]) {
                WLApplicationGuideChangeInformatonViewController *guideVc = [[WLApplicationGuideChangeInformatonViewController alloc] init];
                //guideVc.indexPath = indexPath;
                guideVc.senderStr = @"请输入本人导游语种";
                guideVc.delegate = self;
                
                guideVc.title = @"语种";//[_leftTitleTopArr objectAtIndex:indexPath.row];
                //guideVc.infoStr = [_rightTitleTopArr objectAtIndex:indexPath.row];
                [self.navigationController pushViewController:guideVc animated:YES];
            }
            else
            {
                [_rightTitleCenterArr replaceObjectAtIndex:2 withObject:self.didSelectStr];
                self.guideInfoModel.language = self.didSelectStr;
            }
            
            
        }
        
    }
    [self.informationTableView reloadData];
    [self hiddenTimeVew];
}

#pragma mark --- 选择器数据源
-(void)creatDataSourceArr{
    //年龄
    self.arrAge = [[NSMutableArray alloc] init];
    for (int i = 10; i < 65; i++) {
        NSString *str = [NSString stringWithFormat:@"%d", i];
        [self.arrAge addObject:str];
    }
    
    //性别
    self.arrSex = [[NSMutableArray alloc] initWithObjects:@"女",@"男", nil];
    
    //导游级别
    self.arrLevel = [[NSMutableArray alloc] initWithObjects:@"初级",@"中级",@"高级",@"特级", nil];
    
    //从业时间
    self.arrWorkYears = [[NSMutableArray alloc] init];
    for (int i = 1; i < 31; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [self.arrWorkYears addObject:str];
    }
    
    //导游语种
    self.arrLanguage =  [[NSMutableArray alloc] initWithObjects:@"普通话", @"英语", @"其他语种",nil];
}

#pragma mark ---- UIPickerView的代理方法
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//返回行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([self.choseType isEqualToString:@"age"]) {
        return self.arrAge.count;
    }
    else if ([self.choseType isEqualToString:@"sex"]){
        return self.arrSex.count;
    }
    else if ([self.choseType isEqualToString:@"level"]){
        return self.arrLevel.count;
    }
    else if ([self.choseType isEqualToString:@"workYears"]){
        return self.arrWorkYears.count;
    }
    else if ([self.choseType isEqualToString:@"language"]){
        return self.arrLanguage.count;
    }
    
    return 0;
}

//每行（row）pickerView的内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if ([self.choseType isEqualToString:@"age"]) {
        return [self.arrAge objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"sex"]){
        return [self.arrSex objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"level"]){
        return [self.arrLevel objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"workYears"]){
        return [self.arrWorkYears objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"language"]){
        return [self.arrLanguage objectAtIndex:row];
    }
    return nil;
}

//点击时返回值给模型

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectedIndex = row;
    if ([self.choseType isEqualToString:@"age"]) {
        self.didSelectStr = [self.arrAge objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"workYears"]){
        self.didSelectStr = [self.arrWorkYears objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"level"]){
        self.didSelectStr = [self.arrLevel objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"sex"]){
        self.didSelectStr = [self.arrSex objectAtIndex:row];
    }
    else if ([self.choseType isEqualToString:@"language"]){
        self.didSelectStr = [self.arrLanguage objectAtIndex:row];
    }
    
}

-(NSString *)getDateStringFromDate:(NSDate *)date

{
    NSDateFormatter *formate =[[NSDateFormatter alloc]init];
    
    [formate setDateFormat:@"yyyy"];
    
    NSString *string =[formate stringFromDate:date];

    return  string;
}

#pragma mark----选择图片或者照相机
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            //照相
            //先判断是否有权限调用摄像头
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置-隐私-相机中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertView show];
                //  DLog(@"相机权限受限");
                return;
                
            }
            
            [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
            
        }
            break;
        case 1:
        {
            //相册
            [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
            break;
            
        default:
            break;
    }
}

//压缩图片
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(UIImagePickerController *)openPhotoToViewController:(UIViewController*)viewController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&&mediaTypes.count>0) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
        imagePick.mediaTypes = mediaTypes;
        imagePick.navigationBarHidden = YES;
        imagePick.allowsEditing = YES;
        imagePick.delegate = self;
        imagePick.sourceType = sourceType;
        [viewController presentViewController:imagePick animated:YES completion:nil];
        return imagePick;
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"设备不支持" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alert show];
    }
    return nil;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    //判断是静态图片还是视频
    UIImage *editedImage = nil;
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        
        if ([info objectForKey:UIImagePickerControllerEditedImage]!= nil) {
            
            //获取编辑之后的图片
            editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else
        {
            //获取原始的图像
            editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        //判断是调用的相机还是图片库，如果是照相机的话，将图像保存到媒体库
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            //将图片保存到媒体库
            UIImageWriteToSavedPhotosAlbum(editedImage, self, nil, NULL);
            
        }
        //        UIImage *image = [self imageWithImageSimple:editedImage scaledToSize:CGSizeMake(ScreenWidth, 500)];
        
        
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    //更新图片
    [self updataImageView:editedImage];
    
    
}

#pragma mark----更新图片
-(void)updataImageView:(UIImage *)imageData
{
    _isChangPhoto = YES;
    NSIndexPath *path = nil;
    if (self.indexSection==0) {
        path = [NSIndexPath indexPathForRow:7 inSection:0];
    }
    else
    {
        path = [NSIndexPath indexPathForRow:4 inSection:1];
    }
    WL_Application_TourGuide_Picure_TableViewCell *cell = [self.informationTableView cellForRowAtIndexPath:path];
    if (self.indexTag == 1) {
        cell.imageView1.image = imageData;
        
        if (self.indexSection == 0) {
            //self.imageView1.image = imageData;
            _isimageView1nil = YES;
            if (self.guideInfoModel.IDCardImg.count != 0) {
                WLTouristFileObject *modell = self.guideInfoModel.IDCardImg[0];
                [self deleteImgAction:modell.fileID newImg:imageData];
            }
            else
            {
                self.imageView1.image = imageData;
                self.hasChangePhoto1 = YES;
            }
        }
        else
        {
            //self.imageView3.image = imageData;
            _isimageView3nil = YES;
            if (self.guideInfoModel.guideCardImg.count != 0) {
                WLTouristFileObject *modell = self.guideInfoModel.guideCardImg[0];
                [self deleteImgAction:modell.fileID newImg:imageData];
            }
            else
            {
                self.imageView3.image = imageData;
                self.hasChangePhoto3 = YES;
            }
        }
    }
    else
    {
        cell.imageView2.image = imageData;
        if (self.indexSection == 0) {
            //self.imageView2.image = imageData;
            _isimageView2nil = YES;
            if (self.guideInfoModel.IDCardImg.count != 0) {
                WLTouristFileObject *modell = self.guideInfoModel.IDCardImg[1];
                [self deleteImgAction:modell.fileID newImg:imageData];
            }
            else
            {
                self.imageView2.image = imageData;
                self.hasChangePhoto2 = YES;
            }
        }
        else
        {
            //self.imageView4.image = imageData;
            _isimageView4nil = YES;
            if (self.guideInfoModel.guideCardImg.count != 0) {
                WLTouristFileObject *modell = self.guideInfoModel.guideCardImg[1];
                [self deleteImgAction:modell.fileID newImg:imageData];
            }
            else
            {
                self.imageView4.image = imageData;
                self.hasChangePhoto4 = YES;
            }
        }
    }
}

#pragma mark----创建图片保存的
-(void)creatUiImageViewImage
{
    CGFloat width,boreHeight;
    if (IsiPhone4||IsiPhone5) {
        width = (ScreenWidth-180+20+30)/2;
        boreHeight = 80;
        
    }
    else
    {
        width = (ScreenWidth-180)/2;
        boreHeight = 85;
        
        
    }

    self.imageView1 = [[UIImageView alloc] init];
    self.imageView1.frame = CGRectMake(0, 0, width, boreHeight);
    self.imageView1.image = [UIImage imageNamed:@"WLPersonInfoIDCardFont"];
    self.imageView2 = [[UIImageView alloc] init];
    self.imageView2.frame = CGRectMake(0, 0, width, boreHeight);
    self.imageView2.image = [UIImage imageNamed:@"WLPersonInfoIDCardBack"];
    self.imageView3 = [[UIImageView alloc] init];
    self.imageView3.frame = CGRectMake(0, 0, width, boreHeight);
    self.imageView3.image = [UIImage imageNamed:@"WLPersonInfoIDCardFont"];
    self.imageView4 = [[UIImageView alloc] init];
    self.imageView4.frame = CGRectMake(0, 0, width, boreHeight);
    self.imageView4.image = [UIImage imageNamed:@"WLPersonInfoIDCardBack"];
}

#pragma mark----输入代理
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //NSLog(@"代理返回==%i==%@",range,text);
    if ([text isEqualToString:@"\n"]) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
        WL_Application_TourGuide_Remark_TableViewCell *cell = [self.informationTableView cellForRowAtIndexPath:path];
        [cell.inputTextView resignFirstResponder];
        return NO;
    }
    else
    {
        return YES;
    }
}


#pragma mark-----键盘通知
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
    WL_Application_TourGuide_Remark_TableViewCell *cell = [self.informationTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    return YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
    WL_Application_TourGuide_Remark_TableViewCell *cell = [self.informationTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    
}

-(void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 取出键盘最终的frame
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 取出键盘弹出需要花费的时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改transform
    
    __weak typeof (self)WeakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height - rect.origin.y;
        WeakSelf.view.transform = CGAffineTransformMakeTranslation(0, -y);
        if (y == 0) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
            WL_Application_TourGuide_Remark_TableViewCell *cell = [WeakSelf.self.informationTableView cellForRowAtIndexPath:path];
            
            WeakSelf.guideInfoModel.remark = cell.inputTextView.text;
            if (!(cell.inputTextView.text == nil)) {
                [WeakSelf.rightTitleBottomArr replaceObjectAtIndex:0 withObject:cell.inputTextView.text];
            }
            else{
                cell.inputTextView.text = @"";
            }
            
        }
    }];
    
}

// 获取导游个人信息
- (void)getInfo
{
    [WLNetworkManager requestTouristGuidePersonalInfoWithResult:^(BOOL success, WLTouristGuideInfo *info) {

        if (info) {
            
            _isNoInfo = YES;
            [self setNavigationRightTitle:@"编辑" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
            _isAllEditor = NO;

            //-----------
            _isRunning = info.isRunning;
 
            self.guideInfoModel = [info mutableCopy];
            _SaveguideInfoModel = [info mutableCopy];

            [self showarchiveData];
            
        }
        else
        {
            NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString * fileName = [arr.firstObject stringByAppendingPathComponent:@"archiverModel"];

            NSData *undata = [[NSData alloc] initWithContentsOfFile:fileName];

            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:undata];

            WLTouristGuideInfo *unModel = [unarchiver decodeObjectForKey:@"firstModel"];
            
            if (unModel != nil) {
                self.guideInfoModel = unModel;
                [self showarchiveData];
            }

            [unarchiver finishDecoding];
            
            //
            [self setNavigationRightTitle:@"保存" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
            _isAllEditor = YES;
            _isNoInfo = NO;
        }
    }];
}

- (void)showarchiveData
{
    NSInteger date = [[self getDateStringFromDate:[NSDate date]] integerValue];
    NSInteger date2 = [[self.guideInfoModel.birthday substringToIndex:4] integerValue];
    
    [_rightTitleTopArr replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%@",(self.guideInfoModel.guideName == nil)?@"":self.guideInfoModel.guideName]];
    [_rightTitleTopArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%ld",((date - date2) == 0)?1:(date - date2)]];
    [_rightTitleTopArr replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@",((unsigned long)self.guideInfoModel.sex == 1)?@"男":@"女"]];
    [_rightTitleTopArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%@",(self.guideInfoModel.mobileNO == nil)?@"":self.guideInfoModel.mobileNO]];
    [_rightTitleTopArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@%@%@",(self.guideInfoModel.province == nil)?@"":self.guideInfoModel.province,(self.guideInfoModel.city == nil)?@"":self.guideInfoModel.city,(self.guideInfoModel.area == nil)?@"":self.guideInfoModel.area]];
    [_rightTitleTopArr replaceObjectAtIndex:5 withObject:[NSString stringWithFormat:@"%@",(self.guideInfoModel.address == nil)?@"":self.guideInfoModel.address]];//self.guideInfoModel.address
    [_rightTitleTopArr replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%@",(self.guideInfoModel.IDNO == nil)?@"":self.guideInfoModel.IDNO]];
    
    //照片
    if (self.guideInfoModel.IDCardImg.count != 0) {
        WLTouristFileObject *modell = self.guideInfoModel.IDCardImg[0];
        
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",modell.fileUrl]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
        
        if (self.guideInfoModel.IDCardImg.count != 1) {
            
            WLTouristFileObject *modelblack = self.guideInfoModel.IDCardImg[1];
            
            [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",modelblack.fileUrl]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
        }
    }
    else
    {
        [self.imageView1 setImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
        [self.imageView2 setImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
    }
    if (self.guideInfoModel.guideCardImg.count != 0) {
        WLTouristFileObject *modell = self.guideInfoModel.guideCardImg[0];
        
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",modell.fileUrl]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
        
        if (self.guideInfoModel.guideCardImg.count != 1) {
            
            WLTouristFileObject *modelblack = self.guideInfoModel.guideCardImg[1];
            
            [self.imageView4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",modelblack.fileUrl]] placeholderImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
        }
    }
    else
    {
        [self.imageView3 setImage:[UIImage imageNamed:@"WLPersonInfoIDCardFont"]];
        [self.imageView4 setImage:[UIImage imageNamed:@"WLPersonInfoIDCardBack"]];
    }
    
    for (WLPriceListObject *mode in self.guideInfoModel.priceList) {
        [_priceListArray addObject:mode];
    }
    
    NSString * levelStr = [[NSString alloc] init];
    
    if (self.guideInfoModel.level == 1) {
        levelStr = @"初级";
    }
    else if (self.guideInfoModel.level == 2)
    {
        levelStr = @"中级";
    }
    else if (self.guideInfoModel.level == 3)
    {
        levelStr = @"高级";
    }
    else
    {
        levelStr = @"";
    }
    
    [_rightTitleCenterArr replaceObjectAtIndex:0 withObject:levelStr];
    [_rightTitleCenterArr replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@",(self.guideInfoModel.cardNO == nil)?@"":self.guideInfoModel.cardNO]];
    [_rightTitleCenterArr replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%@",(self.guideInfoModel.language == nil)?@"":self.guideInfoModel.language]];
    [_rightTitleCenterArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%lu",(unsigned long)self.guideInfoModel.workYears]];
    
    _bottomremark = self.guideInfoModel.remark;
    
    [self.informationTableView reloadData];
}

#pragma mark ---- 进入时下载数据
- (void)loadGuideInfoFromServer
{
    [WLNetworkManager requestTouristGuideAuthenticationStatusWithResult:^(BOOL success, TouristGuideOauthStatus status, long long count, NSString *message) {

        if (success) {
            if (status == TouristGuideOauthStatusIning ) {
                //[self showHudWithString:@"正在审核"];
                _iSshowcertificationStr = NO;
            }
            else if (status == TouristGuideOauthStatusAlready){
                //[self showHudWithString:@"审核成功"];
                _iSshowcertificationStr = NO;
            }
            else if (status == TouristGuideOauthStatusFailure){
                //[self showHudWithString:@"审核失败"];
                
                _iSshowcertificationStr = YES;
                _certificationStr = message;
            }
        }
        [self.informationTableView reloadData];
        //[self hidHud];
    }];
}

-(void)reloadNewdataFromServer:(NSDictionary *)dict
{
    [self.guideInfoModel setValuesForKeysWithDictionary:dict];
    //第一section
    [self.rightTitleTopArr replaceObjectAtIndex:0 withObject:self.guideInfoModel.guideName];
    [self.rightTitleTopArr replaceObjectAtIndex:1 withObject:self.guideInfoModel.birthday];
    if (self.guideInfoModel.sex == 0) {
        [self.rightTitleTopArr replaceObjectAtIndex:2 withObject:@"女"];
    }
    else if(self.guideInfoModel.sex == 1)
    {
        [self.rightTitleTopArr replaceObjectAtIndex:2 withObject:@"男"];
    }
    
    [self.rightTitleTopArr replaceObjectAtIndex:3 withObject:self.guideInfoModel.mobileNO];
    [self.rightTitleTopArr replaceObjectAtIndex:4 withObject:[NSString stringWithFormat:@"%@-%@-%@",self.guideInfoModel.province, self.guideInfoModel.city, self.guideInfoModel.area]];
    [self.rightTitleTopArr replaceObjectAtIndex:5 withObject:self.guideInfoModel.address];
    [self.rightTitleTopArr replaceObjectAtIndex:6 withObject:self.guideInfoModel.IDNO];
    
    //第二section
    [self.rightTitleCenterArr replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%ld",self.guideInfoModel.level]];
    [self.rightTitleCenterArr replaceObjectAtIndex:1 withObject:self.guideInfoModel.cardNO];
    [self.rightTitleCenterArr replaceObjectAtIndex:2 withObject:self.guideInfoModel.language];
    [self.rightTitleCenterArr replaceObjectAtIndex:3 withObject:[NSString stringWithFormat:@"%ld", self.guideInfoModel.workYears]];
    
    //身份证
}

#pragma mark----点击返回
- (void)NavigationLeftEvent
{
    if (!_isNoInfo) {
        self.guideInfoModel.IDFrontImg = self.imageView1.image;
        self.guideInfoModel.IDBackImg = self.imageView2.image;
        self.guideInfoModel.cardIDFrontImg = self.imageView3.image;
        self.guideInfoModel.cardIDBackImg = self.imageView4.image;
    
        if (_priceListArray.count != 0) {
            self.guideInfoModel.priceList = _priceListArray;
        }
    
        if (_bottomremark.length != 0) {
            self.guideInfoModel.remark = _bottomremark;
        }
        else
        {
            self.guideInfoModel.remark = @"";
        }
    
    
        NSMutableData * data = [[NSMutableData alloc] init];
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:self.guideInfoModel forKey:@"firstModel"];
        [archiver finishEncoding];
        
        NSArray * arr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * fileName = [arr.firstObject stringByAppendingPathComponent:@"archiverModel"];
        if (self.guideInfoModel != nil) {
            if ([data writeToFile:fileName atomically:YES]) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}

#pragma mark----点击保存
-(void)NavigationRightEvent
{
    if (_isRunning) {
        // 弹框提示
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您当前有尚未出发或结束的订单，无法编辑。"
                              delegate:self
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (_isAllEditor) {
        [self setNavigationRightTitle:@"编辑" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
        _isAllEditor = NO;
        
        [self senderinfo];
    }
    else
    {
        [self setNavigationRightTitle:@"保存" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
        _isAllEditor = YES;
    }
}

- (void)senderinfo
{
    if ([self isNull] || _guideInfoModel == nil) {
        [[WL_TipAlert_View sharedAlert] createTip:@"填写信息不完整"];
        return;
    }
//    if (_guideInfoModel == nil) {
//        [[WL_TipAlert_View sharedAlert] createTip:@"填写信息不完整"];
//        return;
//    }
    if (self.hasChangePhoto1) {
        self.guideInfoModel.IDFrontImg = self.imageView1.image;
    }
    if (self.hasChangePhoto2) {
        self.guideInfoModel.IDBackImg = self.imageView2.image;
    }
    if (self.hasChangePhoto3) {
        self.guideInfoModel.cardIDFrontImg = self.imageView3.image;
    }
    if (self.hasChangePhoto4) {
        self.guideInfoModel.cardIDBackImg = self.imageView4.image;
    }
    if (_priceListArray.count != 0) {
        self.guideInfoModel.priceList = _priceListArray;
    }
    
    if (_bottomremark.length != 0) {
        self.guideInfoModel.remark = _bottomremark;
    }
    else
    {
        self.guideInfoModel.remark = @"";
    }
    
    
    [self showHudWithString:@""];
    //NSLog(@"==%i",[self isChangeMainMessage]);
    [[WLNetworkTouristHandler sharedInstance] submmitTouristGuidePersonalInfoWithInfo:_guideInfoModel needAudits:[self isChangeMainMessage] result:^(BOOL success, BOOL result) {
        
        [self hidHud];
        if(success){
            
            if (success == YES && result == YES) {

                [self getInfo];
                [[WL_TipAlert_View sharedAlert] createTip:@"保存成功"];
                [self setNavigationRightTitle:@"编辑" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
                _isAllEditor = NO;
            }
            else
            {
                [[WL_TipAlert_View sharedAlert] createTip:@"保存失败"];
            }
        }
        else
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"保存失败"];
        }
        
    }];
}

- (BOOL)isNull
{
        
    if ([self isNullStr:self.guideInfoModel.guideName] ||
        [self isNullStr:self.guideInfoModel.birthday] ||
        [self isNullStr:self.guideInfoModel.mobileNO] ||
        [self isNullStr:self.guideInfoModel.province] ||
        [self isNullStr:self.guideInfoModel.address] ||
        [self isNullStr:self.guideInfoModel.cardNO] ||
        [self isNullStr:self.guideInfoModel.language])
    {
        return YES;
    }
    
    // sex
    //level
    //workYears
    if (_isNoInfo) {
//        if (_guideInfoModel.IDCardImg.count != 0 && _guideInfoModel.guideCardImg.count != 0) {
//            _isimageView1nil = YES;
//        }
        return NO;
    }
    else
    {
        if (_isLvnil && _isWYnil && _isSixnil) {
            //return NO;
        }
        else
        {
            return YES;
        }
        
        if (_isimageView1nil && _isimageView2nil && _isimageView3nil && _isimageView4nil) {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)isNullStr:(NSString *)Str
{
    if (Str == nil || Str.length == 0) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isChangeMainMessage
{
    if (!_isNoInfo) {
        return YES;
    }
    if ([self isChangeMainMessage:self.SaveguideInfoModel.guideName str:self.guideInfoModel.guideName] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.birthday str:self.guideInfoModel.birthday] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.mobileNO str:self.guideInfoModel.mobileNO] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.province str:self.guideInfoModel.province] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.city str:self.guideInfoModel.city] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.area str:self.guideInfoModel.area] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.IDNO str:self.guideInfoModel.IDNO] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.address str:self.guideInfoModel.address] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.cardNO str:self.guideInfoModel.cardNO] ||
        [self isChangeMainMessage:self.SaveguideInfoModel.language str:self.guideInfoModel.language])
    {
        return YES;
    }

    if (!(self.SaveguideInfoModel.sex == self.guideInfoModel.sex)) {
        return YES;
    }
    if (!(self.SaveguideInfoModel.level == self.guideInfoModel.level)) {
        return YES;
    }

    if (!(self.SaveguideInfoModel.workYears == self.guideInfoModel.workYears)) {
        return YES;
    }

    if (_isChangPhoto) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isChangeMainMessage:(NSString *)Str1 str:(NSString *)Str2
{
    if (![Str1 isEqualToString:Str2]) {
        return YES;
    }
    return NO;
}

#pragma mark----字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


#pragma mark----创建弹出框
-(void)creatPersonAlertView
{
    self.AlertTitle = [WL_TipAlert_View sharedAlert];
}

// 照片查看器
- (void)showImg:(UIImage *)Img urlstr:(NSString *)Imgurl
{
    __weak __typeof(self)weakSelf = self;
    
    WLPhotoCheckView * imgView = [[WLPhotoCheckView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) image:Img imageUrl:[NSURL URLWithString:Imgurl] tapAction:^{
        //[imgView removeFromSuperview];
        
        [weakSelf.checkView removeFromSuperview];
        weakSelf.checkView = nil;
        
    } modifyAction:^(BOOL isDelete){
        
        if (!_isAllEditor) {
            // 弹框提示
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"提示"
                                  message:@"资料处于可编辑状态时，才能更换照片资料。"
                                  delegate:self
                                  cancelButtonTitle:@"知道了"
                                  otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        else
        {
            //设置头像
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换照片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
            [actionSheet showInView:self.view];
        }
        
        [weakSelf.checkView removeFromSuperview];
        weakSelf.checkView = nil;
    }];
    
    [self.navigationController.view addSubview:imgView];
    
    self.checkView = imgView;
}

- (void)deleteImgAction:(NSString *)imgID newImg:(UIImage *)newImgStr
{
    WLTouristGuideInfo * modell = [[WLTouristGuideInfo alloc] init];
    modell.delFileID = imgID;
    //_guideInfoModel.
    
    [WLNetworkManager deleteTouristGuideImageWithInfo:modell result:^(BOOL success, BOOL result) {
        NSLog(@"");
        if (success && result) {
            if (self.indexTag == 1) {
                //cell.imageView1.image = imageData;
                if (self.indexSection == 0) {
                    self.imageView1.image = newImgStr;
                }
                else
                {
                    self.imageView3.image = newImgStr;
                }
            }
            else
            {
                //cell.imageView2.image = imageData;
                if (self.indexSection == 0) {
                    self.imageView2.image = newImgStr;
                }
                else
                {
                    self.imageView4.image = newImgStr;
                }
                
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
