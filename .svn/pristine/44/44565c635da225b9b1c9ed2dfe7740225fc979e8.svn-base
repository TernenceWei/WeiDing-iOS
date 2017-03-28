//
//  WL_Application_Driver_addCar_viewController.m
//  WeiLvDJS
//
//  Created by liuxin on 16/9/21.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//  编辑车辆

#import "WL_Application_Driver_addCar_viewController.h"

#import "WL_Application_AddCarListInfo_TableViewCell.h"//基本信息
#import "WL_Application_addListMoney_TableViewCell.h"//添加结算方式的cell
#import "WL_Application_Driver_inforMation_TableViewCell3.h"//车辆备注
#import "WL_Application_Driver_changeCarInformation_ViewController.h" //修改信息

#import "WL_Application_addCarPhoto_TableViewCell.h"//添加图片

#import "WL_Application_CarAddPhoto_CollectionViewCell.h"//图片载体

#import <AVFoundation/AVFoundation.h>//相机
#import <AssetsLibrary/AssetsLibrary.h>//相册

#import "WL_Mine_personInfo_regionViewController.h"//选择地区
#import "WL_Application_Car_Company_TableViewCell.h"//公司信息的cell

#import "WL_Application_carListInformation_model.h"  //上个界面带来的数据
#import "WL_Application_carListInformation_Bom_model.h"//公司model
#import "WL_Application_Driver_Pricelist_Model.h" //报价方式

#import "WL_Application_Driver_inforMation_TableViewCell2.h"
#import "WL_Application_Driver_OrderTipView.h"
#import "WL_Application_Driver_inforMation_TableViewCell0.h"
#import "WLApplicationCarHandler.h"
#import "WL_warmPrompt_View.h"
#import "WLApplicationCarChoiceViewController.h"
#import "WLApplicationAuthenticationTipCell.h"
#import "TLDatePickerAppearance.h"
#import "WLNetworkCarBookingHandler.h"
@interface WLCustomImageView:UIImageView
/**< 图片id */
@property (nonatomic, copy) NSString *picID;
@property (nonatomic, copy) NSString *fileType;//5行驶证正面照片 6行驶证反面照片 7车辆相关图片 8车辆营运证
@property (nonatomic, copy) NSString *name;/**< 图片名字 */
@property (nonatomic, copy) NSString *filePath;//图片路径
@end

@implementation WLCustomImageView


@end
@interface WL_Application_Driver_addCar_viewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,WL_Application_Driver_changeCarInformation_ViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, ClickButtonDelegate>
@property(nonatomic,strong)NSMutableArray *arrLeftAllTitle;//左侧全部标题
@property(nonatomic,strong)NSMutableArray *arrLeftTopTitle;
@property(nonatomic,strong)NSMutableArray *arrLeftCenter1Title;
@property(nonatomic,strong)NSMutableArray *arrLeftCenter2Title;
@property(nonatomic,strong)NSMutableArray *arrLeftCenter2Title22;
@property(nonatomic,strong)NSMutableArray *arrLeftCenter3Title;
@property(nonatomic,strong)NSMutableArray *arrLeftBottomTitle;
//
@property(nonatomic,strong)NSMutableArray *arrRightAllTitle;//右侧全部标题
@property(nonatomic,strong)NSMutableArray *arrRightTopTitle;
@property(nonatomic,strong)NSMutableArray *placeholderArr; /**< 右侧占位文字 */
@property(nonatomic,strong)NSMutableArray *arrRightCenter2Title;
@property(nonatomic,strong)NSMutableArray *arrRightCenter3Title;

@property(nonatomic,strong)NSMutableArray *leftFirstArr;

@property(nonatomic,strong)NSMutableArray *rightFirstArr;

@property(nonatomic,strong)NSMutableArray *arrRightBottomTitle;
@property(nonatomic,strong)NSMutableArray *addTapArr;//新增的公司点击标示
@property(nonatomic,strong)NSMutableArray *editTapArr;//编辑的公司点击标示
@property(nonatomic,strong)NSMutableArray *editChangeTapArr;//编辑的公司点击标示,更改了必选项
@property(nonatomic,strong)NSMutableArray *editCahngeModelArr;//编辑
@property(nonatomic,strong)WL_TipAlert_View *AddCarWarTitle;//弹出提示框
//tableView
@property(nonatomic,strong)UITableView *CarInfoListTableView;

//选择器
@property(nonatomic,strong)UIView *pickYearView;
@property (nonatomic, weak) UIDatePicker *datePicker;
@property(nonatomic,strong)UIPickerView *choseYearPickView;

@property(nonatomic,strong)NSMutableArray *arrYear;//年限
@property(nonatomic,assign)NSInteger isYear;
@property(nonatomic,strong)NSString *didSelectYear;

@property(nonatomic,strong)UIView *showPhotoView;//查看图片的view

@property(nonatomic,strong)UIImageView *showPhotoImageView;
//图片存放的数组
@property(nonatomic,strong)NSMutableArray *arrShowPhotoImage;

@property(nonatomic,strong)WLCustomImageView *driverimg1;
@property(nonatomic,strong)WLCustomImageView *driverimg2;
@property (nonatomic, strong) WLCustomImageView *businessLicenseImg;

@property(nonatomic,assign)BOOL isAddShowPhoto;
@property(nonatomic,assign)NSInteger didSelect;
//车辆所有信息模型
@property(nonatomic,strong) WLApplicationCarInfodataModel *isChangeModel;
//车辆信息模型
@property(nonatomic,strong)WLApplicationCarInfocar_infoModel *InfoModel;
//图片信息模型
@property (nonatomic, strong) WLApplicationCarInfoimgsModel *imageModel;

//记录备注信息

@property(nonatomic,copy)NSString *infoRemark;

//@property(nonatomic,assign)BOOL isDrivingLicense;//行驶证按钮点击

@property(nonatomic,assign)NSInteger indexTag;

@property(nonatomic,assign)NSInteger indexSection;

@property(nonatomic,assign)CGFloat height;//第一分区的高度；

@property(nonatomic,assign)BOOL image1Set;
@property(nonatomic,assign)BOOL image2Set;

@property (nonatomic, assign) BOOL imagesSet;//判断是否设置过图片

@property (nonatomic, assign) BOOL editBaseInfo;//是否修改了基本信息
@property(nonatomic,strong)WL_warmPrompt_View *warningWindow;

@property(nonatomic,assign)BOOL canEdit;//能否编辑

/***表头内容***/
@property (nonatomic, strong) NSArray * TableHeadArr;
@property (nonatomic, copy) NSString *companyName; //公司名字
@property (nonatomic, assign) WLPictureType pictureType; //图片类型
@property (nonatomic, assign) WLPictureOperation pictureOperation;//图片操作状态
@property (nonatomic, copy) NSString *car_id;

@property (nonatomic, strong) NSMutableArray *unAuthorizedArrayM;

@end

@implementation WL_Application_Driver_addCar_viewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.canEdit = NO;
    self.isEdit  = NO;
    //查看图片的view
    self.showPhotoView.hidden = YES;
    self.indexTag = 101;
    
    _TableHeadArr = @[@"车辆基本信息",@"车辆相关图片",@"资质主体",@"报价信息",@"备注信息"];
    
    self.view.backgroundColor = BgViewColor;
    [self creatTimerView];
    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(customerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)NavigationLeftEvent
{
    if([self.carStatus integerValue] == -1){ //未认证
        //保存编辑的基本数据
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"carBaseInfo.plist"];
        WLApplicationCarInfocar_infoModel *carBaseInfoModel = [[WLApplicationCarInfocar_infoModel alloc]init];
        carBaseInfoModel.brand = [self.arrRightTopTitle objectAtIndex:0];
        carBaseInfoModel.model = [self.arrRightTopTitle objectAtIndex:1];
        carBaseInfoModel.seat_amount = [self.arrRightTopTitle objectAtIndex:2];
        carBaseInfoModel.number = [self.arrRightTopTitle objectAtIndex:3];
        carBaseInfoModel.first_enabled_at = [self.arrRightTopTitle objectAtIndex:4];
        carBaseInfoModel.day_pricing = [self.arrRightTopTitle objectAtIndex:5];
        carBaseInfoModel.kilometer_pricing = [self.arrRightTopTitle objectAtIndex:6];
        carBaseInfoModel.body_name = self.companyName;
        carBaseInfoModel.memo = self.infoRemark;
        [NSKeyedArchiver archiveRootObject:carBaseInfoModel toFile:path]; //归档
    }
    [super NavigationLeftEvent];
}
#pragma mark----界面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
   
}

- (void)loadData{
    
    if([self.carStatus isEqualToString:@"-1"])
    {
        self.CarInfoListTableView.backgroundColor = BgViewColor;
        self.title = @"车辆编辑";
        [self setNavigationRightTitle:@"提交" fontSize:15 titleColor:Color1 isEnable:YES];
        self.pictureOperation = WLPictureOperationAdd;
        self.canEdit = YES;
        self.isEdit = YES;
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"carBaseInfo.plist"];
        WLApplicationCarInfocar_infoModel *carBaseInfoModel = [NSKeyedUnarchiver unarchiveObjectWithFile:path];//解档
        if (carBaseInfoModel && carBaseInfoModel.number) {
            [self.arrRightTopTitle replaceObjectAtIndex:0 withObject:carBaseInfoModel.brand];
            [self.arrRightTopTitle replaceObjectAtIndex:1 withObject:carBaseInfoModel.model];
            [self.arrRightTopTitle replaceObjectAtIndex:2 withObject:carBaseInfoModel.seat_amount];
            [self.arrRightTopTitle replaceObjectAtIndex:3 withObject:carBaseInfoModel.number];
            [self.arrRightTopTitle replaceObjectAtIndex:4 withObject:carBaseInfoModel.first_enabled_at];
            if(carBaseInfoModel.day_pricing){
                [self.arrRightTopTitle replaceObjectAtIndex:5 withObject:carBaseInfoModel.day_pricing];
            }
            if(carBaseInfoModel.kilometer_pricing){
                [self.arrRightTopTitle replaceObjectAtIndex:6 withObject:carBaseInfoModel.kilometer_pricing];
            }
  
            self.companyName = carBaseInfoModel.body_name;
            self.infoRemark = carBaseInfoModel.memo;
            [self.CarInfoListTableView reloadData];
        }
    }else {
        //请求车辆信息
        self.CarInfoListTableView.backgroundColor = BgViewColor;
        [self loadCarInfomationFromServer];
        self.title = @"车辆资料";
        [self setNavigationRightTitle:@"编辑" fontSize:15 titleColor:Color1 isEnable:YES];
        self.isEdit = NO;
    }
}


