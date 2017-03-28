//
//  WLCarLocationListViewController.m
//  WeiLvDJS
//
//  Created by hsliang on 2017/2/12.
//  Copyright © 2017年 WeiLvDJS. All rights reserved.
//

#import "WLCarLocationListViewController.h"
#import "WLNetworkAccountHandler.h"

@interface WLCarLocationListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * cityListTableView;
@property (nonatomic, strong) NSArray * abcList;
@property (nonatomic, strong) NSMutableArray * NewArray;

@property (nonatomic, strong) NSMutableDictionary *sortDic;
@property (nonatomic, strong) NSMutableArray *sortkeys;

@property (nonatomic, copy)  void(^WCBtnAction)(WLCityItem *);

@end

@implementation WLCarLocationListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *view in self.cityListTableView.subviews) {
       
        if ([view isKindOfClass:NSClassFromString(@"UITableViewIndex")]) {
            UIFont *font = [UIFont WLFontOfSize:15];
            // 通过字符串转换成方法
            SEL sel = NSSelectorFromString(@"setFont:");
            
            //作为参数传递给invocation
            NSMethodSignature *signature = [NSClassFromString(@"UITableViewIndex") instanceMethodSignatureForSelector:sel];
            
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            
            [invocation setSelector:sel];
            
            [invocation setArgument:&font atIndex:2];
            
            [invocation setTarget:view];
            
            [invocation invoke];
            // 修改Frame字体才能生效
            [view performSelector:@selector(setFrame:) withObject:nil];
        }
    }
    
    self.navigationController.navigationBarHidden = NO;
    //[self selectCityBtnClick];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择城市";
    
    
    _abcList = [NSArray arrayWithObjects:
                 @"A", @"B", @"C", @"D", @"E", @"F",
                 @"G", @"H", @"I", @"J", @"K", @"L",
                 @"M", @"N", @"O", @"P", @"Q", @"R",
                 @"S", @"T", @"U", @"V", @"W", @"X",
                 @"Y", @"Z", nil
                 ];
    _NewArray = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i < _abcList.count; i ++) {
        NSMutableArray * arrItems = [[NSMutableArray alloc] init];
        [_NewArray addObject:arrItems];
    }
    
    [self createUI];
    [self loadingCityData];
    
//    //获取城市数据
//    //WS(weakSelf);
//    [WLNetworkAccountHandler requestCityListWithDataBlock:^(WLResponseType responseType, id data, NSString *message) {
//
//        if (responseType == WLResponseTypeSuccess) {
//            //weakSelf.cityArray = data;
//            NSArray * cityArray = data;
//            for (WLCityItem *item in cityArray)
//            {
//                [self indexAZ:item.cityItems];
//            }
//            
//            [_cityListTableView reloadData];
//            
//        }else{
//            [[WL_TipAlert_View sharedAlert] createTip:@"获取城市数据错误"];
//        }
//    }];
    
    // 定位 tableview
//    [tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row
//                                       
//                                                         inSection:0]
//     
//                     atScrollPosition:UITableViewScrollPositionTop
//     
//                             animated:YES];
}

- (void)loadingCityData
{
    for (WLCityItem *item in _cityArr)
    {
        [self indexAZ:item.cityItems];
    }
    
    [_cityListTableView reloadData];
}
- (void)indexAZ:(NSArray *)array
{
    NSDictionary * newarr = [self getDictByModelArray:array];
    
    for (NSInteger i = 0; i < _abcList.count; i ++) {
        NSString * AZStr = _abcList[i];
        for (WLCityItem *item in [newarr objectForKey:AZStr]) {
            //WlLog(@"==%@==%@",AZStr,item.cityName);
            if ([AZStr isEqualToString:@"A"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"B"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"C"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"D"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"E"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"F"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"G"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"H"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"I"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"J"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"K"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"L"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"M"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"N"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"O"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"P"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"Q"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"R"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"S"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"T"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"U"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"V"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"W"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"X"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"Y"]) {
                [_NewArray[i] addObject:item];
            }
            if ([AZStr isEqualToString:@"Z"]) {
                [_NewArray[i] addObject:item];
            }
        }
    }
    
    
}

- (void)createUI
{
    _cityListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
    _cityListTableView.delegate = self;
    _cityListTableView.dataSource = self;
    [self.view addSubview:_cityListTableView];
}

