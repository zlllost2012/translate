//
//  DictionaryController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "DictionaryController.h"

@interface DictionaryController ()

@end

@implementation DictionaryController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nil bundle:nil];
    if(self){
        //获取tabbaritem属性所指向的uitabbaritem对象
//        UITabBarItem *tbi=[self tabBarItem];
//        [tbi setTitle:@"字典"];
        UINavigationItem *nbi=[self navigationItem];
        UIBarButtonItem *moreBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more.png"] style:UIBarButtonItemStyleDone target:self action:@selector(more:)];
        [nbi setRightBarButtonItem:moreBtn];
        [nbi setTitle:@"维汉学习通"];
        searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [searchBar setBackgroundColor:[UIColor clearColor]];
        searchBar.delegate=self;
//        [nbi setTitleView:searchBar];
        tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.view addSubview:tableView];
//        UINib *nib=[UINib nibWithNibName:@"ChineseToUyghurCell" bundle:nil];
//        [tableView registerNib:nib forCellReuseIdentifier:@"ChineseToUyghurCell"];
//        if([showData count]>0){
//            [tableView setAlpha:1.f];
//        }else{
//            [tableView setAlpha:0.f];
//        }

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [showData count]>0?[showData count]:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ChineseToUyghurCell";
    if([showData count]>0){
        TempLanguageItem *item=(TempLanguageItem *)[showData objectAtIndex:[indexPath row]];
        ChineseToUyghurCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell==nil){
            cell=[[ChineseToUyghurCell alloc]initWithReuseIdentifier:CellIdentifier];
        }
        [cell setIWyText:item.weiyu_info HyText:item.hanyu_info];
        return cell;
    }else{
        return nil;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return searchBar;
}
-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TempLanguageItem *item=(TempLanguageItem *)[showData objectAtIndex:[indexPath row]];
    BOOL isExist=false;
    for(HistoryItem *i in [[HistoryStore sharedStore]loadAllItems]){
        if([i.hanyu_info isEqualToString:item.hanyu_info]&&[i.weiyu_info isEqualToString:item.weiyu_info]){
            isExist=true;
            break;
        }
    }
    if (!isExist) {
        //存储阅读记录
        HistoryItem *historyItem=[[HistoryStore sharedStore]createItem];
        [historyItem setNum:item.num];
        [historyItem setHanyu_info:item.hanyu_info];
        [historyItem setHanyu_num:item.hanyu_num];
        [historyItem setHanyu_sound_id:item.hanyu_sound_id];
        [historyItem setWeiyu_info:item.weiyu_info];
        [historyItem setWeiyu_num:item.weiyu_num];
        [historyItem setWeiyu_sound_id:item.weiyu_sound_id];
        [historyItem setDr:item.dr];
        [historyItem setDr_num_px:item.dr_num_px];
        [[HistoryStore sharedStore]saveChanges];
    }
    TranslateController *ctu=[[TranslateController alloc]initWithItem:item];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:ctu animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(tableView.contentOffset.y>0||tableView.contentOffset.y<0){
        [searchBar resignFirstResponder];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [searchBar resignFirstResponder];
}
-(CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView1 cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if(tableView.contentOffset.y>1){
//        self.tabBarController.tabBar.hidden = YES;
//        
//    }else{
//        self.tabBarController.tabBar.hidden = NO;
//        
//    }
//}
-(void)searchBar:(UISearchBar *)searchB textDidChange:(NSString *)searchText{
    if(searchB.text!=nil&&searchB.text.length>0){
        showData=[[SQLiteManager shareStore]selectDataByChinese:searchB.text];
        if([showData count]==0){
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            //申明返回的结果是json类型
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            //    //申明请求的数据是json类型
            //    manager.requestSerializer=[AFJSONRequestSerializer serializer];
            //如果报接受类型不一致请替换一致text/html或别的
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
            NSDictionary *parameters = @{@"name": @"string"};
            [manager POST:POST_URL parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSString *errStr=[error localizedDescription];
                NSLog(@"%@",errStr);
            }];

        }
        [tableView reloadData];
//        [tableView setAlpha:1.f];
    }
//    else{
//        [tableView setAlpha:0.f];
//    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchB{
    [self searchBar:searchB textDidChange:nil];
    [searchB resignFirstResponder];
}
-(void)moreBack{
    [self setHidesBottomBarWhenPushed:NO];
    [self.navigationController popToViewController:self animated:YES];
}
-(void)more:(id)sender{
    MoreController *moreController=[[MoreController alloc]init];
    [moreController setDelegate:self];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:moreController animated:YES];
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