- (WL_warmPrompt_View *)warningWindow
{
    if (_warningWindow==nil) {
        
        _warningWindow =[[WL_warmPrompt_View alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    _warningWindow.delegate =self;
    
    return _warningWindow;
    
}

#pragma mark----tableView
-(UITableView *)CarInfoListTableView
{
    if (_CarInfoListTableView == nil) {
        
        _CarInfoListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _CarInfoListTableView.delegate = self;
        _CarInfoListTableView.dataSource = self;
        _CarInfoListTableView.backgroundColor = BgViewColor;
        
        [_CarInfoListTableView setShowsVerticalScrollIndicator:NO];
        
        [self.view addSubview:self.CarInfoListTableView];
        
    }
    return _CarInfoListTableView;
}
#pragma mark----tableDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (section == 1) {
        return 6;
    }else if(section == 3||section == 4)
    {
        return 2;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        if(!self.isEdit){
            if ([self.carStatus isEqualToString:@"2"]) {
                
                return self.height;
            }else if ([self.carStatus isEqualToString:@"1"]||[self.carStatus isEqualToString:@"0"])
            {
                if (IsiPhone5) {
                    return 120;
                }
                return ScaleH(110);
            }
        }
        return 0.01;
    }else if(indexPath.section == 5){
        //备注信息
        return ScaleH(110);
    }else if((indexPath.section==1&&indexPath.row==5) || (indexPath.section==3&&indexPath.row==1)||indexPath.section == 2) {
        
        return ScaleH(120);
    }
    
    
    return ScaleH(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return nil;
    }
    else
    {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [WLTools stringToColor:@"#f2f2f2"];
        view.frame = CGRectMake(0, 0, ScreenWidth, 40);
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 10, ScreenWidth-10, 20);
        label.textAlignment = NSTextAlignmentLeft;
        label.font = WLFontSize(14);
        label.textColor = [WLTools stringToColor:@"#929292"];
        [view addSubview:label];
        label.text = _TableHeadArr[section-1];
        
        return view;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark---不让头视图悬浮
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat sectionHeaderHeight = 0;
    CGFloat sectionFooterHeight = 15;
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 0 && offsetY <= sectionHeaderHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= sectionHeaderHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, -sectionFooterHeight, 0);
    }else if (offsetY >= scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight && offsetY <= scrollView.contentSize.height - scrollView.frame.size.height)
    {
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -(scrollView.contentSize.height - scrollView.frame.size.height - sectionFooterHeight), 0);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0)
    {
        if (!self.isEdit) {
            if ([self.carStatus isEqualToString:@"2"]) {
                
                static NSString *cellIndentifier0 = @"cellIndentifier0";
                WL_Application_Driver_inforMation_TableViewCell0 *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier0];
                if (cell == nil) {
                    cell = [[WL_Application_Driver_inforMation_TableViewCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier0];
                }
                cell.noPassReasonLabel.text = self.InfoModel.audit_memo;
                
                return cell;
            }else if ([self.carStatus isEqualToString:@"0"]){
                WLApplicationAuthenticationTipCell *authenticationTipCell = [WLApplicationAuthenticationTipCell cellForTableView:tableView];
                authenticationTipCell.tipImageView.image = [UIImage imageNamed:@"shenhezhongNew"];
                authenticationTipCell.statusLabel.text = @"审核中!";
                return authenticationTipCell;
            }else if ([self.carStatus isEqualToString:@"1"]){
                WLApplicationAuthenticationTipCell *authenticationTipCell = [WLApplicationAuthenticationTipCell cellForTableView:tableView];
                authenticationTipCell.tipImageView.image = [UIImage imageNamed:@"renzhengchenggong"];
                authenticationTipCell.statusLabel.text = @"已认证成功!";
                return authenticationTipCell;
            }
        }
        return [UITableViewCell new];
    }else if (indexPath.section == 1)
    {
        if (indexPath.row == 5) {
            static NSString *cellIndentifier2 = @"cellIndentifier2";
            WL_Application_Driver_inforMation_TableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
            if (cell == nil) {
                cell = [[WL_Application_Driver_inforMation_TableViewCell2 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier2];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            }
            
            cell.textLabel.text = @"行驶证";
            cell.textLabel.textColor = Color2;
            cell.textLabel.font = WLFontSize(14);
            
            cell.label1.text = @"行驶证正页";
            cell.label2.text = @"行驶证副页";
            cell.imageView2.hidden = NO;
            cell.label2.hidden = NO;
            
            
            if ([self.carStatus isEqualToString:@"-1"]) {
                
                cell.imageView1.image = self.driverimg1.image ?: [UIImage imageNamed:@"upload"];
                cell.imageView2.image = self.driverimg2.image ?: [UIImage imageNamed:@"upload"];;
            }else{
                
                if (self.driverimg1.image) {
                    cell.imageView1.image = self.driverimg1.image;
                }else{
                    [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.driverimg1.filePath] placeholderImage:[UIImage imageNamed:@"upload"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        self.driverimg1.image = image;
                    }];
                }
                
                if (self.driverimg2.image) {
                    cell.imageView2.image = self.driverimg2.image;
                }else{
                    
                    [cell.imageView2 sd_setImageWithURL:[NSURL URLWithString:self.driverimg2.filePath] placeholderImage:[UIImage imageNamed:@"upload"] options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        
                        self.driverimg2.image = image;
                    }];
                }
            }
            
            
            __weak typeof(cell)weakCell = cell;
            WS(weakSelf);
            cell.imageViewBack = ^(NSInteger tag){
                
                if (self.isEdit==NO) {
                    
                    return;
                }
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
                WL_Application_Driver_inforMation_TableViewCell3 *cell3 = [weakSelf.CarInfoListTableView cellForRowAtIndexPath:path];
                [cell3.inputTextView resignFirstResponder];
                
                //标记行
                weakSelf.indexTag = tag;
                weakSelf.indexSection = indexPath.section;
                weakSelf.pictureType = WLPictureTypeDriver; //驾驶证
                if (weakSelf.canEdit == NO) {//查看照片
                    weakSelf.showPhotoImageView.hidden = NO;
                    weakSelf.showPhotoImageView.image = weakSelf.indexTag==101?weakCell.imageView1.image:weakCell.imageView2.image;
                    [weakSelf showPhotoViewHidden:NO];
                    UIButton *button =(UIButton *)[self.showPhotoView viewWithTag:301];
                    button.enabled =NO;
                    
                }else if(weakSelf.canEdit == YES)
                {
                    if (weakSelf.indexTag == 101) {
                        
                        if ([weakCell.imageView1.image isEqual:[UIImage imageNamed:@"upload"]])
                        {
                            weakSelf.pictureOperation = WLPictureOperationAdd;//增加图片
                            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"新增图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
                            [actionSheet showInView:self.view];
                            
                        }else if(![weakCell.imageView1.image isEqual:[UIImage imageNamed:@"upload"]])
                        {
                            weakSelf.pictureOperation = WLPictureOperationEdit;//编辑图片
                            weakSelf.showPhotoImageView.hidden =NO;
                            
                            weakSelf.showPhotoImageView.image= weakCell.imageView1.image;
                            
                            [weakSelf showPhotoViewHidden:NO];
                        }
                    }else if (weakSelf.indexTag == 102)
                    {
                        if ([weakCell.imageView2.image isEqual:[UIImage imageNamed:@"upload"]])
                        {
                            self.pictureOperation = WLPictureOperationAdd;//增加图片
                            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"新增图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
                            [actionSheet showInView:self.view];
                            
                        }else if(![weakCell.imageView2.image isEqual:[UIImage imageNamed:@"upload"]])
                        {
                            weakSelf.pictureOperation = WLPictureOperationEdit;//编辑图片
                            weakSelf.showPhotoImageView.hidden =NO;
                            
                            weakSelf.showPhotoImageView.image= weakCell.imageView2.image;
                            
                            [weakSelf showPhotoViewHidden:NO];
                        }
                    }
                    
                    
                }
                
                
            };
            
            return cell;
            
        }
        static NSString *cellIndentifier1 = @"cellIndentifier1";
        WL_Application_AddCarListInfo_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        if (cell == nil) {
            cell = [[WL_Application_AddCarListInfo_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier1];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        
        cell.textLabel.text = self.arrLeftTopTitle[indexPath.row];
        if (indexPath.row == 4) {//首次启用日期
            if (self.arrRightTopTitle[4]!=nil && [self.arrRightTopTitle[4] length] >0) {
                
               NSString *startTime =  [WLUITool timeIntervalWithTimeString:self.arrRightTopTitle[4] formatter:@"yyyy年MM月dd日"];
                long long change = ([[NSDate date] timeIntervalSince1970] - startTime.doubleValue);
                
               int result = (int)[[NSString getDateStringWithTime:[NSString stringWithFormat:@"%lld",change] andFormatter:@"yyyy"] integerValue] - 1970;
                cell.rightTitle.text = [NSString stringWithFormat:@"%d年",result];
            }else{
                cell.rightTitle.text = self.placeholderArr[indexPath.row];
            }
            
        }else{
            cell.rightTitle.text = self.arrRightTopTitle[indexPath.row];
            if (cell.rightTitle.text == nil ||cell.rightTitle.text.length ==0) {
                cell.rightTitle.text = self.placeholderArr[indexPath.row];
            }
        }
        cell.textLabel.font = WLFontSize(15);
        cell.textLabel.textColor = Color2;
        cell.nextImage.hidden = self.isEdit==YES?NO:YES;
        return cell;
    }else if (indexPath.section == 2)
    {
        static NSString *cellIndentifierPhoto = @"cellIndentifierPhoto";
        WL_Application_addCarPhoto_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifierPhoto];
        if (cell == nil) {
            cell = [[WL_Application_addCarPhoto_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifierPhoto];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        cell.PhotoCollectView.delegate = self;
        cell.PhotoCollectView.dataSource = self;
        
        [cell.PhotoCollectView reloadData];
        
        return cell;
    }else if (indexPath.section == 3)
    {
        if (indexPath.row == 0) {
            static NSString *cellIndentifier1 = @"cellIndentifier1";
            WL_Application_AddCarListInfo_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
            if (cell == nil) {
                cell = [[WL_Application_AddCarListInfo_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier1];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            }
            
            cell.textLabel.text = @"公司名称";
            cell.textLabel.font = WLFontSize(15);
            cell.textLabel.textColor = Color2;
            cell.rightTitle.text = (self.companyName == nil||self.companyName.length == 0)?self.placeholderArr[5]:self.companyName;
            cell.nextImage.hidden = self.isEdit==YES?NO:YES;
            return cell;
        }else if (indexPath.row ==1)
        {
            static NSString *cellIndentifier2 = @"cellIndentifier2";
            WL_Application_Driver_inforMation_TableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
            if (cell == nil) {
                cell = [[WL_Application_Driver_inforMation_TableViewCell2 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier2];
                cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            }
            cell.textLabel.text = @"营运证";
            cell.textLabel.textColor = Color2;
            cell.textLabel.font = WLFontSize(15);
            
            if ([self.carStatus isEqualToString:@"-1"]) {
                
                cell.imageView1.image = self.businessLicenseImg.image ?: [UIImage imageNamed:@"upload"];
            }else{
                
                [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:self.businessLicenseImg.filePath] placeholderImage:[UIImage imageNamed:@"upload"]];
            }
            
            cell.imageView2.hidden = YES;
            cell.label2.hidden = YES;
            
            __weak typeof(cell)weakCell = cell;
            WS(weakSelf);
            
            cell.imageViewBack = ^(NSInteger tag){
                
                if (self.isEdit==NO) {
                    
                    return;
                }
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
                WL_Application_Driver_inforMation_TableViewCell3 *cell3 = [weakSelf.CarInfoListTableView cellForRowAtIndexPath:path];
                [cell3.inputTextView resignFirstResponder];
                
                //标记行
                weakSelf.indexTag = tag;
                weakSelf.indexSection = indexPath.section;
                weakSelf.pictureType = WLPictureTypeLicense;//营运证
                if (!self.canEdit) {
                    
                    
                    weakSelf.showPhotoImageView.hidden =NO;
                    
                    weakSelf.showPhotoImageView.image= weakCell.imageView1.image;
                    
                    [self showPhotoViewHidden:NO];
                    
                    
                    
                    UIButton *button =(UIButton *)[self.showPhotoView viewWithTag:301];
                    button.enabled =NO;
                    
                }else
                {
                    if ([weakCell.imageView1.image isEqual:[UIImage imageNamed:@"upload"]])
                    {
                        weakSelf.pictureOperation = WLPictureOperationAdd;//增加图片
                        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"新增图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
                        [actionSheet showInView:self.view];
                        
                    }else if(![weakCell.imageView1.image isEqual:[UIImage imageNamed:@"upload"]])
                    {
                        weakSelf.pictureOperation = WLPictureOperationEdit;
                        weakSelf.showPhotoImageView.hidden =NO;
                        
                        weakSelf.showPhotoImageView.image= weakCell.imageView1.image;
                        
                        [self showPhotoViewHidden:NO];
                        
                    }
                    
                }
                
            };
            
            
            return cell;
        }
    }
    else if (indexPath.section == 4)
    {
        static NSString *cellIndentifier1 = @"cellIndentifier1";
        WL_Application_AddCarListInfo_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
        if (cell == nil) {
            cell = [[WL_Application_AddCarListInfo_TableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier1];
//            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        cell.textLabel.text = self.arrLeftBottomTitle[indexPath.row];
        cell.textLabel.font = WLFontSize(15);
        cell.textLabel.textColor = Color2;
        NSString *priceStr = self.arrRightTopTitle[5+indexPath.row];
        if (indexPath.row == 0) {
            cell.rightTitle.text = [WLTools judgeString:priceStr]?[NSString stringWithFormat:@"%@ 元/天",self.arrRightTopTitle[5]]:self.placeholderArr[6];
        }else if (indexPath.row == 1){
            cell.rightTitle.text = [WLTools judgeString:priceStr]?[NSString stringWithFormat:@"%@ 元/公里",self.arrRightTopTitle[6]]:self.placeholderArr[7];
        }
        cell.nextImage.hidden = self.isEdit==YES?NO:YES;
        return cell;
    }
    else if (indexPath.section == 5)
    {
        
        static NSString *cellIndentifier3 = @"cellIndentifier3";
        WL_Application_Driver_inforMation_TableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier3];
        if (cell == nil) {
            cell = [[WL_Application_Driver_inforMation_TableViewCell3 alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIndentifier3];
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        }
        cell.inputTextView.delegate = self;
        
//        [cell.inputTextView addTarget:self action:@selector(didTextViewInput:) forControlEvents:UIControlEventValueChanged];
        cell.inputTextView.placeholder = @"请输入备注信息";
        cell.inputTextView.returnKeyType = UIReturnKeyDone;
        
        cell.inputTextView.text = self.infoRemark;
        
        CGFloat toolBarH = ScaleH(35);
        //给键盘 添加 setInputAccessoryView 可以点击完成 让键盘退出
        UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, toolBarH)];
        [topView setBarStyle:UIBarStyleDefault];
        topView.backgroundColor = [UIColor whiteColor];
        
        UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoardHidden)];
        NSArray * buttonsArray = @[btnSpace,doneButton];
        
        [topView setItems:buttonsArray];
        
        //  cell.inputTextView.inputAccessoryView = topView;
        
        
        return cell;
        
    }
    return nil;
}



