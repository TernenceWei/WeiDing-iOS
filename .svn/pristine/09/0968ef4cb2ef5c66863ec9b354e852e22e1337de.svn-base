//
//  WHUCalendarView.m
//  TEST_Calendar
//
//  Created by SuperNova(QQ:422596694) on 15/11/5.
//  Copyright (c) 2015年 SuperNova(QQ:422596694). All rights reserved.
//

#import "WHUCalendarView.h"
#import "WHUCalendarCell.h"
#import "WHUCalendarItem.h"
#import "WHUCalendarCal.h"
#import "WHUCalendarFlowLayout.h"
//#import "WHUCalendarYMSelectView.h"
#import "WHUCalendarMarcro.h"

#import "WL_Trip_Model.h"
#define WHUCalendarView_TopView_Height 35.0f
#define WHUCalendarView_WeekView_Height 20.0f
#define WHUCalendarView_ContentView_Height 250.0f
#define WHUCalendarView_Margin_Horizon 15.0f
typedef NS_ENUM(NSUInteger, WHUCalendarViewMonthOption) {
    WHUCalendarViewPreMonth,
    WHUCalendarViewNextMonth
};
@interface WHUCalendarView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UIView* _topView;
    UIView* _weekView;
    UIView* _contentView;
    UIView* _calendarConView;
    
    UIButton* _mLeftBtn;
    UIButton* _mRightBtn;
    
    UIButton* _yLeftBtn;
    UIButton* _yRightBtn;
    
    UICollectionView* _calView;
    //UILabel* _curMonthLbl;
    
    NSArray* _dataArr;
    
    
    
    WHUCalendarCal* _calcal;
    UITapGestureRecognizer* _collectionTapGes;
    UIPanGestureRecognizer* _collectionPanGes;
   
   // WHUCalendarYMSelectView* _pickerView;
    
    NSLayoutConstraint* _calviewBottomGapCts;
    
    NSString* _selectedDateString;
    
    CGFloat _screenScale;
   
    BOOL _shouldLayout;
    
    BOOL clickTodey;
    
    NSMutableArray *_selectArray;
    
    NSIndexPath *lastIndexPath;
    
    
}

@property(nonatomic,strong)NSMutableArray *selectedDateArray;

@property(nonatomic,strong)NSMutableDictionary *saveDict;;

@end
@implementation WHUCalendarView
-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if(self){
        [self setupView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self setupView];
    }
    return self;
}

-(NSMutableArray *)selectedDateArray
{
    
    if (_selectedDateArray ==nil) {
        
        
        _selectedDateArray =[[NSMutableArray alloc]init];
        
    }
    return _selectedDateArray;
}

