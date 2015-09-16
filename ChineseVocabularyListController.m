//
//  VocabularyListController.m
//  Translate
//
//  Created by zz on 15/9/14.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "ChineseVocabularyListController.h"

@interface ChineseVocabularyListController ()

@end

@implementation ChineseVocabularyListController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UINib *nib=[UINib nibWithNibName:@"ChineseToUyghurCell" bundle:nil];
    [[self tableView]registerNib:nib forCellReuseIdentifier:@"ChineseToUyghurCell"];
    searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(40., 0, self.view.frame.size.width-40., 44.)];
    [searchBar setBackgroundColor:[UIColor clearColor]];
    [searchBar setDelegate:self];
    [searchBar setBarStyle:UIBarStyleDefault];
    [searchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [searchBar setPlaceholder:@"请输入词语查询"];
    [searchBar setKeyboardType:UIKeyboardTypeDefault];
    UINavigationItem *nbi=[self navigationItem];
    UIBarButtonItem *leftBarBtn=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backHome:)];
    [nbi setTitleView:searchBar];
    [nbi setLeftBarButtonItem:leftBarBtn];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    NSArray *tempList;
    if(isSearch){
        tempList=[NSArray arrayWithArray:showData];
    }else{
        tempList=[NSArray arrayWithArray:vocList];
    }
    if([tempList count]>0){
        TempLanguageItem *item=(TempLanguageItem *)[tempList objectAtIndex:[indexPath row]];
        ChineseToUyghurCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ChineseToUyghurCell"];
        [[cell chineseLabel]setText:item.hanyu_info];
        [[cell uyghurLabel]setText:item.weiyu_info];
        return cell;
    }else{
        return nil;
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TempLanguageItem *item=(TempLanguageItem *)[vocList objectAtIndex:[indexPath row]];
    ChineseToUyghurController *ctu=[[ChineseToUyghurController alloc]initWithItem:item];
    [self.navigationController pushViewController:ctu animated:YES];
}

-(void)searchBar:(UISearchBar *)searchB textDidChange:(NSString *)searchText{
    if(searchB.text!=nil&&searchB.text.length>0){
        showData=[[SQLiteManager shareStore]selectDataByChinese:searchB.text];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
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