-(void)dismissKeyBoardHidden
{
    
    [self.view endEditing:YES];
}

#pragma mark---定制cell删除按钮
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    // 添加一个删除按钮
//    WS(cellSelf);
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
//
//        if (self.canEdit==NO) {
//
//            [[WL_TipAlert_View sharedAlert]createTip:@"您确认编辑之后才能删除"];
//
//            return;
//        }
//
//         [cellSelf.arrRightCenter2Title removeObjectAtIndex:indexPath.row];
//         [cellSelf.arrLeftCenter2Title removeObjectAtIndex:indexPath.row];
//
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
//        [cellSelf.CarInfoListTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//
//    }];
//
//    deleteRowAction.backgroundColor = [UIColor redColor];
//    return @[deleteRowAction];
//}
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    if (indexPath.section == 3&&indexPath.row<self.arrLeftCenter2Title.count-1) {
//        return  UITableViewCellEditingStyleDelete;
//
//    }
//    return UITableViewCellEditingStyleNone;
//}
#pragma mark-----点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isEdit==NO) {
        
        return;
    }
    
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.CarInfoListTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 5)
        {
            self.imagesSet = YES;
        }
        else if(indexPath.row == 1)
        {
            self.editBaseInfo = YES;//编辑了基本信息
            WS(weakSelf);
            WLApplicationCarChoiceViewController *carChoiceViewControlle = [[WLApplicationCarChoiceViewController alloc]init];
            carChoiceViewControlle.carChoiceBlock = ^(NSString *type)
            {
                 [weakSelf.arrRightTopTitle replaceObjectAtIndex:1 withObject:type];
                 [weakSelf.CarInfoListTableView reloadData];
            };
            [self.navigationController pushViewController:carChoiceViewControlle animated:YES];
        }
        else if(indexPath.row == 2)
        {
            NSString *carType = [self.arrRightTopTitle objectAtIndex:1];
            if (carType == nil || carType.length == 0) {
                [self.AddCarWarTitle createTip:@"请先选择车辆类型"];
                return;
            }else
            {
                /**< 请求车辆类型 */
                [self loadCarSeatNumbers];
            }
            

        }
        else if(indexPath.row == 4)
        {
            self.editBaseInfo = YES;//编辑了基本信息
            //            self.pickYearView.hidden = NO;
            WS(weakSelf);
            TLDatePicker *picker = [[TLDatePicker alloc]initWithDatePickerMode:DatePickerDateMode MinDate:[NSDate dateWithTimeIntervalSince1970:315504000] MaxDate:[NSDate date]];
            TLDatePickerAppearance *datePicker = [[TLDatePickerAppearance alloc]initWithDatePicker:picker DatePickerMode:DatePickerDateMode completeBlock:^(NSDate *date) {
                
                [weakSelf.arrRightTopTitle replaceObjectAtIndex:4 withObject:[NSString changeDateToStringWith:date andFormatter:@"yyyy年MM月dd日"]];
                [weakSelf.CarInfoListTableView reloadData];
            }];
            [datePicker show];
        }
        else
        {
            self.editBaseInfo = YES;//编辑了基本信息
            WL_Application_Driver_changeCarInformation_ViewController *VC = [[WL_Application_Driver_changeCarInformation_ViewController alloc] init];
            VC.title = [self.arrLeftTopTitle objectAtIndex:indexPath.row];
            VC.bringStr = [self.arrRightTopTitle objectAtIndex:indexPath.row];
            VC.indexPath = indexPath;
            VC.delegate = self;
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
    else if (indexPath.section == 3 && indexPath.row == 0)
    {
        self.editBaseInfo = YES;//编辑了基本信息
        WL_Application_Driver_changeCarInformation_ViewController *VC = [[WL_Application_Driver_changeCarInformation_ViewController alloc] init];
        VC.title = [self.arrLeftCenter2Title22 objectAtIndex:indexPath.row];
        VC.bringStr = self.companyName;
        VC.indexPath = indexPath;
        VC.delegate = self;
        [self.navigationController pushViewController:VC animated:YES];
    }else if(indexPath.section == 4)
    {
        self.editBaseInfo = YES;//编辑了基本信息
        WL_Application_Driver_changeCarInformation_ViewController *VC = [[WL_Application_Driver_changeCarInformation_ViewController alloc] init];
        VC.title = [self.arrLeftBottomTitle objectAtIndex:indexPath.row];
        VC.bringStr = [self.arrRightTopTitle objectAtIndex:indexPath.row + 5];
        VC.indexPath = indexPath;
        VC.delegate = self;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark----创建左侧数据源
-(NSMutableArray *)arrLeftTopTitle
{
    if (_arrLeftTopTitle == nil) {
        
        _arrLeftTopTitle = [[NSMutableArray alloc] initWithObjects:@"车辆品牌",@"车辆类型",@"座位数",@"车牌号码",@"车龄",@"行驶证",nil];
    }
    return _arrLeftTopTitle;
}


-(NSMutableArray *)arrLeftCenter2Title22
{
    if (_arrLeftCenter2Title22 == nil) {
        
        _arrLeftCenter2Title22 = [[NSMutableArray alloc] initWithObjects:@"公司名称",@"运营证", nil];
    }
    return _arrLeftCenter2Title22;
}

-(NSMutableArray *)arrLeftCenter1Title
{
    if (_arrLeftCenter1Title == nil) {
        
        _arrLeftCenter1Title = [[NSMutableArray alloc] initWithObjects:@" ", nil];
    }
    return _arrLeftCenter1Title;
}
-(NSMutableArray *)arrLeftCenter3Title
{
    if (_arrLeftCenter3Title == nil) {
        
        _arrLeftCenter3Title = [[NSMutableArray alloc] initWithObjects:@" ",nil];
    }
    return _arrLeftCenter3Title;
}
-(NSMutableArray *)arrLeftBottomTitle
{
    if (_arrLeftBottomTitle == nil) {
        
        _arrLeftBottomTitle = [[NSMutableArray alloc] initWithObjects:@"按天计价",@"按公里计价",nil];
    }
    return _arrLeftBottomTitle;
}
-(NSMutableArray *)arrLeftAllTitle
{
    if (_arrLeftAllTitle == nil) {
        
        _arrLeftAllTitle = [[NSMutableArray alloc] initWithObjects:self.leftFirstArr,self.arrLeftTopTitle,self.arrLeftCenter1Title,self.arrLeftCenter2Title22,self.arrLeftCenter3Title,self.arrLeftBottomTitle, nil];
    }
    return _arrLeftAllTitle;
}


-(NSMutableArray *)leftFirstArr
{
    if (_leftFirstArr==nil) {
        
        _leftFirstArr = [[NSMutableArray alloc]initWithObjects:@"", nil];
    }
    
    return _leftFirstArr;
}

-(NSMutableArray *)rightFirstArr
{
    if (_rightFirstArr==nil) {
        
        _rightFirstArr =[NSMutableArray arrayWithObjects:@"", nil];
    }
    return _rightFirstArr;
}
#pragma mark----修改了必选项之后的数据信息
-(NSMutableArray *)editCahngeModelArr
{
    if (_editCahngeModelArr == nil) {
        
        _editCahngeModelArr = [[NSMutableArray alloc] init];
    }
    return _editCahngeModelArr;
}

#pragma mark----创建右侧数据源
-(NSMutableArray *)arrRightTopTitle
{
    if (_arrRightTopTitle == nil) {
        
        _arrRightTopTitle= [[NSMutableArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"",@"",@"", nil];
    }
    return _arrRightTopTitle;
}
-(NSMutableArray *)placeholderArr
{
    if (_placeholderArr == nil) {
        
        _placeholderArr = [[NSMutableArray alloc] initWithObjects:@"未填写",@"未选择(必选)",@"请填写车辆可载客数量(必填)",@"请输入车牌号码(必填)",@"未填写", @"未填写",@"未填写", @"未填写",nil];
    }
    return _placeholderArr;
}
-(NSMutableArray *)arrRightCenter2Title
{
    if (_arrRightCenter2Title == nil) {
        
        _arrRightCenter2Title = [[NSMutableArray alloc] initWithObjects:@"", nil];
    }
    return _arrRightCenter2Title;
}
-(NSMutableArray *)arrRightCenter3Title
{
    if (_arrRightCenter3Title == nil) {
        
        _arrRightCenter3Title = [[NSMutableArray alloc] initWithObjects:@" ", nil];
    }
    return _arrRightCenter3Title;
}
-(NSMutableArray *)arrRightBottomTitle
{
    if (_arrRightBottomTitle == nil) {
        
        _arrRightBottomTitle = [[NSMutableArray alloc] initWithObjects:@"",@"",@"", @"",@"",@"",nil];
    }
    return _arrRightBottomTitle;
}
-(NSMutableArray *)arrRightAllTitle
{
    if (_arrRightAllTitle == nil) {
        
        _arrRightAllTitle = [[NSMutableArray alloc] initWithObjects:self.rightFirstArr,self.arrRightTopTitle,self.placeholderArr,self.arrRightCenter3Title,self.arrRightBottomTitle, nil];
    }
    return _arrRightAllTitle;
}


#pragma mark 键盘出现
- (void)customerKeyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.CarInfoListTableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
    CGRect rect =[self.CarInfoListTableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:5]];
    
    [self.CarInfoListTableView scrollRectToVisible:rect animated:YES];
}
#pragma mark 键盘消失
- (void)customerKeyboardWillHide:(NSNotification *)aNotification
{
    self.CarInfoListTableView.contentInset = UIEdgeInsetsZero;
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.CarInfoListTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    
    
    
}

#pragma mark----输入代理
#define MAX_LIMIT_NUMS 100
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.isEdit==NO) {
        
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.editBaseInfo = YES;
    UITextRange *selectedRange = [textView markedTextRange];
    //获取高亮部分
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    
    //如果在变化中是高亮部分在变，就不要计算字符了
    if (selectedRange && pos) {
        return;
    }
    
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum > MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符(由于超出截部分在should时被处理了所在这里这了提高效率不再判断)
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        [textView setText:s];
        
    }


}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
//                NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
//                WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.CarInfoListTableView cellForRowAtIndexPath:path];
//                [cell.inputTextView resignFirstResponder];
//                self.infoRemark = cell.inputTextView.text;
        
        return NO;
    }
    else
    {
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
        //获取高亮部分内容
        //NSString * selectedtext = [textView textInRange:selectedRange];
        
        //如果有高亮且当前字数开始位置小于最大限制时允许输入
        if (selectedRange && pos) {
            NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
            NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
            NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
            
            if (offsetRange.location < MAX_LIMIT_NUMS) {
                return YES;
            }
            else
            {
                [self.AddCarWarTitle createTip:@"只能输入100个字符或50个汉字"];
                return NO;
            }
        }
        
        
        NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
        
        NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
        
        if (caninputlen >= 0)
        {
            return YES;
        }
        else
        {
            NSInteger len = text.length + caninputlen;
            //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
            NSRange rg = {0,MAX(len,0)};
            
            if (rg.length > 0)
            {
                NSString *s = @"";
                //判断是否只普通的字符或asc码(对于中文和表情返回NO)
                BOOL asc = [text canBeConvertedToEncoding:NSASCIIStringEncoding];
                if (asc) {
                    s = [text substringWithRange:rg];//因为是ascii码直接取就可以了不会错
                }
                else
                {
                    __block NSInteger idx = 0;
                    __block NSString  *trimString = @"";//截取出的字串
                    //使用字符串遍历，这个方法能准确知道每个emoji是占一个unicode还是两个
                    [text enumerateSubstringsInRange:NSMakeRange(0, [text length])
                                             options:NSStringEnumerationByComposedCharacterSequences
                                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                                              
                                              if (idx >= rg.length) {
                                                  *stop = YES; //取出所需要就break，提高效率
                                                  return ;
                                              }
                                              
                                              trimString = [trimString stringByAppendingString:substring];
                                              
                                              idx++;
                                          }];
                    
                    s = trimString;
                }
                //rang是指从当前光标处进行替换处理(注意如果执行此句后面返回的是YES会触发didchange事件)
                [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
            }
            [self.AddCarWarTitle createTip:@"只能输入100个字符或50个汉字"];
            return NO;  
        }
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.CarInfoListTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    
    self.infoRemark = cell.inputTextView.text;
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.CarInfoListTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
    
    self.infoRemark = cell.inputTextView.text;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
    WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.CarInfoListTableView cellForRowAtIndexPath:path];
    [cell.inputTextView resignFirstResponder];
}
#pragma mark-----修改车辆基本信息的回调
-(void)changeCarInforMation:(WL_Application_Driver_changeCarInformation_ViewController *)VC Str:(NSString *)strImage index:(NSIndexPath *)pathIndex
{
    
    if (pathIndex.section == 3 &&pathIndex.row == 0) {
        self.companyName = strImage;
         self.isChange = YES;
    }else if(pathIndex.section == 4)
    {
        if(pathIndex.row == 0)
        {
            if (![self.InfoModel.day_pricing isEqualToString:strImage]) {
                self.isChange = YES;
            }
        }else if (pathIndex.row == 1)
        {
            if (![self.InfoModel.kilometer_pricing isEqualToString:strImage]) {
                self.isChange = YES;
            }
        }
       
     [self.arrRightTopTitle replaceObjectAtIndex:pathIndex.row+5 withObject:strImage];
    }
    else
    {
        if (pathIndex.row==0) {
            //车辆品牌
            if (![self.InfoModel.brand isEqualToString:strImage]) {
                self.isChange = YES;
            }
        }
        else if (pathIndex.row == 1)
        {
            //车辆型号
            if (![self.InfoModel.model isEqualToString:strImage]) {
                
                self.isChange = YES;
                
                if ([strImage isEqualToString:@"1"]) {
                    strImage = @"大巴";
                }else if([strImage isEqualToString:@"2"])
                {
                    strImage = @"商务车";
                }else if([strImage isEqualToString:@"4"])
                {
                    strImage = @"小汽车";
                }else
                {
                    strImage = @"其它";
                }
            }
        }else if (pathIndex.row == 2)
        {
            //车辆座位数
            if (![self.InfoModel.seat_amount isEqualToString:strImage]) {
                
                self.isChange = YES;
            }
        }
        else if (pathIndex.row == 3)
        {
            //车牌号码
            if (![self.InfoModel.number isEqualToString:strImage]) {
                self.isChange = YES;
            }
        }
        else if (pathIndex.row == 4)
        {
            //首次启用日期
            if (![ [NSString getDateStringWithTime:self.InfoModel.first_enabled_at andFormatter:@"yyyy年MM月dd日"] isEqualToString:strImage]) {
                self.isChange = YES;
            }
        }
        
        [self.arrRightTopTitle replaceObjectAtIndex:pathIndex.row withObject:strImage];
    }
  
    //刷新第一个分区
    //    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [self.CarInfoListTableView reloadData];
    //    [self.CarInfoListTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
#pragma mark----时间选择器
-(void)creatTimerView
{
    CGFloat height,btnHeight,topHeiht;
    if (IsiPhone5||IsiPhone4) {
        height = 150;
        btnHeight = 35;
        topHeiht = 4;
    }
    else
    {
        height = 200;
        btnHeight = 40;
        topHeiht = 5;
    }
    
    _pickYearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _pickYearView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:_pickYearView];
    _pickYearView.hidden = YES;

//    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, ScreenHeight-height, ScreenWidth, height)];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh-hands"];
//    datePicker.backgroundColor = [WLTools stringToColor:@"#ffffff"];
//    NSDate *maxDate = [[NSDate alloc]initWithTimeIntervalSinceNow:24*60*60];
//    NSDate *minDate = [[NSDate alloc]initWithTimeIntervalSince1970:315504000];
//    datePicker.maximumDate = maxDate;
//    datePicker.minimumDate = minDate;
//    self.datePicker = datePicker;
    _choseYearPickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight-height, ScreenWidth, height)];
    _choseYearPickView.backgroundColor = [WLTools stringToColor:@"#ffffff"];
    _choseYearPickView.dataSource = self;
    _choseYearPickView.delegate = self;
    [_pickYearView addSubview:_choseYearPickView];
   
    UITapGestureRecognizer *timeViewHidenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenTimeVew)];
    [_pickYearView addGestureRecognizer:timeViewHidenTap];
    //创建日期的轮播
    
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = CGRectMake(0, ScreenHeight-height-btnHeight, ScreenWidth, btnHeight);
    btnView.backgroundColor = [UIColor whiteColor];
    [_pickYearView addSubview:btnView];
    //取消按钮
    UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap.frame = CGRectMake(5, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap addTarget:self action:@selector(timeFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap.tag = 501;
    [btnTap setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [btnTap setTitle:@"取消" forState:UIControlStateNormal];
    [btnView addSubview:btnTap];
    //确定按钮
    UIButton *btnTap2 = [UIButton buttonWithType:UIButtonTypeSystem];
    btnTap2.frame = CGRectMake(ScreenWidth-55, topHeiht, 50, btnHeight-2*topHeiht);
    [btnTap2 addTarget:self action:@selector(timeFrombtn:) forControlEvents:UIControlEventTouchUpInside];
    btnTap2.tag = 502;
    [btnTap2 setTintColor:[WLTools stringToColor:@"#4977e7"]];
    [btnTap2 setTitle:@"确定" forState:UIControlStateNormal];
    [btnView addSubview:btnTap2];
}

#pragma mark----出生日期的选择和取消按钮
-(void)timeFrombtn:(UIButton *)btn
{
    if (btn.tag == 501) {
        //取消按钮被点击
        WlLog(@"取消按钮呗点击");
    }
    else
    {
        if (self.didSelectYear == nil) {
            self.didSelectYear = @"";
        }
        [self.arrRightTopTitle replaceObjectAtIndex:2 withObject:self.didSelectYear];
        [self.CarInfoListTableView reloadData];
    }
    
    [self hiddenTimeVew];
    
}
//时间轮播点击空白时候隐藏事件
-(void)hiddenTimeVew
{
    [self showAndHidden:YES];
}
//显示和隐藏的动画
-(void)showAndHidden:(BOOL)isHidden
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [_pickYearView.layer addAnimation:animation forKey:nil];
    
    _pickYearView.hidden = isHidden;
    
}

#pragma mark-----选择器数据源
//- (NSMutableArray *)arrYear
//{
//    //座位数
//    if (_arrYear == nil) {
//        
//        _arrYear = @[@"02",@"03",@"04",@"05",@"07",@"09",@"15",@"17",@"33",@"37",@"45",@"49",@"53",@"61"].mutableCopy;
//        
//    }
//    return _arrYear;
//}


#pragma mark-----pickerView代理
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.arrYear.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.arrYear objectAtIndex:row];
    
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.didSelectYear = [self.arrYear objectAtIndex:row];
    
    if (self.isEdit) {
        self.editBaseInfo = YES;
    }
    
}
#pragma mark- 瀑布流代理UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if ([self.carStatus isEqualToString:@"-1"]) {
        
        NSInteger count = self.unAuthorizedArrayM.count;
        
        return count == 5 ? 5 : count + 1;
        
    }else{
        if (self.arrShowPhotoImage.count==0) {
            return 1;
        }
        else if (self.arrShowPhotoImage.count<5)
        {
            return self.arrShowPhotoImage.count+1;
        }
        else if (self.arrShowPhotoImage.count == 5)
        {
            return 5;
        }
        return 5;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    WL_Application_CarAddPhoto_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CarPhotoCell" forIndexPath:indexPath];
    
    if ([self.carStatus isEqualToString:@"-1"]) { //未认证
        if (self.unAuthorizedArrayM.count==0) {
            cell.phptoImage.image = [UIImage imageNamed:@"upload"];
        }
        else if (self.unAuthorizedArrayM.count<5)
        {
            if (indexPath.row == self.unAuthorizedArrayM.count) {
                
                cell.phptoImage.image = [UIImage imageNamed:@"upload"];
            }
            else
            {
                cell.phptoImage.image = self.unAuthorizedArrayM[indexPath.row];
                
            }
        }
        else if (self.unAuthorizedArrayM.count == 5)
        {
            cell.phptoImage.image = self.unAuthorizedArrayM[indexPath.row];
        }
        
        return cell;
        
    }else{
        
        if (self.arrShowPhotoImage.count==0) {
            cell.phptoImage.image = [UIImage imageNamed:@"upload"];
        }
        else if (self.arrShowPhotoImage.count<5)
        {
            if (indexPath.row==self.arrShowPhotoImage.count) {
                
                cell.phptoImage.image = [UIImage imageNamed:@"upload"];
                
            }
            else
            {
                WLCustomImageView *imageView = self.arrShowPhotoImage[indexPath.row];
                [cell.phptoImage sd_setImageWithURL:[NSURL URLWithString:imageView.filePath]];
            }
        }
        else if (self.arrShowPhotoImage.count == 5)
        {
            WLCustomImageView *imageView = self.arrShowPhotoImage[indexPath.row];
            
            [cell.phptoImage sd_setImageWithURL:[NSURL URLWithString:imageView.filePath]];
        }
        
        
        return cell;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (ScreenWidth>320) {
        return UIEdgeInsetsMake(0, 15, 0, 25);
        
    }
    return UIEdgeInsetsMake(0, 15, 0, 20);//上,左,下,右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (self.isEdit == NO) {
        
        return;
    }
    //不是行驶证的时候
    self.pictureType = WLPictureTypeCar;
    self.imagesSet = YES;//编辑了图片
    UIButton *button = (UIButton *)[self.showPhotoView viewWithTag:301];
    button.enabled =YES;
    
    
    WL_Application_addCarPhoto_TableViewCell *TableViewCell = [self.CarInfoListTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    WL_Application_CarAddPhoto_CollectionViewCell *cell = (WL_Application_CarAddPhoto_CollectionViewCell *)[TableViewCell.PhotoCollectView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
    
    
    if ([cell.phptoImage.image isEqual:[UIImage imageNamed:@"upload"]]) {
        
        //添加图片
        self.pictureOperation = WLPictureOperationAdd;
        //保存选中图片的下标
        self.didSelect = indexPath.row;
        //设置头像
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        [actionSheet showInView:self.view];
    }
    //    }else if (cell.phptoImage.image&&![cell.phptoImage.image isEqual:[UIImage imageNamed:@"upload"]])
    //    {
    //        //添加图片
    //        self.pictureOperation = WLPictureOperationEdit;
    //
    //        self.didSelect = indexPath.row;
    //        //设置头像
    //        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    //        [actionSheet showInView:self.view];
    //    }
    else
    {
        self.pictureOperation = WLPictureOperationEdit;
        self.isAddShowPhoto = NO;
        //        self.showPhotoView.hidden = NO;
        
        self.showPhotoImageView.image = [cell.phptoImage.image copy];
        //查看图片
        self.didSelect = indexPath.row;
        
        [self showPhotoViewHidden:NO];
        
    }
    
}
#pragma mark-----查看图片
-(UIView *)showPhotoView
{
    if (_showPhotoView == nil) {
        _showPhotoView = [[UIView alloc] init];
        _showPhotoView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _showPhotoView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        _showPhotoView.userInteractionEnabled = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:_showPhotoView];
        _showPhotoView.hidden = YES;
        [_showPhotoView addSubview:self.showPhotoImageView];
        //添加点击隐藏的事件
        UITapGestureRecognizer *showPhotoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPhototFromSupperView)];
        [_showPhotoView addGestureRecognizer:showPhotoTap];
        //添加点击事件
        //删除按钮
        UIButton *btnTap = [UIButton buttonWithType:UIButtonTypeSystem];
        btnTap.frame = CGRectMake(10, ScreenHeight- 50, 50, 30);
        [btnTap addTarget:self action:@selector(photoShowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnTap.tag = 301;
        [btnTap setTintColor:[UIColor whiteColor]];
        [btnTap setTitle:@"删除" forState:UIControlStateNormal];
        
        [_showPhotoView addSubview:btnTap];
        //确定按钮
        UIButton *btnTap2 = [UIButton buttonWithType:UIButtonTypeSystem];
        btnTap2.frame = CGRectMake(ScreenWidth-60, ScreenHeight-50, 50, 30);
        [btnTap2 addTarget:self action:@selector(photoShowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btnTap2.tag = 302;
        [btnTap2 setTintColor:[UIColor whiteColor]];
        [btnTap2 setTitle:@"更改" forState:UIControlStateNormal];
        [_showPhotoView addSubview:btnTap2];
        
    }else
    {
        UIButton *deleBurtton = [_showPhotoView viewWithTag:301];
        if ([self.carStatus integerValue] != -1) {
            deleBurtton.hidden = self.pictureType == WLPictureTypeCar?NO:YES;
        }else {
            deleBurtton.hidden = NO;
        }
        
    }
    return _showPhotoView;
}
-(NSMutableArray *)arrShowPhotoImage
{
    if (_arrShowPhotoImage == nil) {
        
        _arrShowPhotoImage = [[NSMutableArray alloc] init];
        
    }
    return _arrShowPhotoImage;
}
#pragma mark---查看图片的图片显示载体
-(UIImageView *)showPhotoImageView
{
    if (_showPhotoImageView == nil) {
        
        _showPhotoImageView = [[UIImageView alloc] init];
        
        if (IsiPhone5||IsiPhone4) {
            
            _showPhotoImageView.frame = CGRectMake(0, 100, ScreenWidth, 300);
        }
        else
        {
            _showPhotoImageView.frame = CGRectMake(0, 200, ScreenWidth, 300);
        }
        
        _showPhotoImageView.backgroundColor = [UIColor whiteColor];
        
        [_showPhotoImageView setUserInteractionEnabled:YES];
        
        [_showPhotoImageView setMultipleTouchEnabled:YES];
    }
    return _showPhotoImageView;
}

// 添加所有的手势
- (void)addGestureRecognizerToView:(UIView *)view
{
    // 旋转手势
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [view addGestureRecognizer:rotationGestureRecognizer];
    
    // 缩放手势
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [view addGestureRecognizer:pinchGestureRecognizer];
    
    // 移动手势
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [view addGestureRecognizer:panGestureRecognizer];
}

// 处理旋转手势
- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}

// 处理缩放手势
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
        pinchGestureRecognizer.scale = 1;
    }
}

// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}
#pragma mark --- 删除 或者更改图片
-(void)photoShowBtnClick:(UIButton *)btn
{
    if (btn.tag == 301) {
        
        
        // WlLog(@"删除按钮被点击");
        //        if (self.isEdit&&self.arrShowPhotoImage.count<3) {
        //            [self.AddCarWarTitle createTip:@"车辆照片不能少于2张"];
        //            return;
        //        }
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除该照片？" delegate:self cancelButtonTitle:@"删除" otherButtonTitles:@"否", nil];
        
        alerView.tag =102;
        [alerView show];
        
        
    }
    else if(btn.tag == 302)
    {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"更换图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
        actionSheet.tag = 601;
        [actionSheet showInView:self.showPhotoView];
    }
}
-(void)showPhototFromSupperView
{
    [self showPhotoViewHidden:YES];
    
}
//隐藏的动画
-(void)showPhotoViewHidden:(BOOL)isHidden
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    if (IsiPhone5||IsiPhone4)
    {
        _showPhotoImageView.frame = CGRectMake(0, 100, ScreenWidth, 300);
    }
    else
    {
        _showPhotoImageView.frame = CGRectMake(0, 200, ScreenWidth, 300);
    }
    
    [self.showPhotoView.layer addAnimation:animation forKey:nil];
    
    self.showPhotoView.hidden = isHidden;
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag == 102)//删除图片的弹窗
    {
        if (buttonIndex == 0) {//删除
            if ([self.carStatus isEqualToString:@"-1"]) {
                
                if (self.pictureType == WLPictureTypeDriver) {
                    
                    if (self.indexTag == 101) {
                        self.driverimg1 = nil;
                    }else
                    {
                        self.driverimg2 = nil;
                    }
                    [self.CarInfoListTableView reloadData];
                }else if(self.pictureType == WLPictureTypeLicense)
                {
                    self.businessLicenseImg = nil;
                    [self.CarInfoListTableView reloadData];
                }else if (self.pictureType == WLPictureTypeCar)
                {
                    [self.unAuthorizedArrayM removeObjectAtIndex:self.didSelect];
                    [self showPhotoCollectionViewReloadData];
                }
                [self showPhotoViewHidden:YES];
                
            }else //编辑状态
            {
                WLCustomImageView *tempImg = [[WLCustomImageView alloc] init];
                if (self.pictureType == WLPictureTypeDriver) {
                    
                    [self.AddCarWarTitle createTip:@"行驶证不能为空,可以尝试修改"];
                    return;
//                    if (self.indexTag == 101) {
//                        self.driverimg1.image = nil;
//                        tempImg = self.driverimg1;
//                    }else
//                    {
//                        self.driverimg2.image = nil;
//                        tempImg = self.driverimg2;
//                    }
                    //                [self.CarInfoListTableView reloadData];
                }else if(self.pictureType == WLPictureTypeLicense)
                {
                    [self.AddCarWarTitle createTip:@"营运证不能为空,可以尝试修改"];
                    return;
//                    self.businessLicenseImg.image = nil;
//                    tempImg = self.businessLicenseImg;
                    //                [self.CarInfoListTableView reloadData];
                }else if (self.pictureType == WLPictureTypeCar)
                {
                    if(self.arrShowPhotoImage.count <=2){
                        [self.AddCarWarTitle createTip:@"车辆图片不能小于2张"];
                        return;
                    }else{
                        tempImg = [self.arrShowPhotoImage objectAtIndex:self.didSelect];
                        [self.arrShowPhotoImage removeObjectAtIndex:self.didSelect];
                    }
                    
                    //                [self showPhotoCollectionViewReloadData];
                }
                [self photoChangeOrAddOrDeleate:tempImg typeStr:@"3"];
                
                [self showPhotoViewHidden:YES];
                
            }
            
        }else if (buttonIndex == 1)//取消
        {
            
        }
    }else if (alertView.tag == 103)//重新审核的弹窗
    {
         if (buttonIndex == 0)//取消
        {
            
        }else if(buttonIndex == 1)//确认编辑
        {
            self.navigationItem.rightBarButtonItem.title = @"提交";
            self.isEdit = YES;
            if([self.carStatus integerValue] == 2)//
            {
                self.carStatus = @"0";
//                [self.CarInfoListTableView reloadData];
            }
            [self.CarInfoListTableView reloadData];
        }
    }else if (alertView.tag == 104)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

   
    
    
}
#pragma mark----选择图片或者照相机
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self showPhotoViewHidden:YES];
    
    if (buttonIndex==2) {
        //取消按钮
        return;
    }
    else
    {
        if (self.pictureOperation != WLPictureOperationAdd) {
            self.showPhotoView.hidden = YES;
        }
        
    }
    switch (buttonIndex) {
        case 0:
        {
            
            //先判断是否有权限调用摄像头
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设置-隐私-相机中允许访问相机" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                
//                alertView.tag = 101;
                
                [alertView show];
                
                return;
                
            }
            
            [self openPhotoToViewController:self sourceType:UIImagePickerControllerSourceTypeCamera];
            
        }
            break;
        case 1:
        {
            
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
#pragma mark UIimagePickerControllerDelegate
- (UIImagePickerController *)openPhotoToViewController:(UIViewController*)viewController sourceType:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&&mediaTypes.count>0) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
        imagePick.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*)kUTTypeImage,nil];
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
            UIImageWriteToSavedPhotosAlbum(editedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            
        }
        
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    if ([self.carStatus isEqualToString:@"-1"]) {//未认证情况下 统一走上传接口
        
        if (self.pictureType == WLPictureTypeDriver) {
            
            if (self.indexTag == 101) {
                self.driverimg1.image = editedImage;
            }else
            {
                self.driverimg2.image = editedImage;
            }
        }else if(self.pictureType == WLPictureTypeLicense)
        {
            self.businessLicenseImg.image = editedImage;
        }else
        {
            
            if (self.pictureOperation == WLPictureOperationAdd) {
                
                [self.unAuthorizedArrayM addObject:editedImage];
                [self showPhotoCollectionViewReloadData];
            }else if (self.pictureOperation == WLPictureOperationEdit)
            {
                
                [self.unAuthorizedArrayM replaceObjectAtIndex:self.didSelect withObject:editedImage];
                self.showPhotoImageView.image = editedImage;
                [self showPhotoCollectionViewReloadData];
            }
        }
        
        [self.CarInfoListTableView reloadData];
        
    }else //走图片的修改接口
    {
        WLCustomImageView *imageView = [[WLCustomImageView alloc] init];
        if (self.pictureType == WLPictureTypeDriver) {
            
            
            if (self.pictureOperation == WLPictureOperationAdd) {//如果是增加图片
                if (self.indexTag == 101) {
                    imageView.name = @"carimg1";
                    imageView.picID = @"";
                    imageView.image = editedImage;
                    self.driverimg1 = imageView;
                    
                }else
                {
                    imageView.name = @"carimg2";
                    imageView.picID = @"";
                    imageView.image = editedImage;
                    self.driverimg2 = imageView;
                }
                
                [self photoChangeOrAddOrDeleate:imageView typeStr:@"1"];
            }else if(self.pictureOperation == WLPictureOperationEdit)//如果是编辑图片
            {
                if (self.indexTag == 101) {
                    
                    self.driverimg1.image = editedImage;
                    
                    imageView = self.driverimg1;
                    
                }else
                {
                    
                    self.driverimg2.image = editedImage;
                    imageView = self.driverimg2;
                }
                [self photoChangeOrAddOrDeleate:imageView typeStr:@"2"];
            }
        } else if (self.pictureType == WLPictureTypeLicense)
        {
            if (self.pictureOperation == WLPictureOperationAdd) {
                imageView.name = @"taxi";
                imageView.picID = @"";
                imageView.image = editedImage;
                self.businessLicenseImg = imageView;
                [self photoChangeOrAddOrDeleate:imageView typeStr:@"1"];
            }else if(self.pictureOperation == WLPictureOperationEdit)
            {
                self.businessLicenseImg.image = editedImage;
                imageView = self.businessLicenseImg;
                [self photoChangeOrAddOrDeleate:imageView typeStr:@"2"];
            }
            
        }else if(self.pictureType == WLPictureTypeCar)
        {
            if (self.pictureOperation == WLPictureOperationAdd) {
                imageView.name = [NSString stringWithFormat:@"img%zd",self.arrShowPhotoImage.count+1];
                imageView.picID = @"";
                imageView.image = editedImage;
                [self.arrShowPhotoImage addObject:imageView];
                //                [self showPhotoCollectionViewReloadData];
                [self photoChangeOrAddOrDeleate: imageView typeStr:@"1"];
            }else if (self.pictureOperation == WLPictureOperationEdit)
            {
                imageView = [self.arrShowPhotoImage objectAtIndex:self.didSelect];
                imageView.image = editedImage;
                [self.arrShowPhotoImage replaceObjectAtIndex:self.didSelect withObject:imageView];
                
                
                //                self.showPhotoImageView.image = [self.arrShowPhotoImage objectAtIndex:self.didSelect];
                //                [self showPhotoCollectionViewReloadData];
                [self photoChangeOrAddOrDeleate: imageView typeStr:@"2"];
            }
        }
        
        
        
    }
    
    
}
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    
}


