//
//  HistoryController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "HistoryController.h"

@interface HistoryController ()

@end

@implementation HistoryController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nil bundle:nil];
    if(self){
        //获取tabbaritem属性所指向的uitabbaritem对象
        //        UITabBarItem *tbi=[self tabBarItem];
        //        [tbi setTitle:@"字典"];
        UINavigationItem *nbi=[self navigationItem];
        UIBarButtonItem *moreBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"more.png"] style:UIBarButtonItemStyleDone target:self action:@selector(more:)];
        UIBarButtonItem *clearBtn=[[UIBarButtonItem alloc]initWithTitle:@"清除记录" style:UIBarButtonItemStyleDone target:self action:@selector(clear:)];
        [nbi setRightBarButtonItem:moreBtn];
        [nbi setLeftBarButtonItem:clearBtn];
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
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    //    if([showData count]>0){
    //        [tableView setAlpha:1.f];
    //    }else{
    //        [tableView setAlpha:0.f];
    //    }
    [tableView reloadData];
}
-(void)loadData{
    allData=[[HistoryStore sharedStore]loadAllItems];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(searchBar.text!=nil&&searchBar.text.length>0){
        return [showData count]>0?[showData count]:0;
    }else{
        return [allData count]>0?[allData count]:0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return searchBar;
}
-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ChineseToUyghurCell";
    if(searchBar.text!=nil&&searchBar.text.length>0){
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
        
    }else{
        if([allData count]>0){
            TempLanguageItem *item=(TempLanguageItem *)[allData objectAtIndex:[indexPath row]];
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TempLanguageItem *item;
    if(searchBar.text!=nil&&searchBar.text.length>0){
        item=(TempLanguageItem *)[showData objectAtIndex:[indexPath row]];
        //        [tableView setAlpha:1.f];
    }else{
        item=(TempLanguageItem *)[allData objectAtIndex:[indexPath row]];
    }
    
    TranslateController *ctu=[[TranslateController alloc]initWithItem:item];
    [self.navigationController pushViewController:ctu animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView1 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView1 cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
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
-(void)searchBar:(UISearchBar *)searchB textDidChange:(NSString *)searchText{
    if(searchB.text!=nil&&searchB.text.length>0){
        //此处修改为查找coredata数据
        showData=[[HistoryStore sharedStore] selectItem:searchB.text];
        //        [tableView setAlpha:1.f];
    }
    [tableView reloadData];
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
-(void)clear:(id)sender{
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在清理...";
    [[HistoryStore sharedStore]removeAll];
    [[HistoryStore sharedStore]saveChanges];
    [hud hide:YES afterDelay:1];
    hud.labelText=@"清理完成";
    [hud setMode:MBProgressHUDModeCustomView];
    [self loadData];
    [tableView reloadData];
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