- (void)sendLocation:(NSString *)provinceID cityid:(NSString *)cityID
{
    [[WLNetworkDriverHandler sharedInstance] updateDriveCityWith:_company_id province:provinceID city:cityID resultBlock:^(WLResponseType responseType, NSInteger status, NSString *message) {
        if (responseType == WLResponseTypeSuccess) {
            [[WL_TipAlert_View sharedAlert] createTip:@"更新城市成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[WL_TipAlert_View sharedAlert] createTip:@"更新城市失败"];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _NewArray.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        NSArray *arr = _NewArray[section - 1];
        return arr.count;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray * abcArr = [NSArray arrayWithObjects:
                @"#", @"A", @"B", @"C", @"D", @"E", @"F",
                @"G", @"H", @"I", @"J", @"K", @"L",
                @"M", @"N", @"O", @"P", @"Q", @"R",
                @"S", @"T", @"U", @"V", @"W", @"X",
                @"Y", @"Z", nil
                ];
    return abcArr ;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[UIView alloc] init];
    UILabel * HeadtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ScaleW(10), ScaleH(5), ScaleW(200), ScaleH(20))];
    //HeadtitleLabel.text = _abcList[section];
    HeadtitleLabel.textAlignment = NSTextAlignmentLeft;
    HeadtitleLabel.font = [UIFont WLFontOfSize:14.0];
    [headView addSubview:HeadtitleLabel];
    
    if (section == 0) {
        HeadtitleLabel.text = @"当前定位";
    }
    else
    {
        HeadtitleLabel.text = _abcList[section - 1];
        HeadtitleLabel.textColor = [WLTools stringToColor:@"#333333"];
    }
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [_cityListTableView dequeueReusableCellWithIdentifier:@"LocationCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LocationCell"];
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",_cityItemName.cityName];//@"10月28日";
        cell.textLabel.textColor = [WLTools stringToColor:@"#00cc99"];
    }
    else
    {
        WLCityItem *itemSs = [[_NewArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [WLTools stringToColor:@"#333333"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",itemSs.cityName];//@"10月28日";
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@单",model.num];//@"1500单";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        _WCBtnAction(_cityItemName);
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        WLCityItem *itemSs = [[_NewArray objectAtIndex:indexPath.section - 1] objectAtIndex:indexPath.row];
        _WCBtnAction(itemSs);

        [self.navigationController popViewControllerAnimated:YES];
        //[self sendLocation:itemSs.provinceID cityid:itemSs.cityID];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleH(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleH(40);
}

- (void)wCClickAction:(void (^)(WLCityItem *))action
{
    _WCBtnAction = action;
}


//由响应得到的模型对象数组，获取“姓名首字母-模型对象数组”字典（用来做索引）
- (NSMutableDictionary *)getDictByModelArray:(NSArray *)array
{
    //从模型对象数组获取到对应的姓名数组
    NSMutableArray *arrNames = [NSMutableArray array];
    for (WLCityItem *item in array)
    {
        [arrNames addObject:item.cityName];
    }
    
    //姓名做key，模型对象做value，建立一一对应的字典
    NSDictionary *dictNameToModel = [NSDictionary
                                     dictionaryWithObjects:array
                                     forKeys:arrNames];
    
    //将姓名转化为拼音字符串、然后获取姓名对应的大写首字母的字典
    NSDictionary *dictFirstLetterToNames = [self getDicWithArray:arrNames];
    //将dictFirstLetterToNames中每个首字母对应的姓名数组按文字排序
//#warning TODO: 这里需要对数组进行汉字排序,只有这样才能每个组里面的列表也按照姓名拼音排序----------------------
//#warning TODO: 汉字拼音排序暂时未实现----------------------------------------------------------------
    //根据“首字母--姓名数组”和“姓名--模型对象”两个字典，转化为需要的“首字母-模型对象”字典
    //新建可变数组，用于保存各个首字母对应的模型数组（之后用于“首字母-模型对象”字典的初始化）
    NSMutableArray *arrSubModels = [NSMutableArray array];
    //下面开始往这个新建的数组中写数据
    //对“首字母--姓名数组”字典的value遍历
    for (NSArray *arrSubNames in [dictFirstLetterToNames allValues])
    {
        //新建可变数组用于保存姓名数组对应的模型数组
        NSMutableArray *arrModelsFromNames = [NSMutableArray array];
        //对名字数组中的每个名字遍历
        for (NSString *name in arrSubNames)
        {
            //得到名字对应的model对象，并假如到模型数组中
            [arrModelsFromNames addObject:dictNameToModel[name]];
        }
        //将得到的“首字母”对应的“模型对象”数组加入到arrSubModels中，用于初始化“首字母-模型对象”字典
        [arrSubModels addObject:arrModelsFromNames];
    }
    //使用tempFirstLetter做key，对应的model类型数组做value构成字典
    NSArray *tempFirstLetter = [dictFirstLetterToNames allKeys];
    NSMutableDictionary *dictFirLetToModels = [NSMutableDictionary dictionaryWithObjects:arrSubModels forKeys:tempFirstLetter];
    //返回字典
    return dictFirLetToModels;
}

//将字符串数组，按首字母分组，得到“字母”对“相应子字符串数组”的字典
- (NSDictionary *)getDicWithArray:(NSArray *)arrNames
{
    NSMutableDictionary *dictFirstLetterToNames = [NSMutableDictionary dictionary];
    for (NSString *name in arrNames)
    {
        //获取到姓名的大写首字母
        NSString *strFirstLetter = [self getFirstLetterFromString:name];
        //如果该字母对应的模型不为空（即签名已经有过该首字母的名字了）
        //则将这个姓名加入到这个首字母对应的姓名数组中
        if (dictFirstLetterToNames[strFirstLetter])
        {
            [dictFirstLetterToNames[strFirstLetter] addObject:name];
        }
        else//没有出现过该首字母，则往字典中新增一组key-value
        {
            //新建一个可变长数组，用于存储该首字母对应的姓名
            NSMutableArray *arrGroupNames = [NSMutableArray arrayWithObject:name];
            //将首字母-姓名数组作为key-value加入到字典中
            [dictFirstLetterToNames setObject:arrGroupNames forKey:strFirstLetter];
        }
    }
    return dictFirstLetterToNames;
}

//获取字符串首字母(传入汉字字符串, 返回大写拼音首字母)
- (NSString *)getFirstLetterFromString:(NSString *)aString
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *strPinYin = [str capitalizedString];
    //获取并返回首字母
    return [strPinYin substringToIndex:1];
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