//刷新照片数据源
-(void)showPhotoCollectionViewReloadData
{
    WL_Application_addCarPhoto_TableViewCell *TableViewCell = [self.CarInfoListTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    [TableViewCell.PhotoCollectView reloadData];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark---获取车辆信息
-(void)loadCarInfomationFromServer
{
    [self showHud];
    [[WLNetworkDriverHandler sharedInstance] requestCarInfoWithCompanyID:self.companyId AndDataBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        if (responseType == WLResponseTypeSuccess) {
            if (data) {
                [self dataCreatFrom:data];
                [self hidHud];
            }
            [self hidHud];
        }else if (responseType == WLResponseTypeServerError)
        {
            [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请重试"];
        }
        [self hidHud];
    }];
    
}
#pragma mark- 获取车辆座位数
- (void)loadCarSeatNumbers
{
    WS(weakSelf);
  
    [WLNetworkCarBookingHandler requestCarSeatNumbersWithResultBlock:^(WLResponseType responseType, id data, NSString *message) {
        
        if(responseType == WLResponseTypeSuccess){
            NSString *carType = [weakSelf.arrRightTopTitle objectAtIndex:1];
            if ([carType isEqualToString:@"大巴"]) {
                weakSelf.arrYear = [data objectForKey:@"bus"];
            }else if ([carType isEqualToString:@"商务车"]) {
                weakSelf.arrYear = [data objectForKey:@"bussCar"];
            }
            [self.choseYearPickView reloadAllComponents];
            [self showAndHidden:NO];
            
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请重试"];
            return;
        }
        
    }];
}
#pragma mark----是否修改了必选项的载体

- (void)dataCreatFrom:(WLApplicationCarInfodataModel *)model
{
    
    
    self.isChangeModel = model;
    //车辆模型
    self.InfoModel = model.Mycar_info;
    //车辆认证状态
    self.carStatus = self.InfoModel.audit_status;
    self.companyId = self.InfoModel.company_id;
    //是否可以编辑
    if([model.opt_status isEqualToString:@"1"])
    {
        self.canEdit = NO;
    }else if ([model.opt_status isEqualToString:@"2"])
    {
        self.canEdit = YES;
    }
    
    CGFloat stringHeight = [WLTools getStringHeight:_InfoModel.audit_memo fontSize:14];
    
    self.height = ScaleH(stringHeight+70);
    //备注
    self.infoRemark = [NSString GetStringNSUTF8StringEncodingANDEmoji:self.InfoModel.memo];
    
    self.companyName = self.InfoModel.body_name;
    self.car_id = self.InfoModel.Myid;
    
    //车辆品牌
    [self.arrRightTopTitle replaceObjectAtIndex:0 withObject:self.InfoModel.brand];
    //车辆型号
    NSString *string;
    if ([self.InfoModel.model isEqualToString:@"1"]) {
        string = @"大巴";
    }else if([self.InfoModel.model isEqualToString:@"2"])
    {
        string = @"商务车";
    }else if([self.InfoModel.model isEqualToString:@"4"])
    {
        string = @"小汽车";
    }
    else
    {
        string = @"其它";
    }
    [self.arrRightTopTitle replaceObjectAtIndex:1 withObject:string];
    //车辆座位数
    [self.arrRightTopTitle replaceObjectAtIndex:2 withObject:self.InfoModel.seat_amount];
    //车牌号码
    [self.arrRightTopTitle replaceObjectAtIndex:3 withObject:self.InfoModel.number];
    //首次启用日期
    [self.arrRightTopTitle replaceObjectAtIndex:4 withObject:[NSString getDateStringWithTime:self.InfoModel.first_enabled_at andFormatter:@"yyyy年MM月dd日"]];
    if(self.InfoModel.day_pricing){
        //按天报价
        [self.arrRightTopTitle replaceObjectAtIndex:5 withObject:self.InfoModel.day_pricing];
    }
    if(self.InfoModel.kilometer_pricing){
        //按公里报价
        [self.arrRightTopTitle replaceObjectAtIndex:6 withObject:self.InfoModel.kilometer_pricing];
    }
    
    //remark
    [self.arrLeftCenter3Title replaceObjectAtIndex:0 withObject:self.InfoModel.memo?self.InfoModel.memo:@""];
    NSMutableArray *arrPhoto = self.isChangeModel.Myimgs;
    
    WS(weakSelf);
    
    
    
    self.driverimg1 = nil;
    self.driverimg2 = nil;
    self.businessLicenseImg = nil;
    self.arrShowPhotoImage = nil;
    
    for (WLApplicationCarInfoimgsModel *imageModel in arrPhoto) {
        WLCustomImageView *imageView = [[WLCustomImageView alloc] init];
        
        imageView.filePath = [NSString stringWithFormat:@"%@%@",imageModel.base_url,imageModel.path];
        imageView.picID = imageModel.Myid;
        imageView.name = imageModel.name;
        imageView.fileType = imageModel.file_type;
        
        
        NSInteger fileType = [imageModel.file_type integerValue];
        switch (fileType) {
                
            case 5:{
                weakSelf.driverimg1 = imageView;
                break;
            }
            case 6:{
                weakSelf.driverimg2 = imageView;
                break;
            }
            case 8:{
                
                weakSelf.businessLicenseImg = imageView;
                break;
            }
                
            case 7:{
                
                [weakSelf.arrShowPhotoImage addObject:imageView];
                break;
            }
  
            default:
                break;
        }
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.CarInfoListTableView reloadData];
    });
    
    
}
#pragma mark----提交按钮
-(void)NavigationRightEvent
{
    if (self.isEdit == YES) {
        
               if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:1]])
                {
                    [self.AddCarWarTitle createTip:@"车辆型号不能为空"];
                    return;
                }
                else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:2]])
                {
                    [self.AddCarWarTitle createTip:@"座位数不能为空"];
                    return;
        
                }
                else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:3]])
                {
                    [self.AddCarWarTitle createTip:@"车牌号码不能为空"];
                    return;
        
                }
                else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:4]])
                {
                    [self.AddCarWarTitle createTip:@"车龄不能为空"];
                    return;
        
                }
    
        
        if ([self.carStatus integerValue] == -1) {//新增车辆信息
            
            if(self.driverimg1.image == nil||self.driverimg2.image == nil)
            {
                [self.AddCarWarTitle createTip:@"行驶证不能为空"];
                return;
            }else if (self.unAuthorizedArrayM.count < 2) {
                [self.AddCarWarTitle createTip:@"车辆图片必须大于2张"];
                return;
            }else if (self.businessLicenseImg.image == nil)
            {
                [self.AddCarWarTitle createTip:@"营运证不能为空"];
                return;
            }
            [self addDataToServer];
            
        }
        else if(self.canEdit &&([self.carStatus integerValue]!=-1))
        {
            [self editCarinformation]; /**< 不做判断 */
            //修改信息
//            if(self.editBaseInfo)
//            {
//                [self editCarinformation];
//            }else{ //修改了图片
//              [self.AddCarWarTitle createTip:@"修改成功"];
//             [self.navigationController popViewControllerAnimated:YES];
//            }
        }
        
        return;
    }

    if (self.canEdit==YES && [self.carStatus integerValue] == -1)
    {
        self.navigationItem.rightBarButtonItem.title = @"提交";
        self.navigationItem.rightBarButtonItem.tintColor = Color3;
        self.isEdit = YES;
    }else if([self.carStatus integerValue] != -1)
    {
        if (self.canEdit==NO) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您当前有尚未出发或未结束的订单,无法编辑." delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
            [alert show];
            return;
        }else if (self.canEdit==YES){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"编辑后需要重新提交审核,确认是否编辑." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认编辑",nil];
            alert.tag = 103;
            [alert show];
        }
    }
    
    

   
    
    //    [self addDataToServer];
    
    //    else if (self.isEdit &&self.canEdit ==YES)
    //    {
    //        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
    //        WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.CarInfoListTableView cellForRowAtIndexPath:path];
    //        [cell.inputTextView resignFirstResponder];
    //
    //        //判断是否为空
 
    //        else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:5]])
    //        {
    //            [self.AddCarWarTitle createTip:@"使用年限不能为空"];
    //            return;
    //
    //        }
    ////        else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:6]])
    ////        {
    ////            [self.AddCarWarTitle createTip:@"请输入公司名称"];
    ////            return;
    ////
    ////        }
    //
    //        UIImage *imageFace = [UIImage imageNamed:@"upload"];
    //
    //        UIImage *imageBack = [UIImage imageNamed:@"upload"];
    //
    //
    //        if ([self.driverimg1 isEqual:imageFace]) {
    //            [self.AddCarWarTitle createTip:@"行驶证正面照片不能为空"];
    //            return;
    //        }
    //
    //        if ([self.driverimg2 isEqual:imageBack]) {
    //            [self.AddCarWarTitle createTip:@"行驶证背面照片不能为空"];
    //            return;
    //        }
    //
    //        if (self.arrShowPhotoImage.count<2) {
    //            [self.AddCarWarTitle createTip:@"车辆图片不能少于两张"];
    //            return;
    //        }
    //
    //        [self addDataToServer];
    //
    //    }else
    //
    //    {
    //        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:5];
    //        WL_Application_Driver_inforMation_TableViewCell3 *cell = [self.CarInfoListTableView cellForRowAtIndexPath:path];
    //        [cell.inputTextView resignFirstResponder];
    //
    //        //判断是否为空
    //        if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:0]]) {
    //            [self.AddCarWarTitle createTip:@"车辆品牌不能为空"];
    //            return;
    //        }
    //        else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:1]])
    //        {
    //            [self.AddCarWarTitle createTip:@"车辆型号不能为空"];
    //            return;
    //        }
    //        else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:2]])
    //        {
    //            [self.AddCarWarTitle createTip:@"车辆地点不能为空"];
    //            return;
    //
    //        }
    //        else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:3]])
    //        {
    //            [self.AddCarWarTitle createTip:@"车牌号码不能为空"];
    //            return;
    //
    //        }
    //        else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:4]])
    //        {
    //            [self.AddCarWarTitle createTip:@"使用年长不能为空"];
    //            return;
    //
    //        }
    //        else if (![WLTools judgeString:[self.arrRightTopTitle objectAtIndex:5]])
    //        {
    //            [self.AddCarWarTitle createTip:@"使用年限不能为空"];
    //            return;
    //
    //        }
    //
    //        UIImage *imageFace = [UIImage imageNamed:@"upload"];
    //
    //        UIImage *imageBack = [UIImage imageNamed:@"upload"];
    //
    //
    //        if ([self.driverimg1 isEqual:imageFace]) {
    //            [self.AddCarWarTitle createTip:@"行驶证正面照片不能为空"];
    //            return;
    //        }
    //
    //        if ([self.driverimg2 isEqual:imageBack]) {
    //            [self.AddCarWarTitle createTip:@"行驶证背面照片不能为空"];
    //            return;
    //        }
    //
    //        if (self.arrShowPhotoImage.count<2) {
    //            [self.AddCarWarTitle createTip:@"车辆图片不能少于两张"];
    //            return;
    //        }
    //
    //        [self addDataToServer];
    //
    //    }
    
}


