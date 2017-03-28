//
//  WL_EditPrivateLetter_ViewController.m
//  WeiLvDJS
//
//  Created by jyc on 2016/11/11.
//  Copyright © 2016年 WeiLvDJS. All rights reserved.
//

#import "WL_EditPrivateLetter_ViewController.h"
#import "WL_AddPersonCollectionViewCell.h"
#import "WL_SeleectReceiver_ViewController.h"
#import "WL_ShareArray.h"
#import "WL_Save_Model.h"
#import "WL_SelectedFriend_ViewController.h"
#import "WL_PrivateLetter_ViewController.h"

@interface WL_EditPrivateLetter_ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextViewDelegate>

@property(nonatomic,strong)UICollectionView *collection;
@property(nonatomic,strong)XKPEPlaceholderTextView *privateLetterTextView;
@property(nonatomic,strong)UILabel *privateNumber;
@property(nonatomic,strong)NSMutableArray *privateLetterArray;
@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)NSMutableString *letter;

@end

static NSString *collectionCell =@"collectionCell";

@implementation WL_EditPrivateLetter_ViewController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    self.letter =[NSMutableString stringWithString:@""];
    self.view.backgroundColor = BgViewColor;
    self.navigationItem.title = @"编辑私信";
    [self setNavigationRightTitle:@"发送" fontSize:17 titleColor:[UIColor whiteColor] isEnable:YES];
    [self createUI];
}

-(void)NavigationLeftEvent
{
    [[WL_ShareArray shareArray].saveArray removeAllObjects];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableArray *)privateLetterArray
{
    
    if (_privateLetterArray==nil) {
        _privateLetterArray =[[NSMutableArray alloc]init];
    }
    return _privateLetterArray;
}

-(void)createUI
{
    CGFloat height = 0;
    if (IsiPhone5) {
        height =100;
    }else if (IsiPhone6){
        height = 110;
    }else if (IsiPhone6P){
        height = 110;
    }
    UIView *topView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, height)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 45)];
    leftLabel.font =WLFontSize(14);
    leftLabel.textColor = BlackColor;
    leftLabel.text = @"接收人";
    [topView addSubview:leftLabel];
    
    self.numberLabel =[[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-60, 0, 50, 45)];
    self.numberLabel.font =WLFontSize(14);
    self.numberLabel.text =[NSString stringWithFormat:@"%lu人",[WL_ShareArray shareArray].saveArray.count];
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    self.numberLabel.textColor = WLColor(105, 125, 229, 1);
    [topView addSubview:self.numberLabel];

    //1.先创建一个UIcollectionViewFlowLayout(是集合视图的核心)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //2.对layout做一些基本设置
    if (IsiPhone6){
        layout.itemSize = CGSizeMake(45, 45);
    }else if (IsiPhone6P){
        layout.itemSize = CGSizeMake(45, 45);
    }else{
        layout.itemSize = CGSizeMake(40, 40);

    }
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, ScreenWidth, 60) collectionViewLayout:layout];
    self.collection.dataSource =self;
    self.collection.delegate = self;
    //设置水平方向滚动
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collection.backgroundColor =[UIColor whiteColor];
    self.collection.showsHorizontalScrollIndicator = NO;
    [self.collection registerClass:[WL_AddPersonCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
    [topView addSubview:self.collection];
    
    UIView *privateLetterContent = [[UIView alloc]initWithFrame:CGRectMake(0, ViewBelow(topView)+15, ScreenWidth, 160)];
    privateLetterContent.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:privateLetterContent];
    
    
    UILabel *content =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 40)];
    content.textColor = BlackColor;
    content.font =WLFontSize(14);
    content.text = @"私信内容";
    [privateLetterContent addSubview:content];
    
    self.privateNumber = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-100, 0, 90, 40)];
    self.privateNumber.textColor = WLColor(105, 125, 229, 1);
    self.privateNumber.text = @"0/300";
    self.privateNumber.textAlignment = NSTextAlignmentRight;
    self.privateNumber.font =WLFontSize(14);
    [privateLetterContent addSubview:self.privateNumber];
    
    self.privateLetterTextView = [[XKPEPlaceholderTextView alloc]initWithFrame:CGRectMake(6, ViewBelow(content), ScreenWidth-20, 120)];
    self.privateLetterTextView.font = WLFontSize(14);
    self.privateLetterTextView.textColor = BlackColor;
    self.privateLetterTextView.delegate =self;
    self.privateLetterTextView.placeholder = @"点击输入文字...";
    CGFloat toolBarH=0;
    if (IsiPhone4){
        toolBarH=33;
    }else if(IsiPhone5){
        toolBarH=33;
    }else if (IsiPhone6){
        toolBarH=35;
    }else if (IsiPhone6P){
        toolBarH =42;
    }
    
    //给键盘 添加 setInputAccessoryView 可以点击完成 让键盘退出
    UIToolbar * view = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, toolBarH)];
    [view setBarStyle:UIBarStyleDefault];
    topView.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoardHidden)];
    NSArray * buttonsArray = @[btnSpace,doneButton];
    [view setItems:buttonsArray];
    self.privateLetterTextView.inputAccessoryView = view;
    [privateLetterContent addSubview:self.privateLetterTextView];
    
}

