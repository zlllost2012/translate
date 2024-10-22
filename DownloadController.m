//
//  DownloadController.m
//  Translate
//
//  Created by zll on  15/9/14.
//  Copyright (c) 2015年 zll. All rights reserved.
//

#import "DownloadController.h"

@interface DownloadController ()

@end

@implementation DownloadController
@synthesize operation=_operation;
- (void)viewDidLoad {
    [super viewDidLoad];
    isDownload=false;
    UINavigationItem *nbi=[self navigationItem];
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    [nbi setLeftBarButtonItem:backItem];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView{
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height-44.-20.;
    float oy=self.view.frame.origin.y+44.+20.;
    downloadBtn=[[UIButton alloc]initWithFrame:CGRectMake(20., oy+20., width-40., 60)];
    [downloadBtn setBackgroundColor:[UIColor colorWithRed:66/255. green:163/255. blue:61/255. alpha:1.]];
    [self setButtonStyle:downloadBtn];
    
    progressView=[[ASProgressPopUpView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    [progressView setFrame:CGRectMake(20, oy+20.+170., width-40., 5.)];
    progressView.popUpViewCornerRadius=12.0;
    progressView.font=[UIFont fontWithName:@"Futura-CondensedExtraBold" size:28];
    progressLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, oy+20.+170.+10., width, 40.)];
    [progressLabel setTextAlignment:NSTextAlignmentCenter];
    
    unZip=[[UIButton alloc]initWithFrame:CGRectMake(20., 20.+oy+170.+40.+10., width-40., 60)];
    [unZip setTitle:@"解压" forState:UIControlStateNormal];
    [unZip setBackgroundColor:[UIColor colorWithRed:218./255. green:152./255. blue:38./255. alpha:1.]];
    [self setButtonStyle:unZip];
    [unZip addTarget:self action:@selector(unZipClick:) forControlEvents:UIControlEventTouchDown];
    NSArray *arr=[[ZipFileInfoStore sharedStore]allItems];
    ZipFileInfoItem *zipFile;
    if([arr count]>0){
        zipFile=[arr lastObject];
        zipName=zipFile.fileName;
    }else{
        zipFile=[[ZipFileInfoStore sharedStore]createItem];
        [[ZipFileInfoStore sharedStore]saveChanges];
    }
    [progressView setProgress:(float)[zipFile.fileCurSize longLongValue]/[zipFile.fileSize longLongValue] animated:YES];
    [progressLabel setText:[NSString stringWithFormat:@"%.2fM/%.2fM",(float)[zipFile.fileCurSize longLongValue]/1024/1024,(float)[zipFile.fileSize longLongValue]/1024/1024]];
    //已经解压缩
    if (zipFile.isUnzip) {
        [downloadBtn setTitle:@"重新下载" forState:UIControlStateNormal];
        [downloadBtn addTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
        [progressView showPopUpViewAnimated:YES];
        [unZip setAlpha:0.f];
        [downloadBtn setAlpha:1.f];
        [progressView setAlpha:0.f];
        [progressLabel setAlpha:0.f];
    }else{
        //当已存在下载文件且文件不完整时，直接开始下载；否则显示下载按钮手动下载
        if ([zipFile.fileCurSize longLongValue]>0&&[zipFile.fileCurSize longLongValue]<[zipFile.fileSize longLongValue]) {
            hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText=@"正在获取数据";
            NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com"];
            AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
            
            //        NSOperationQueue *operationQueue = manager.operationQueue;
            [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
                switch (status) {
                    case AFNetworkReachabilityStatusReachableViaWWAN:{
                        NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                        [hud hide:YES];
                        [downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
                        [downloadBtn addTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchDown];
                        [progressView showPopUpViewAnimated:YES];
                        [unZip setAlpha:0.f];
                        [downloadBtn setAlpha:1.f];
                        [progressView setAlpha:1.f];
                        [progressLabel setAlpha:1.f];
                        isDownload=true;
                        [self startDownload];
                    }
                        break;
                    case AFNetworkReachabilityStatusReachableViaWiFi:
                    {
                        NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                        [hud hide:YES];
                        [downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
                        [downloadBtn addTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchDown];
                        [progressView showPopUpViewAnimated:YES];
                        [unZip setAlpha:0.f];
                        [downloadBtn setAlpha:1.f];
                        [progressView setAlpha:1.f];
                        [progressLabel setAlpha:1.f];
                        isDownload=true;
                        [self startDownload];
                    }
                        break;
                    case AFNetworkReachabilityStatusNotReachable:{
                        [downloadBtn setTitle:@"开始下载" forState:UIControlStateNormal];
                        [downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
                        [progressView showPopUpViewAnimated:NO];
                        [unZip setAlpha:0.f];
                        [downloadBtn setAlpha:1.f];
                        [progressView setAlpha:0.f];
                        [progressLabel setAlpha:0.f];
                        isDownload=false;
                        NSLog ( @"-------AFNetworkReachabilityStatusReachableNo------" );
                        hud.labelText=@"无网络连接";
                        [hud setMode:MBProgressHUDModeCustomView];
                        [hud hide:YES afterDelay:1];
                    }
                        break;
                    default:
                        break;
                }
            }];
            
            [manager.reachabilityManager startMonitoring];
        }else if([zipFile.fileCurSize longLongValue]>0&&[zipFile.fileCurSize longLongValue]>=[zipFile.fileSize longLongValue]){
            [downloadBtn setTitle:@"重新下载" forState:UIControlStateNormal];
            [downloadBtn addTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
            [progressView showPopUpViewAnimated:YES];
            [unZip setAlpha:1.f];
            [downloadBtn setAlpha:1.f];
            [progressView setAlpha:0.f];
            [progressLabel setAlpha:0.f];
        }else{
            [downloadBtn setTitle:@"开始下载" forState:UIControlStateNormal];
            [downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
            [progressView showPopUpViewAnimated:NO];
            [unZip setAlpha:0.f];
            [downloadBtn setAlpha:1.f];
            [progressView setAlpha:0.f];
            [progressLabel setAlpha:0.f];
        }
        
    }
    
    [self.view addSubview:progressView];
    [self.view addSubview: downloadBtn];
    [self.view addSubview:unZip];
    [self.view addSubview:progressLabel];
}
-(void)setButtonStyle:(UIButton *)o{
    [o.layer setMasksToBounds:YES];
    [o.layer setCornerRadius:5.0];
    //设置矩形四个圆角半径
    //    [o.layer setBorderWidth:1.0];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

//返回
-(void)back:(id)sender{
    if (isDownload) {
        [[ZipFileInfoStore sharedStore]saveChanges];
        [_operation pause];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
//开始下载
-(void)download:(UIButton *)sender{
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在请求数据";
    NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    //        NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                [hud hide:YES];
                [downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
                [downloadBtn removeTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
                [downloadBtn removeTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
                [downloadBtn addTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchDown];
                [unZip setAlpha:0.f];
                [downloadBtn setAlpha:1.f];
                [progressView setAlpha:1.f];
                [progressLabel setAlpha:1.f];
                if(!isDownload){
                    NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                    [self startDownload];
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [hud hide:YES];
                [downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
                [downloadBtn removeTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
                [downloadBtn removeTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
                [downloadBtn addTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchDown];
                [unZip setAlpha:0.f];
                [downloadBtn setAlpha:1.f];
                [progressView setAlpha:1.f];
                [progressLabel setAlpha:1.f];
                if(!isDownload){
                    NSLog ( @"-------AFNetworkReachabilityStatusReachableViaWWAN------" );
                    [self startDownload];
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                isDownload=false;
                NSLog ( @"-------AFNetworkReachabilityStatusReachableNo------" );
                hud.labelText=@"无网络连接";
                [hud setMode:MBProgressHUDModeCustomView];
                [hud hide:YES afterDelay:1];
            }
                break;
            default:
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];

}
//暂停下载
-(void)pauseDownload:(id)sender{
    [downloadBtn setTitle:@"继续下载" forState:UIControlStateNormal];
    [downloadBtn removeTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
    [downloadBtn removeTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchDown];
    [downloadBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
    [unZip setAlpha:0.f];
    [downloadBtn setAlpha:1.f];
    [progressView setAlpha:1.f];
    [progressLabel setAlpha:1.f];
    if (isDownload) {
        [[ZipFileInfoStore sharedStore]saveChanges];
        [_operation pause];
    }
    isDownload=false;
}
//重新下载
-(void)reDownload:(id)sender{
    
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在请求数据";
    NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com"];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    //        NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                [hud hide:YES];
                [downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
                [downloadBtn removeTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
                [downloadBtn removeTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
                [downloadBtn addTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchDown];
                [unZip setAlpha:0.f];
                [downloadBtn setAlpha:1.f];
                [progressView setAlpha:1.f];
                [progressLabel setAlpha:1.f];
                if (!isDownload) {
                    [_operation cancel];
                }
                NSArray *arr=[[ZipFileInfoStore sharedStore]allItems];
                ZipFileInfoItem *zipFile;
                if([arr count]>0){
                    zipFile=[arr lastObject];
                }else{
                    zipFile=[[ZipFileInfoStore sharedStore]createItem];
                    [[ZipFileInfoStore sharedStore]saveChanges];
                }
                
                [zipFile setFileName:@""];
                [zipFile setFileSize:@""];
                [zipFile setFileCurSize:@""];
                [zipFile setFilePath:@""];
                [zipFile setIsUnzip:NO];
                [[ZipFileInfoStore sharedStore]saveChanges];
                //清除缓存
                NSArray *array=[DOWNLOAD_URL componentsSeparatedByString:@"/"];
                zipName=[array lastObject];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                
                NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                
                NSString *delelteFilePath = [documentsDirectory stringByAppendingPathComponent:zipName];
                
                NSError *error;
                
                if ([fileManager removeItemAtPath:delelteFilePath error:&error] != YES)
                    
                    NSLog(@"Unable to delete file: %@", [error localizedDescription]);

                [self startDownload];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [hud hide:YES];
                [downloadBtn setTitle:@"暂停" forState:UIControlStateNormal];
                [downloadBtn removeTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
                [downloadBtn removeTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
                [downloadBtn addTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchDown];
                [unZip setAlpha:0.f];
                [downloadBtn setAlpha:1.f];
                [progressView setAlpha:1.f];
                [progressLabel setAlpha:1.f];
                if (!isDownload) {
                    [_operation cancel];
                }
                NSArray *arr=[[ZipFileInfoStore sharedStore]allItems];
                ZipFileInfoItem *zipFile;
                if([arr count]>0){
                    zipFile=[arr lastObject];
                }else{
                    zipFile=[[ZipFileInfoStore sharedStore]createItem];
                    [[ZipFileInfoStore sharedStore]saveChanges];
                }
                
                [zipFile setFileName:@""];
                [zipFile setFileSize:@""];
                [zipFile setFileCurSize:@""];
                [zipFile setFilePath:@""];
                [zipFile setIsUnzip:NO];
                [[ZipFileInfoStore sharedStore]saveChanges];
                //清除缓存
                NSArray *array=[DOWNLOAD_URL componentsSeparatedByString:@"/"];
                zipName=[array lastObject];
                NSFileManager *fileManager = [NSFileManager defaultManager];
                
                NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0];
                
                NSString *delelteFilePath = [documentsDirectory stringByAppendingPathComponent:zipName];
                
                NSError *error;
                
                if ([fileManager removeItemAtPath:delelteFilePath error:&error] != YES)
                    
                    NSLog(@"Unable to delete file: %@", [error localizedDescription]);

                [self startDownload];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog ( @"-------AFNetworkReachabilityStatusReachableNo------" );
                hud.labelText=@"无网络连接";
                [hud setMode:MBProgressHUDModeCustomView];
                [hud hide:YES afterDelay:1];
            }
                break;
            default:
                break;
        }
    }];
    
    [manager.reachabilityManager startMonitoring];

}
//开始继续下载
-(void)startDownload{
    __block UIViewController *controller=self;
    __block ASProgressPopUpView *pv=progressView;
    __block UILabel *pl=progressLabel;
    __block MBProgressHUD *h=hud;
    isDownload=true;
    NSArray *arr=[[ZipFileInfoStore sharedStore]allItems];
    ZipFileInfoItem *zipFile;
    if([arr count]>0){
        zipFile=[arr lastObject];
    }else{
        zipFile=[[ZipFileInfoStore sharedStore]createItem];
        [[ZipFileInfoStore sharedStore]saveChanges];
    }
    
    //判断是否存在文件
    NSArray *array=[DOWNLOAD_URL componentsSeparatedByString:@"/"];
    zipName=[array lastObject];
    [zipFile setFileName:zipName];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *writbaleZipPath=[documentsDirectory stringByAppendingPathComponent:zipName];
    [zipFile setFilePath:writbaleZipPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:DOWNLOAD_URL]];
    
    unsigned long long downloadedBytes = 0;
    if(!zipFile.isUnzip||!([zipFile.fileCurSize longLongValue]>0&&[zipFile.fileCurSize longLongValue]>=[zipFile.fileSize longLongValue])){
        //检查文件是否已经下载了一部分
        if ([fileManager fileExistsAtPath:writbaleZipPath]) {
            //获取已下载的文件长度
            downloadedBytes = [self fileSizeForPath:writbaleZipPath];
            if (downloadedBytes > 0) {
                NSMutableURLRequest *mutableURLRequest = [request mutableCopy];
                NSString *requestRange = [NSString stringWithFormat:@"bytes=%llu-", downloadedBytes];
                [mutableURLRequest setValue:requestRange forHTTPHeaderField:@"Range"];
                request = mutableURLRequest;
            }
        }
    }
    //不使用缓存，避免断点续传出现问题
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    //下载请求
    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //下载路径
    _operation.outputStream = [NSOutputStream outputStreamToFileAtPath:writbaleZipPath append:YES];
    //下载进度回调
    [_operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        //下载进度
        [pv setProgress:(float)(totalBytesRead + downloadedBytes)/ (totalBytesExpectedToRead + downloadedBytes) animated:YES];
        [pl setText:[NSString stringWithFormat:@"%.2fM/%.2fM",(float)(totalBytesRead + downloadedBytes)/1024/1024,(float)(totalBytesExpectedToRead + downloadedBytes)/1024/1024]];
        [zipFile setFileCurSize:[NSString stringWithFormat:@"%llu",totalBytesRead + downloadedBytes]];
        [zipFile setFileSize:[NSString stringWithFormat:@"%llu",totalBytesExpectedToRead + downloadedBytes]];
    }];
    //成功和失败回调
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[ZipFileInfoStore sharedStore]saveChanges];
        isDownload=false;
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"下载完成\n是否解压？" delegate:controller cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
        [alert show];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[ZipFileInfoStore sharedStore]saveChanges];
        isDownload=false;
        h.labelText=@"下载出错";
        [h hide:YES afterDelay:2];
    }];
    [_operation start];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            [_operation cancel];
            [downloadBtn setTitle:@"重新下载" forState:UIControlStateNormal];
            [downloadBtn addTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
            [progressView showPopUpViewAnimated:YES];
            [unZip setAlpha:1.f];
            [downloadBtn setAlpha:1.f];
            [progressView setAlpha:0.f];
            [progressLabel setAlpha:0.f];
            //            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1:{
            [_operation cancel];
            hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.labelText=@"正在解压";
            //此处暂停1s
            [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(unZip) userInfo:nil repeats:NO];
        }
            break;
        default:
            break;
    }
}
-(void)unZipClick:(id)sender{
    hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=@"正在解压";
    [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(unZip) userInfo:nil repeats:NO];

//    [self unZip];
}
//解压缩
-(void)unZip{
    // 1. 获取Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSLog(@"paths====%@",paths);
    NSString *docspath = [paths objectAtIndex:0];
    NSString *zipPath = [docspath stringByAppendingPathComponent:zipName];
    NSLog(@"zipPath====%@",zipPath);
    ZipArchive *za = [[ZipArchive alloc] init];
    // 1. 在内存中解压缩文件
    if ([za UnzipOpenFile: zipPath]) {
        // 2. 将解压缩的内容写到缓存目录中
        BOOL ret = [za UnzipFileTo: docspath overWrite: YES];
        if (NO == ret){} [za UnzipCloseFile];
        
        // 3. 使用解压缩后的文件
        //        NSString *imageFilePath = [docspath stringByAppendingPathComponent:@"newTudou.png"];
        //        NSData *imageData = [NSData dataWithContentsOfFile:imageFilePath options:0 error:nil];
        //        UIImage *img = [UIImage imageWithData:imageData];
        // 4. 更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *arr=[[ZipFileInfoStore sharedStore]allItems];
            ZipFileInfoItem *zipFile;
            if([arr count]>0){
                zipFile=[arr lastObject];
            }else{
                zipFile=[[ZipFileInfoStore sharedStore]createItem];
                [[ZipFileInfoStore sharedStore]saveChanges];
            }
            [zipFile setIsUnzip:YES];
            [[ZipFileInfoStore sharedStore]saveChanges];
            hud.labelText=@"解压完成";
            [hud hide:YES afterDelay:1];
            [downloadBtn setTitle:@"重新下载" forState:UIControlStateNormal];
            [downloadBtn removeTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchDown];
            [downloadBtn removeTarget:self action:@selector(pauseDownload:) forControlEvents:UIControlEventTouchDown];
            [downloadBtn addTarget:self action:@selector(reDownload:) forControlEvents:UIControlEventTouchDown];
            [progressView showPopUpViewAnimated:NO];
            [unZip setAlpha:0.f];
            [downloadBtn setAlpha:1.f];
            [progressView setAlpha:0.f];
            [progressLabel setAlpha:0.f];
            isDownload=false;
        });
    }else{
        hud.labelText=@"不存在压缩文件";
        [hud hide:YES afterDelay:1];
    }
}
//获取已下载的文件大小
- (unsigned long long)fileSizeForPath:(NSString *)path {
    signed long long fileSize = 0;
    NSFileManager *fileManager = [NSFileManager new]; // default is not thread safe
    if ([fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        NSDictionary *fileDict = [fileManager attributesOfItemAtPath:path error:&error];
        if (!error && fileDict) {
            fileSize = [fileDict fileSize];
        }
    }
    return fileSize;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/////////
//    success=[fileManager fileExistsAtPath:writbaleZipPath];
//    if(success){
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"文件已下载" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//    }else{
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//
//        NSURL *URL = [NSURL URLWithString:DOWNLOAD_URL];
//            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
//
//        NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//            NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//            return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
//        } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//            NSLog(@"File downloaded to: %@", filePath);
//        }];
//        [downloadTask resume];
/////////
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