-(void)setupView{
    _shouldLayout=YES;
    _calcal=[[WHUCalendarCal alloc] init];
    //预加载下数据
    _topView=[self makeView];
    _weekView=[self makeView];
    _contentView=[self makeView];
    [self addSubview:_topView];
    
    UIView* calendarConView=[[UIView alloc] init];
    [self addSubview:calendarConView];
    calendarConView.translatesAutoresizingMaskIntoConstraints=NO;
    [calendarConView addSubview:_weekView];
    [calendarConView addSubview:_contentView];
    _calendarConView=calendarConView;
    UIColor* bgColor=[UIColor whiteColor];
    _topView.backgroundColor=bgColor;
    _weekView.backgroundColor=bgColor;
    _contentView.backgroundColor=bgColor;
    self.backgroundColor=bgColor;
    NSDictionary* viewDic=@{@"topv":_topView,@"midv":_weekView,@"bottomv":_contentView,@"calcon":calendarConView};
    NSDictionary* metrics=@{@"topH":@(WHUCalendarView_TopView_Height),
                            @"midH":@(WHUCalendarView_WeekView_Height)
                            };

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[topv]|" options:0 metrics:nil views:viewDic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[calcon]|" options:0 metrics:nil views:viewDic]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topv(==topH)][calcon]|" options:0 metrics:metrics views:viewDic]];
    [calendarConView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[midv]|" options:0 metrics:nil views:viewDic]];
    [calendarConView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[bottomv]|" options:0 metrics:nil views:viewDic]];
    [calendarConView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[midv(==midH)][bottomv]|" options:0 metrics:metrics views:viewDic]];
    
    
    UIButton* preBtn= [UIButton new];
    
    [preBtn setBackgroundImage:[UIImage imageNamed:@"PreMonth"] forState:UIControlStateNormal];
    
    preBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
    _mLeftBtn=preBtn;
    
    preBtn.tag=1000;
    [preBtn addTarget:self action:@selector(monthSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* nextBtn=[UIButton new];
    
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"NextMonth"] forState:UIControlStateNormal];
    
    _mRightBtn=nextBtn;
    
    nextBtn.tag=2000;
    
    nextBtn.translatesAutoresizingMaskIntoConstraints=NO;
    [nextBtn addTarget:self action:@selector(monthSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel* curDateLbl=[[UILabel alloc] init];
    curDateLbl.font= WLFontSize(16);
    curDateLbl.translatesAutoresizingMaskIntoConstraints=NO;
    curDateLbl.text=@"            ";
    
    curDateLbl.textColor = [UIColor grayColor];
    
    _curMonthLbl=curDateLbl;
    _curMonthLbl.userInteractionEnabled=YES;

    [curDateLbl sizeToFit];
    [_topView addSubview:preBtn];
    [_topView addSubview:nextBtn];
    [_topView addSubview:curDateLbl];
    
    [preBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        
        make.top.mas_equalTo(5);
        
    }];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(0);
        
        make.top.mas_equalTo(5);
        
    }];
    
    [_topView addConstraint:[NSLayoutConstraint constraintWithItem:curDateLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_topView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
    [_topView addConstraint:[NSLayoutConstraint constraintWithItem:curDateLbl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_topView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
    
}

-(void)setCurrentDate:(NSDate *)currentDate{
    
    _currentDate=currentDate;
    
    if(_currentDate!=nil){
       
        _dataDic=[_calcal loadDataWith:[_calcal stringFromDate:_currentDate]];

    }
    
}

-(void)setTripArray:(NSMutableArray *)tripArray

{
    _selectArray =[[NSMutableArray alloc]initWithCapacity:0];
    
    self.saveDict =[[NSMutableDictionary alloc]init];

    NSArray* tempArr=_dataDic[@"dataArr"];
    
    NSInteger row=-1;

    for(int i=0;i<tempArr.count;i++)
    {
     
     WHUCalendarItem* item=tempArr[i];
    
    for (WL_Trip_Model *obj in tripArray) {
    
        if ([self strFrom:item.dateStr]>=[self strFrom:obj.start_time]&&[self strFrom:item.dateStr]<=[self strFrom:obj.end_time]) {
    
             row=i;
    
            if (![_selectArray containsObject:@(row)]) {
                
                [_selectArray addObject:@(row)];
                
                [self.saveDict setObject:obj forKey:@(row)];
            }
            
           
            
            }
    
        }
     }

     [_calView reloadData];

    
}
-(void)clickSomeDayWith:(NSDate *)date
{
    NSArray* tempArr=_dataDic[@"dataArr"];
    
    NSString *todayStr = [_calcal someDayDateStr:date];
    
    [DEFAULTS setObject:todayStr forKey:@"date"];
    
    NSInteger index =[tempArr indexOfObject:todayStr];
    
    NSIndexPath *dexPath =[NSIndexPath indexPathForItem:index inSection:0];
    
    NSArray *indexPaths =[NSArray arrayWithObjects:dexPath, nil];
    
    [UIView performWithoutAnimation:^{
        
        [_calView reloadItemsAtIndexPaths:indexPaths];
    }];
}

- (void)reloadSomeMonthWith:(NSDate *)date
{
     NSString *todayStr = [_calcal someDayDateStr:date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *dat = [dateFormatter dateFromString:todayStr];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:dat];
    NSInteger year = [dateComps year];
    NSInteger month = [dateComps month];
    NSString *timeString = [NSString stringWithFormat:@"%ld年%ld月",year, month];
    
    [_calcal getCalendarMapWith:timeString completion:^(NSDictionary *dic) {
        
        _dataDic=dic;
        CATransition* tran=[CATransition animation];
        _curMonthLbl.text=dic[@"monthStr"];
        tran.duration=0.3;
        tran.type=kCATransitionFade;
        [_curMonthLbl.layer addAnimation:tran forKey:nil];
        [self reloadCollectionView];
    }];
}

-(void)clickTodayReload
{
    
    clickTodey =YES;
    
    NSArray* tempArr=_dataDic[@"dataArr"];
    
    NSString *todayStr = [_calcal currentDateStr];
    
    [DEFAULTS setObject:todayStr forKey:@"date"];
    
    NSInteger index =[tempArr indexOfObject:todayStr];
    
    NSIndexPath *dexPath =[NSIndexPath indexPathForItem:index inSection:0];
    
    NSArray *indexPaths =[NSArray arrayWithObjects:dexPath, nil];
    
    [UIView performWithoutAnimation:^{
    
        [_calView reloadItemsAtIndexPaths:indexPaths];
    }];

}

- (void)backToCurrentMonth{
    NSString *todayStr = [_calcal currentDateStr];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:todayStr];
    NSDateComponents *dateComps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSInteger year = [dateComps year];
    NSInteger month = [dateComps month];
    NSString *timeString = [NSString stringWithFormat:@"%ld年%ld月",year, month];
    
    [_calcal getCalendarMapWith:timeString completion:^(NSDictionary *dic) {

        _dataDic=dic;
        CATransition* tran=[CATransition animation];
        _curMonthLbl.text=dic[@"monthStr"];
        tran.duration=0.3;
        tran.type=kCATransitionFade;
        [_curMonthLbl.layer addAnimation:tran forKey:nil];
        [self reloadCollectionView];
    }];
}

-(void)reloadCollectionView{
   
    NSArray* tempArr=_dataDic[@"dataArr"];
   
    WHUCalendarFlowLayout* layout=(WHUCalendarFlowLayout*)_calView.collectionViewLayout;
    
    layout.dataCount=tempArr.count;
    
    [_calView reloadData];
    
    if (self.changeFrame)
    {
        
        self.changeFrame([self getCollectionContentHeight]+60, _dataDic);
        
    }
}

-(void)monthSelectAction:(UIButton*)sender{

    if(sender.tag==1000){
      
        //clickTodey =NO;
        clickTodey = YES;
        
        [self loadCalendarDataFor:WHUCalendarViewPreMonth];
        
        
    }
    else{
        
        //clickTodey =NO;
        clickTodey = YES;
       
        [self loadCalendarDataFor:WHUCalendarViewNextMonth];
    }
}

-(void)loadCalendarDataFor:(WHUCalendarViewMonthOption )option{
    WHUCalendarView_WeakSelf weakself=self;
    if(option==WHUCalendarViewPreMonth){
        [_calcal preMonthCalendar:_curMonthLbl.text complete:^(NSDictionary* dic){
            WHUCalendarView_StrongSelf self=weakself;
            self->_dataDic=dic;
            CATransition* tran=[CATransition animation];
            self->_curMonthLbl.text=dic[@"monthStr"];
            tran.duration=0.3;
            tran.type=kCATransitionFade;
            [self->_curMonthLbl.layer addAnimation:tran forKey:nil];
            
            [self reloadCollectionView];
        }];
    }
    else if(option==WHUCalendarViewNextMonth){
        
        [_calcal nextMonthCalendar:_curMonthLbl.text complete:^(NSDictionary* dic){
            WHUCalendarView_StrongSelf self=weakself;
            self->_dataDic=dic;
            CATransition* tran=[CATransition animation];
            self->_curMonthLbl.text=dic[@"monthStr"];
            tran.duration=0.3;
            tran.type=kCATransitionFade;
            [self->_curMonthLbl.layer addAnimation:tran forKey:nil];
            [self reloadCollectionView];
        }];
    }
}

-(CGSize)getCollectionCellItemSize{
    
    CGFloat itemWidth=(self.bounds.size.width-WHUCalendarView_Margin_Horizon)/7.0f;
    
    return CGSizeMake(itemWidth, itemWidth);
}

//计算 collection 的高度
-(CGFloat)getCollectionContentHeight{
    
    CGSize size=[self getCollectionCellItemSize];
   
    NSArray* tempArr=_dataDic[@"dataArr"];
    
    //这样做是为了 当  tempArr为36时，36/7=5 ＋1 ＝6，6行的高度 才能满足。。
    return size.height*(tempArr.count%7==0 ? tempArr.count/7 : tempArr.count/7
                        +1);
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if(_weekView.subviews.count==0){
        NSArray* weekArr=@[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        UILabel* preLbl=nil;
        CGFloat weekMargin=WHUCalendarView_Margin_Horizon;
        NSString* firstStr=weekArr[0];
        CGRect strRect=[firstStr boundingRectWithSize:CGSizeMake(FLT_MAX, WHUCalendarView_WeekView_Height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:nil context:nil];
        CGFloat itemCount=(CGFloat)weekArr.count;
        CGFloat weekGap=(self.bounds.size.width-3*weekMargin-itemCount*strRect.size.width)/(itemCount-1);
        
        if (IsiPhone4 || IsiPhone5) {
            
            weekMargin =weekMargin + 5;
            
        }else if (IsiPhone6)
        {
            
            weekMargin = weekMargin +9;
            
            weekGap = weekGap-1;
            
            
        }else if (IsiPhone6P)
        {
            weekMargin =weekMargin +12;
            
            weekGap = weekGap -2;
        }

        
        for(int i=0;i<weekArr.count;i++){
            UILabel* lbl=[[UILabel alloc] init];
            lbl.translatesAutoresizingMaskIntoConstraints=NO;
            lbl.font=WLFontSize(12);
            lbl.text=weekArr[i];
            lbl.textColor=[UIColor grayColor];
            [lbl sizeToFit];
            [_weekView addSubview:lbl];
            
            [_weekView addConstraint:[NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_weekView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
            if(preLbl==nil){
                [_weekView addConstraint:[NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_weekView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:weekMargin]];
            }
            else{
                [_weekView addConstraint:[NSLayoutConstraint constraintWithItem:lbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:preLbl attribute:NSLayoutAttributeRight multiplier:1.0f constant:weekGap]];
            }
            preLbl=lbl;
        }
        
        if(_someDate==nil){
           _dataDic=[_calcal loadDataWith:[_calcal stringFromDate:[NSDate date]]];
            _curMonthLbl.text=_dataDic[@"monthStr"];
        }else
        {
            _dataDic=[_calcal loadDataWith:[_calcal stringFromDate:_someDate]];
            _curMonthLbl.text=_dataDic[@"monthStr"];
        }
        
        WHUCalendarFlowLayout* flowLayout = [[WHUCalendarFlowLayout alloc]init];
        CGSize itemSize=[self getCollectionCellItemSize];
        flowLayout.itemSize = itemSize;
        flowLayout.minimumLineSpacing=0;
        flowLayout.sectionInset=UIEdgeInsetsZero;
        flowLayout.minimumInteritemSpacing=0;
        flowLayout.headerReferenceSize=CGSizeZero;
        flowLayout.footerReferenceSize=CGSizeZero;

#pragma mark --- collectionView 的创建
        
        _calView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
        _calView.delegate=self;
        
        _calView.dataSource=self;
        
        _calView.backgroundColor =[UIColor whiteColor];
        _calView.scrollEnabled=NO;
        [_calView registerClass:[WHUCalendarCell class] forCellWithReuseIdentifier:@"cell"];
        _calView.translatesAutoresizingMaskIntoConstraints=NO;
        NSDictionary* viewDic2=@{@"calview":_calView};
        NSDictionary* metrics2=@{@"gap":@(WHUCalendarView_Margin_Horizon/2.0f)};
        _contentView.layer.masksToBounds=YES;
        [_contentView addSubview:_calView];
        [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==gap)-[calview]-(==gap)-|" options:0 metrics:metrics2 views:viewDic2]];
        [_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[calview]" options:0 metrics:nil views:viewDic2]];
        _calviewBottomGapCts=[NSLayoutConstraint constraintWithItem:_calView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0];
        [_contentView addConstraint:_calviewBottomGapCts];
        
        _curMonthLbl.text=_dataDic[@"monthStr"];
        NSArray* tempArr=_dataDic[@"dataArr"];
        flowLayout.dataCount=tempArr.count;
        flowLayout.columnCount=7;
        [_calView reloadData];

        if (self.changeFrame) {
            
            self.changeFrame([self getCollectionContentHeight]+60,_dataDic);
            
        }

        
    }
}


-(UIView*)makeView{
    UIView* v=[[UIView alloc] init];
    v.translatesAutoresizingMaskIntoConstraints=NO;
    return v;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray* tempArr=_dataDic[@"dataArr"];
    
    return tempArr.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WHUCalendarCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSArray* tempArr=_dataDic[@"dataArr"];
    cell.rowIndex=indexPath.row;
    cell.total=tempArr.count;
   
    WHUCalendarItem* item=tempArr[indexPath.row];
    
    cell.selectedBackgroundView =[UIView new];
    

    if(item.day<0){
        
        //不在当前月份的不让点击，同时也不显示日期
        
        cell.lbl.text =@"";
        
        cell.isDayInCurMonth=NO;
        
        cell.selectImage.hidden = YES;
        
        cell.origin.hidden =YES;
        
        cell.userInteractionEnabled =NO;
    }
    else{
        
        //在当前月份的可以点击，也可以显示日期
        cell.lbl.text=[NSString stringWithFormat:@"%ld",(long)item.day];
        
        cell.lbl.textColor=[UIColor grayColor];
        
        cell.isDayInCurMonth=YES;
        
        cell.selectImage.hidden = NO;
        
        cell.origin.hidden =NO;
        
        cell.userInteractionEnabled =YES;
    }

    cell.selectImage.image =[UIImage imageNamed:@"1"];
   
    cell.origin.image =[UIImage imageNamed:@"1"];
    
    cell.isLeave =NO;

          if(_selectArray.count>0){
    
            for (id obj in _selectArray) {
    
                if ([obj integerValue]==indexPath.row) {
                    
                 WL_Trip_Model *model = [self.saveDict objectForKey:@([obj integerValue])];
                    
                    
                    if ([model.status integerValue]==0)
                    {
                        cell.selectImage.image =[UIImage imageNamed:@"1"];
                        
                        cell.lbl.textColor=[WLTools stringToColor:@"#4cd661"];
                        
                        cell.isLeave =YES;
                    }else{
                    
                       
                        if ([model.trip_status integerValue]==1||[model.trip_status integerValue]==2) {
                            
                            cell.selectImage.image =[[UIImage imageNamed:@"tripOrderOrigin"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                            
                            cell.lbl.textColor=[UIColor
                                                whiteColor];
                        }else if ([model.trip_status integerValue]==3)
                        {
                            cell.selectImage.image =[UIImage imageNamed:@"tripEndOrigin"];
                            
                            cell.lbl.textColor=[WLTools stringToColor:@"#b0b7c1"];
                            
                        }
                
                    
                    }
                }
         }
          }
    
    
    if ([item.dateStr isEqualToString:[DEFAULTS objectForKey:@"date"]])
    {
        
        cell.origin.image =[UIImage imageNamed:@"tripBotomOrigin"];
        
        lastIndexPath = indexPath;
        
    }else
    {
        cell.origin.image =[UIImage imageNamed:@"1"];
    }
    //点击今天按钮的时候，今天显示 今 字
    if (clickTodey) {
        
        if([item.dateStr isEqualToString:[_calcal currentDateStr]]){
            
            if (item.day <0) {
                
                cell.lbl.text =@"";
                
                cell.isDayInCurMonth=NO;
                
                cell.selectImage.hidden = YES;
                
                cell.userInteractionEnabled =NO;
                
            }else
            {
                
                cell.isToday=YES;
                
                cell.lbl.text =@"今";
                
                cell.lbl.textColor =WLColor(229, 101, 100, 1);
                
                cell.userInteractionEnabled =YES;
                
            }
        }else
        {
            
            cell.isToday=NO;
            
        }
    }

    
   
    cell.item =item;
    
    [cell setNeedsLayout];
    
    return cell;
}

-(float)strFrom:(NSString *)time
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:time];
    
    NSTimeInterval Val =[date timeIntervalSince1970];
    
    return Val;
   
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray* tempArr=_dataDic[@"dataArr"];
    
    WHUCalendarItem* item=tempArr[indexPath.row];
    
    _selectedDateString=item.dateStr;

    WHUCalendarCell *cell =(WHUCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if (indexPath!=lastIndexPath) {
       
        WHUCalendarCell *lastCell =(WHUCalendarCell *)[collectionView cellForItemAtIndexPath:lastIndexPath];
        
        lastCell.origin.image =[UIImage imageNamed:@"1"];

        if(_onDateSelectBlk!=nil){
            
            
            _onDateSelectBlk(self.selectedDate,cell);
            
            [DEFAULTS setObject:_selectedDateString forKey:@"date"];
        }
        
    }
    
    lastIndexPath = indexPath;
 
}

-(NSDate*)selectedDate{
  
    if(_selectedDateString==nil)
      
      return nil;
   
    return [_calcal dateFromString:_selectedDateString];
}



- (CGSize)sizeThatFits:(CGSize)size {
    if(size.width<300){
        size.width=300;
    }
    CGFloat height=((size.width-WHUCalendarView_Margin_Horizon)/7.0f)*6;
    height+=(WHUCalendarView_TopView_Height+WHUCalendarView_WeekView_Height);
    size.height=height;
    return size;
}

@end