#pragma mark----新增车辆
-(void)addDataToServer
{
    //新增信息
    NSDictionary *baseDic = [self getBaseDic];
    
    if (baseDic) {
        [baseDic setValue:self.driveId forKey:@"sj_driver_id"];
        NSDictionary *picDic = [self getPictureDic];
        
        NSMutableDictionary *paras = [NSMutableDictionary dictionary];
        
        if (picDic) {
            paras = @{@"baseDic":baseDic,@"picDic":picDic}.mutableCopy;
        }else{
            paras = @{@"baseDic":baseDic,@"picDic":@{}}.mutableCopy;
        }
        
        
        [[WLNetworkDriverHandler sharedInstance] addCarInfoWithDict:paras.copy resultBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
            
            if(responseType == WLResponseTypeSuccess && result)
            {
                NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"carBaseInfo.plist"];
                WLApplicationCarInfocar_infoModel *carBaseInfoModel = [[WLApplicationCarInfocar_infoModel alloc]init];
                [NSKeyedArchiver archiveRootObject:carBaseInfoModel toFile:path];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您的车辆信息已成功提交审核,工作人员将在48小时内完成审核,请耐心等待." delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
                 alert.tag = 104;
                [alert show];
            }
            else if (responseType == WLResponseTypeServerError)
            {
                [[WL_TipAlert_View sharedAlert] createTip:@"网络错误,请重试"];
                
            }else
            {
                
                [self.AddCarWarTitle createTip:@"提交失败"];
            }
            
            
        }];
    }
}



