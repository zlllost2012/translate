//
//  UyghurVocabularyController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "UyghurVocabularyController.h"

@interface UyghurVocabularyController ()

@end

@implementation UyghurVocabularyController
@synthesize bdelegate;
-(id)initWithStyle:(UITableViewStyle)style withArray:(NSArray *)vocArr
{
    self=[super initWithStyle:style];
    if(self){
        isSearch=false;
        vocList=[NSArray arrayWithArray:vocArr];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
//    UINib *nib=[UINib nibWithNibName:@"UyghurToChineseCell" bundle:nil];
//    [[self tableView]registerNib:nib forCellReuseIdentifier:@"UyghurToChineseCell"];
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(40., 0, self.view.frame.size.width-40., 44.)];
    [searchBar setBackgroundColor:[UIColor clearColor]];
    [searchBar setDelegate:self];
    [searchBar setBarStyle:UIBarStyleDefault];
    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [searchBar setPlaceholder:@"请输入词语查询"];
    [searchBar setKeyboardType:UIKeyboardTypeDefault];
    UINavigationItem *nbi=[self navigationItem];
    UIBarButtonItem *leftBarBtn=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backHome:)];
    [nbi setTitle:@"汉语学习"];
    [nbi setLeftBarButtonItem:leftBarBtn];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (isSearch) {
        return [showData count];
    }else{
        return [vocList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UyghurToChineseCell";
    NSArray *tempList;
    if(isSearch){
        tempList=[NSArray arrayWithArray:showData];
    }else{
        tempList=[NSArray arrayWithArray:vocList];
    }
    if([tempList count]>0){
        TempLanguageItem *item=(TempLanguageItem *)[tempList objectAtIndex:[indexPath row]];
//        UyghurToChineseCell *cell=[tableView dequeueReusableCellWithIdentifier:@"UyghurToChineseCell"];
        UyghurToChineseCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(cell==nil){
            cell=[[UyghurToChineseCell alloc]initWithReuseIdentifier:CellIdentifier];
        }
        [cell setIWyText:item.weiyu_info HyText:item.hanyu_info];
//        [[cell chineseLabel]setText:item.hanyu_info];
//        [[cell uyghurLabel]setText:item.weiyu_info];
        return cell;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return searchBar;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TempLanguageItem *item;
    if(isSearch){
        item=(TempLanguageItem *)[showData objectAtIndex:[indexPath row]];
    }else{
        item=(TempLanguageItem *)[vocList objectAtIndex:[indexPath row]];
    }
    
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

    UyghurToChineseController *ctu=[[UyghurToChineseController alloc]initWithItem:item];
    [self.navigationController pushViewController:ctu animated:YES];
}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if(self.tableView.contentOffset.y>1){
//        self.tabBarController.tabBar.hidden = YES;
//        
//    }else{
//        self.tabBarController.tabBar.hidden = NO;
//        
//    }
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.tableView.contentOffset.y>0||self.tableView.contentOffset.y<0){
        [searchBar resignFirstResponder];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [searchBar resignFirstResponder];
}
-(void)searchBar:(UISearchBar *)searchB textDidChange:(NSString *)searchText{
    if(searchB.text!=nil&&searchB.text.length>0){
        showData=[[SQLiteManager shareStore]selectDataByUyghur:searchB.text];
        isSearch=true;
        [self.tableView reloadData];
    }else{
        isSearch=false;
        [self.tableView reloadData];
    }
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchB{
    [self searchBar:searchB textDidChange:nil];
    [searchB resignFirstResponder];
}

-(void)backHome:(id)sender
{
    [self.bdelegate back];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
