//
//  DictionaryController.m
//  Translate
//
//  Created by zz on 15/9/11.
//  Copyright (c) 2015年 zz. All rights reserved.
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
        searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        [searchBar setBackgroundColor:[UIColor clearColor]];
        searchBar.delegate=self;
        [nbi setTitleView:searchBar];
        tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.view addSubview:tableView];
        UINib *nib=[UINib nibWithNibName:@"ChineseToUyghurCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:@"ChineseToUyghurCell"];
        if([showData count]>0){
            [tableView setAlpha:1.f];
        }else{
            [tableView setAlpha:0.f];
        }

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [showData count]>0?[showData count]:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([showData count]>0){
        TempLanguageItem *item=(TempLanguageItem *)[showData objectAtIndex:[indexPath row]];
        ChineseToUyghurCell *cell=[tableView1 dequeueReusableCellWithIdentifier:@"ChineseToUyghurCell"];
        [[cell chineseLabel]setText:item.hanyu_info];
        [[cell uyghurLabel]setText:item.weiyu_info];
        return cell;
    }else{
        return nil;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(void)tableView:(UITableView *)tableView1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TempLanguageItem *item=(TempLanguageItem *)[showData objectAtIndex:[indexPath row]];
    ChineseToUyghurController *ctu=[[ChineseToUyghurController alloc]initWithItem:item];
    [self.navigationController pushViewController:ctu animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.;
}

-(void)searchBar:(UISearchBar *)searchB textDidChange:(NSString *)searchText{
    if(searchB.text!=nil&&searchB.text.length>0){
        showData=[[SQLiteManager shareStore]selectDataByChinese:searchB.text];
        [tableView reloadData];
        [tableView setAlpha:1.f];
    }else{
        [tableView setAlpha:0.f];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchB{
    [self searchBar:searchB textDidChange:nil];
    [searchB resignFirstResponder];
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
