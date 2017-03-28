//
//  WLApplicationGuidePriceDetailViewController.m
//  WeiLvDJS
//
//  Created by whw on 16/10/17.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WLApplicationGuidePriceDetailViewController.h"
#import "WLApplicationGuidePriceDetailTableViewCell.h"
#import "WLPriceListObject.h"

@interface WLApplicationGuidePriceDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, assign)NSInteger priceID;
///左侧数据源
@property (nonatomic, strong)NSMutableArray *leftArray;
@property(nonatomic, strong)NSMutableArray *rightArray;

@property (nonatomic, strong)NSMutableArray *leftChooseType2;
@property(nonatomic, strong)NSMutableArray *rightChooseType2;

@property (nonatomic, assign) BOOL showType;

@end

@implementation WLApplicationGuidePriceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.priceID = 0;
    
    _showType = YES;
    
    [self setUpNav];
    [self setUpTableView];
    //self.priceList = [[WLPriceListObject alloc] init];
    [self setDataShow];
}

- (WLPriceListObject *)priceList
{
    if (_priceList == nil) {
        _priceList = [[WLPriceListObject alloc] init];
    }
    
    return _priceList;
}

-(NSMutableArray *)leftArray{
    if (_leftArray == nil) {
        _leftArray = [[NSMutableArray alloc] initWithObjects:@"类型",@"单价(元)", nil];
    }
    return _leftArray;
}

-(NSMutableArray *)rightArray{
    if (_rightArray == nil) {
        _rightArray = [[NSMutableArray alloc] initWithObjects:@"按天计价",@"请输入单价", nil];
    }
    return _rightArray;
}

-(NSMutableArray *)leftChooseType2{
    if (_leftChooseType2 == nil) {
        _leftChooseType2 = [[NSMutableArray alloc] initWithObjects:@"类型",@"线路名称",@"总价", nil];
    }
    return _leftChooseType2;
}

-(NSMutableArray *)rightChooseType2{
    if (_rightChooseType2 == nil) {
        _rightChooseType2 = [[NSMutableArray alloc] initWithObjects:@"按路线计价",@"例：华东5日游",@"请输入总价", nil];
    }
    return _rightChooseType2;
}

- (void)setUpNav{
    self.view.backgroundColor = BgViewColor;
    self.title = @"报价方式";
    [self setNavigationRightTitle:@"保存" fontSize:14 titleColor:[UIColor whiteColor] isEnable:YES];
}

-(void)setUpTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.bounces = NO;
    [self.view addSubview:self.tableView];
}

- (void)setDataShow
{
    if (_priceList != nil) {
        if ([_priceList.priceName isEqualToString:@"按天计价"]) {
            self.tableView.frame = CGRectMake(0, 0, ScreenWidth, 100);
            _showType = YES;
            
            [self.tableView reloadData];
        }
        else
        {
            self.tableView.frame = CGRectMake(0, 0, ScreenWidth, 150);
            _showType = NO;
            
            [self.tableView reloadData];
        }
    }
}

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_showType) {
        return self.leftArray.count;
    }
    else
        return self.leftChooseType2.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"ID";
    WLApplicationGuidePriceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WLApplicationGuidePriceDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    //cell.label.text = [self.leftArray objectAtIndex:indexPath.row];
    
    //cell.textView.placeholder = self.rightArray[indexPath.row];
    
    cell.textView.delegate = self;
    cell.textView.tag = indexPath.row;
    
    if (indexPath.row == 0) {
        cell.textView.hidden = YES;
        
        cell.chooseTypelabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseTapClick)];
        [cell.chooseTypelabel addGestureRecognizer:tap];
    }
    else
    {
        cell.nextImageView.hidden = YES;
        cell.chooseTypelabel.hidden = YES;
    }
    
        
    if(_showType)
    {
        cell.label.text = [self.leftArray objectAtIndex:indexPath.row];
        
        //cell.textView.placeholder = self.rightArray[indexPath.row];

        cell.chooseTypelabel.text = self.rightArray[indexPath.row];
        
        if (_priceList != nil) {
            cell.textView.text = _priceList.price;
        }
        else
        {
            cell.textView.placeholder = self.rightArray[indexPath.row];
        }
    }
    else
    {
        cell.label.text = [self.leftChooseType2 objectAtIndex:indexPath.row];
        
        //cell.textView.placeholder = self.rightChooseType2[indexPath.row];

        cell.chooseTypelabel.text = self.rightChooseType2[indexPath.row];
        
        if (_priceList != nil) {
            if (indexPath.row == 1) {
                cell.textView.text = _priceList.priceName;
            }
            else
            {
                cell.textView.text = _priceList.price;
            }
        }
        else
        {
            cell.textView.placeholder = self.rightChooseType2[indexPath.row];
        }
    }

    return cell;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    switch (textView.tag) {
        case 1:
            _priceList.priceName = textView.text;
           break;
        case 2:
            _priceList.price = textView.text;
            break;
        case 3:
            _priceList.unit = textView.text;
            break;
        default:
            break;
    }
}

-(void)textViewDidChange:(UITextView *)textView{
    switch (textView.tag) {
        case 1:
            if (_showType) {
                _priceList.price = textView.text;
            }
            else
            {
                _priceList.priceName = textView.text;
            }
            
            break;
        case 2:
            if (_showType) {
                //_priceList.price = textView.text;
            }
            else
            {
                _priceList.price = textView.text;
            }
            
            break;

        default:
            break;
    }
}

- (void)chooseTapClick
{
    //设置头像
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"报价方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"按天计价" otherButtonTitles:@"按路线计价", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            self.tableView.frame = CGRectMake(0, 0, ScreenWidth, 100);
            _showType = YES;
            
            [self.tableView reloadData];
        }
            break;
        case 1:
        {
            self.tableView.frame = CGRectMake(0, 0, ScreenWidth, 150);
            _showType = NO;
            
            [self.tableView reloadData];
        }
            break;
            
        default:
            break;
    }
}

//右侧点击事件
-(void)NavigationRightEvent{
    
    NSLog(@"%@=%@=%@",_priceList.priceName,_priceList.price,_priceList.unit);
    if (_showType) {
        _priceList.priceName = @"按天计价";
        _priceList.unit = @"天";
    }
    else
    {
        _priceList.unit = @"趟";
    }
    
    NSLog(@"%@=%@=%@",_priceList.priceName,_priceList.price,_priceList.unit);
//
//    self.priceID += 1;
    
    
//    if ([self.delegate respondsToSelector:@selector(passPriceInformation:mode:price:unit:)]) {
//        [self.delegate passPriceInformation:self mode:self. price:<#(NSUInteger)#> unit:<#(NSString *)#>]
//    }
    if ([self.delegate respondsToSelector:@selector(passPriceInformation:obj:)]) {
        [self.delegate passPriceInformation:self obj:_priceList];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