-(void)dismissKeyBoardHidden
{
    
    [self.privateLetterTextView resignFirstResponder];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.privateLetterArray.count==0) {
        return 1;
    }
    return self.privateLetterArray.count+2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (IsiPhone6){
        return 15;
    }else if(IsiPhone6P){
        return 20;
    }
    return 10;//上,左,下,右
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if (IsiPhone6){
        return UIEdgeInsetsMake(10, 15, 10, 10);
        
    }else if(IsiPhone6P){
        return UIEdgeInsetsMake(10, 20, 10, 10);
    }
    return UIEdgeInsetsMake(10, 13, 10, 10);//上,左,下,右
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WL_AddPersonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    if (cell==nil) {     
        cell = [[WL_AddPersonCollectionViewCell alloc]init];
        
    }
    if (self.privateLetterArray.count==0) {
        cell.headerImageView.image =[UIImage imageNamed:@"AddPrivate"];
        
    }else{
        if (indexPath.row<self.privateLetterArray.count) {
           
            WL_Save_Model *model = self.privateLetterArray[indexPath.row];
            cell.headerImageView.layer.cornerRadius = cell.frame.size.width/2;
            cell.headerImageView.layer.masksToBounds = YES;
            [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] placeholderImage:[UIImage imageNamed:@"WLPhotoPlaceHolder"]];
        }else{
            if (indexPath.row == self.privateLetterArray.count) {
                
                cell.headerImageView.image =[UIImage imageNamed:@"AddPrivate"];
                
            }else if (indexPath.row == self.privateLetterArray.count +1){
                cell.headerImageView.image =[UIImage imageNamed:@"DeletePrivate"];
            }
        }
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // WS(weakSelf);
    
    WL_AddPersonCollectionViewCell *cell = (WL_AddPersonCollectionViewCell *)[self.collection cellForItemAtIndexPath:indexPath];
    
    if ([cell.headerImageView.image isEqual:[UIImage imageNamed:@"AddPrivate"]]) {
        WL_SeleectReceiver_ViewController *VC = [[WL_SeleectReceiver_ViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }else if ([cell.headerImageView.image isEqual:[UIImage imageNamed:@"DeletePrivate"]]){
        
        WL_SelectedFriend_ViewController *VC =[[WL_SelectedFriend_ViewController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
        
    }
}

-(void)reloadCellectionViewWith:(NSMutableDictionary *)dictionary
{
    WlLog(@"%@",[WL_ShareArray shareArray].saveArray);
    
    [self.privateLetterArray removeAllObjects];
    [WL_ShareArray shareArray].saveArray = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    NSMutableArray *mutaArray =[[NSMutableArray alloc]init];
    [mutaArray addObjectsFromArray:[dictionary allValues]];
    self.numberLabel.text =[NSString stringWithFormat:@"%lu人",mutaArray.count];
    if (mutaArray.count>=4){
        for (NSInteger i=mutaArray.count-4;i<mutaArray.count;i++) {
            [self.privateLetterArray addObject:mutaArray[i]];
        }
    }else{
        [self.privateLetterArray addObjectsFromArray:mutaArray];
    
    }
    [self.collection reloadData];
}

-(void)textViewDidChange:(UITextView *)textView
{
    WlLog(@"%lu",(unsigned long)textView.text.length);
    
    if (textView.text.length>=300){
        self.privateLetterTextView.text = [textView.text substringToIndex:300];
    }
    self.privateNumber.text = [NSString stringWithFormat:@"%lu/300",(unsigned long)textView.text.length];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.privateLetterTextView resignFirstResponder];
}

-(void)NavigationRightEvent
{
    if ([[WL_ShareArray shareArray].saveArray allValues].count==0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请选择接收人"];
        return;
    }
    
    if (self.privateLetterTextView.text.length==0) {
        [[WL_TipAlert_View sharedAlert]createTip:@"请输入私信内容"];
        return;
    }
    NSString *userId = [WLUserTools getUserId];
    
    NSString *passWord =[WLUserTools getUserPassword];
    
    //进行RSA加密后的密码字符串
    NSString *encryptStr =[MyRSA encryptString:passWord publicKey:RSAKey];
    
    for (WL_Save_Model *saveMode in [[WL_ShareArray shareArray].saveArray allValues]) {
        
        [self.letter appendFormat:@"%@,",saveMode.user_id];
    }
    
    NSDictionary *paramaters =@{@"user_id":userId,@"user_password":encryptStr,@"receiveId":self.letter,@"content":self.privateLetterTextView.text};

    [[WLHttpManager shareManager]requestWithURL:LetterAddLetterPrivate RequestType:RequestTypePost Parameters:paramaters Success:^(id responseObject) {
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([netModel.result integerValue]==1) {
            
            [[WL_TipAlert_View sharedAlert]createTip:@"发送成功"];
            
            WL_PrivateLetter_ViewController *VC =[[WL_PrivateLetter_ViewController alloc]init];
            
            [self.navigationController pushViewController:VC animated:YES];
            
        }else{
            [[WL_TipAlert_View sharedAlert]createTip:netModel.msg];
        }
        
    } Failure:^(NSError *error) {
        
        [[WL_TipAlert_View sharedAlert]createTip:@"发送失败"];

    }];

}

@end