#pragma mark-----编辑车辆基本信息
-(void)editCarinformation
{
    
    [self showHudWithString:@"保存中..."];
    
    NSMutableDictionary *paras = [self getBaseDic].mutableCopy;
    if (paras) {
        [paras setValue:self.car_id forKey:@"car_id"];
        [paras setValue:self.driveId forKey:@"sj_driver_id"];
        [paras setValue:self.companyId forKey:@"company_id"];
        
        [[WLNetworkDriverHandler sharedInstance]
         editCarInfoWithDict:paras
         resultBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
             
             if (responseType == WLResponseTypeSuccess) {
                 if (result) {
                     [self.AddCarWarTitle createTip:@"修改成功"];
                     [self.navigationController popViewControllerAnimated:YES];
                      [self hidHud];
                 }else
                 {
                     [self.AddCarWarTitle createTip:@"修改失败"];
                     [self hidHud];
                 }
             }else{
                 [self.AddCarWarTitle createTip:@"网络错误,请稍后再试"];
                 [self hidHud];
             }
             
             
         }];
    }
    
}
- (NSDictionary *)getPictureDic//获取图片字典
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    for (int i=0; i<self.unAuthorizedArrayM.count; i++) {
        UIImage *tempImg = self.unAuthorizedArrayM[i];
        NSData *data = UIImageJPEGRepresentation(tempImg, 0.6);
        [dict setObject:data forKey:[NSString stringWithFormat:@"img%d",i+1]];
        
    }
    
    NSData *driverimg1Data = UIImageJPEGRepresentation(self.driverimg1.image, 0.6);
    NSData *driverimg2Data = UIImageJPEGRepresentation(self.driverimg2.image, 0.6);
    NSData *busLicenseImgData = UIImageJPEGRepresentation(self.businessLicenseImg.image, 0.6);
    
    if(driverimg1Data)
    {
        [dict setObject:driverimg1Data forKey:@"carimg1"];
    }
    if(driverimg2Data){
        [dict setObject:driverimg2Data forKey:@"carimg2"];
    }if(busLicenseImgData)
    {
        [dict setObject:busLicenseImgData forKey:@"taxi"];
    }
    
    return dict;
    //    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    //    formatter2.dateFormat = @"yyyyMMddHHmmss";
    //    NSString *str2 = [formatter2 stringFromDate:[NSDate date]];
    //    NSString *fileName2 = [NSString stringWithFormat:@"%@.jpg",str2];
}
#pragma mark 获取参数字典
- (NSDictionary *)getBaseDic
{
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    NSString *brand = [self.arrRightTopTitle objectAtIndex:0];
    if (brand.length) {
        [paras setObject:brand forKey:@"brand"];
    }
    
    NSString *model = [self.arrRightTopTitle objectAtIndex:1];
    if (model) {
        if ([model isEqualToString:@"大巴"]) {
            [paras setObject:@"1" forKey:@"model"];
        }else if ([model isEqualToString:@"商务车"]) {
            [paras setObject:@"2" forKey:@"model"];
        }else if ([model isEqualToString:@"小汽车"]) {
            [paras setObject:@"4" forKey:@"model"];
        }else
        {
           [paras setObject:@"3" forKey:@"model"];
        }
        
    }else
    {
        [self.AddCarWarTitle createTip:@"车辆类型不能为空"];
        return nil;
    }
    NSString *seat_amount = [self.arrRightTopTitle objectAtIndex:2];
    if (seat_amount.length) {
        [paras setObject:seat_amount forKey:@"seat_amount"];
    }else
    {
        [self.AddCarWarTitle createTip:@"座位数不能为空"];
        return nil;
    }
    NSString *tempStr = [self.arrRightTopTitle objectAtIndex:4];
    if (tempStr.length > 0) {
        NSString *first_enabled_at = [WLUITool timeIntervalWithTimeString:tempStr formatter:@"YYYY年MM月dd日"];
        [paras setObject:first_enabled_at forKey:@"first_enabled_at"];
    }
    //
    NSString *number = [self.arrRightTopTitle objectAtIndex:3];
    if (number.length) {
        
        [paras setObject:number forKey:@"number"];
    }else
    {
        [self.AddCarWarTitle createTip:@"车牌号不能为空"];
        return nil;
    }
    
    if([[self.arrRightTopTitle objectAtIndex:5] length]){
       [paras setObject:[self.arrRightTopTitle objectAtIndex:5] forKey:@"day_pricing"];
    }
    if([[self.arrRightTopTitle objectAtIndex:6] length]){
        [paras setObject:[self.arrRightTopTitle objectAtIndex:6] forKey:@"kilometer_pricing"];
    }
    NSString *body_name = self.companyName;
    if(body_name.length)
    {
        [paras setObject:body_name forKey:@"body_name"];
    }
//    NSString *memo = [NSString SendStringNSUTF8StringEncodingANDEmoji:self.infoRemark];
    NSString *memo = self.infoRemark;
    if (memo.length) {
        [paras setObject:memo forKey:@"memo"];
    }
    return  paras;
    
}
#pragma mark----字典转json
- (NSString*)dictionaryToJson:(NSDictionary *)dic {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
#pragma mark---创建弹出框
-(WL_TipAlert_View *)AddCarWarTitle
{
    if (_AddCarWarTitle == nil) {
        _AddCarWarTitle = [[WL_TipAlert_View alloc] init];
    }
    return _AddCarWarTitle;
}

#pragma mark-----修改上传删除图片
-(void)photoChangeOrAddOrDeleate:(WLCustomImageView *)photoImage typeStr:(NSString *)StrType
{
    //1 新增 2更改 3删除
    
    NSDictionary *photoChangedictParams = @{
                                            @"car_id":self.car_id,
                                            @"file_id":photoImage.picID,
                                            @"type":StrType,
                                            @"image":[StrType isEqualToString:@"3"]?[UIImage new]:photoImage.image,
                                            @"imageName":photoImage.name
                                            };
    
    if(self.editBaseInfo)//如果修改了基本信息 在提交图片时也提交基本信息
    {
        [self editCarinformation];
        self.editBaseInfo = NO;
    }
    
    [[WLNetworkDriverHandler sharedInstance] editCarPicturesWithDict:photoChangedictParams resultBlock:^(WLResponseType responseType, BOOL result, NSString *message) {
        if(responseType == WLResponseTypeSuccess && result)
        {
            [self.AddCarWarTitle createTip:@"操作成功"];
            
           [self loadCarInfomationFromServer];
        }else
        {
            [self.AddCarWarTitle createTip:[NSString stringWithFormat:@"操作失败 %@ 请重试",message]];
        }
    }];

    
}
//#pragma mark----本地报价回调
//-(void)backPriceType:(WL_Application_Driver_addCar_addPriceTypeViewController *)VC path:(NSIndexPath *)indexPath str:(WL_Application_Driver_Pricelist_Model *)strText isAdd:(BOOL)isAdd
//{
//    if (isAdd) {
//        [self.arrRightCenter2Title insertObject:strText atIndex:0];
//        [self.arrLeftCenter2Title insertObject:@"报价方式" atIndex:0];
//        //[self.arrLeftCenter2Title replaceObjectAtIndex:0 withObject:@"报价方式"];
//    }
//    else
//    {
//        [self.arrRightCenter2Title replaceObjectAtIndex:indexPath.row withObject:strText];
//        [self.arrLeftCenter2Title replaceObjectAtIndex:indexPath.row withObject:@"报价方式"];
//    }
//    
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
//    [self.CarInfoListTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//}
//#pragma mark----自定义报价的回调
//-(void)addPriceTypeOfSelfChange:(NSNotification *)dictSelf
//{
//    WlLog(@"-----自定义报价方式-------");
//    
//    NSString *isAdd = dictSelf.userInfo[@"isAdd"];
//    WL_Application_Driver_Pricelist_Model *model = [WL_Application_Driver_Pricelist_Model new];
//    model.pricelist_name = dictSelf.userInfo[@"pricelist_name"];
//    model.prime_price = dictSelf.userInfo[@"prime_price"];
//    model.unit = dictSelf.userInfo[@"unit"];
//    model.unit_type = @"4";
//    NSString *index = dictSelf.userInfo[@"indexPath"];
//    if ([isAdd isEqualToString:@"yes"]) {
//        //添加新的
//        [self.arrRightCenter2Title insertObject:model atIndex:0];
//        [self.arrLeftCenter2Title insertObject:@"报价方式" atIndex:0];
//    }
//    else
//    {
//        //修改
//        [self.arrRightCenter2Title replaceObjectAtIndex:[index integerValue] withObject:model];
//        [self.arrLeftCenter2Title replaceObjectAtIndex:[index intValue] withObject:@"报价方式"];
//    }
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
//    [self.CarInfoListTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
//    
//}
//编辑，修改了必选项
-(NSMutableArray *)editChangeTapArr
{
    if (_editChangeTapArr == nil) {
        
        _editChangeTapArr = [[NSMutableArray alloc] init];
        
    }
    return _editChangeTapArr;
}
//编辑
-(NSMutableArray *)editTapArr
{
    if (_editTapArr == nil) {
        
        _editTapArr = [[NSMutableArray alloc] init];
        
    }
    return _editTapArr;
}
//添加
-(NSMutableArray *)addTapArr
{
    if (_addTapArr == nil) {
        _addTapArr = [[NSMutableArray alloc] init];
        
    }
    return _addTapArr;
}


/** 未认证下的数组 */
- (NSMutableArray *)unAuthorizedArrayM{
    if (!_unAuthorizedArrayM) {
        _unAuthorizedArrayM = [NSMutableArray array];
    }
    return _unAuthorizedArrayM;
}

- (WLCustomImageView *)driverimg1{
    
    if (!_driverimg1) {
        _driverimg1 = [[WLCustomImageView alloc] init];
    }
    return _driverimg1;
}

- (WLCustomImageView *)driverimg2{
    
    if (!_driverimg2) {
        _driverimg2 = [[WLCustomImageView alloc] init];
    }
    return _driverimg2;
}
- (WLCustomImageView *)businessLicenseImg{
    
    if (!_businessLicenseImg) {
        _businessLicenseImg = [[WLCustomImageView alloc] init];
    }
    return _businessLicenseImg;
}

@end
