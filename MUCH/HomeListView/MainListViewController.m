//
//  MainListViewController.m
//  MUCH
//
//  Created by 汪洋 on 14/11/22.
//  Copyright (c) 2014年 wy. All rights reserved.
//

#import "MainListViewController.h"
#import "MJRefresh.h"
#import "SliderViewController.h"
#import "ConnectionAvailable.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "MuchApi.h"
#import "GTMBase64.h"
@interface MainListViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSTimeInterval lastOffsetCapture;
    CGPoint lastOffset;
    BOOL isScrollingFast;
    BOOL isShow;
}
@property(nonatomic,retain)UIButton *button;
@property(nonatomic,retain)UIButton *backTopBtn;
@property(nonatomic,retain)UITableView *tableView;
@end

@implementation MainListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    range = @"";
    from = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView setContentOffset:CGPointMake(0, 114) animated:NO];
    self.tableView.separatorStyle = NO;
    self.tableView.backgroundColor = RGBCOLOR(220, 220, 220);
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:[GetImagePath getImagePath:@"menu_icon"] forState:UIControlStateNormal];
    [self.button setFrame:CGRectMake(30, 494, 44, 44)];
    [self.button addTarget:self action:@selector(gotoLeftView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    
    self.backTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backTopBtn setImage:[GetImagePath getImagePath:@"back_to_top"] forState:UIControlStateNormal];
    [self.backTopBtn setFrame:CGRectMake(246, 30, 44, 44)];
    [self.backTopBtn addTarget:self action:@selector(gotoTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backTopBtn];
    self.backTopBtn.alpha = .5;
    showArr = [[NSMutableArray alloc] init];
    //集成刷新控件
    [self setupRefresh];
    [self reloadList];
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (reloadList) name:@"reloadData" object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector (filtrateData:) name:@"filtrate" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //[_tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    NSLog(@"headerRereshing");
    [self reloadList];
}

- (void)footerRereshing
{
    NSLog(@"footerRereshing");
    [[AppDelegate instance]._locService startUserLocationService];
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
    }else{
        startIndex = startIndex +7;
        [MuchApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                //NSLog(@"posts ==> %@",posts);
                [showArr addObjectsFromArray:posts];
                [self.tableView reloadData];
                [self.tableView headerEndRefreshing];
                [self.tableView footerEndRefreshing];
            }
        }start:startIndex indexSize:7 log:[NSString stringWithFormat:@"%f",[AppDelegate instance].coor.longitude] lat:[NSString stringWithFormat:@"%f",[AppDelegate instance].coor.latitude] range:range from:from];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        NSString *stringcell = @"MainListHeadTableViewCell";
        MainListHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[MainListHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell index:0] ;
        }
        cell.delegate = self;
        cell.selectionStyle = NO;
        return cell;
    }else if (indexPath.row == 1){
        NSString *stringcell = @"MainListHeadTableViewCell2";
        MainListHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[MainListHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell index:1] ;
        }
        cell.delegate = self;
        cell.selectionStyle = NO;
        return cell;
    }else{
        NSString *stringcell = @"MainViewTableViewCell";
        MainListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:stringcell];
        if(!cell){
            cell = [[MainListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stringcell] ;
        }
        cell.model = showArr[indexPath.row -2];
        cell.selectionStyle = NO;
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return showArr.count +2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row <2){
        return 57;
    }
    return 175;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row>=2){
        ListModel *model = showArr[indexPath.row-2];
        DetailViewController *detailView = [[DetailViewController alloc] init];
        detailView.aid = model.aid;
        detailView.imageUrl = model.content;
        detailView.youlikeit = [NSString stringWithFormat:@"%@",model.youlikeit];
        detailView.dic = model.createdby;
        detailView.distance = model.distance_str;
        detailView.price = model.price;
        detailView.commentsArr = model.comments;
        [self.navigationController pushViewController:detailView animated:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionHeaderHeight = 114;
    
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        
    }
    // 这里做预加载
    CGPoint currentOffset = scrollView.contentOffset;
    NSTimeInterval currentTime = [NSDate timeIntervalSinceReferenceDate];
    
    NSTimeInterval timeDiff = currentTime - lastOffsetCapture;
    //NSLog(@"%f",timeDiff);
    if(timeDiff > 0.1) {
        CGFloat distance = currentOffset.y - lastOffset.y;
        //The multiply by 10, / 1000 isn't really necessary.......
        CGFloat scrollSpeedNotAbs = (distance * 10) / 1700; //in pixels per millisecond
        
        CGFloat scrollSpeed = fabsf(scrollSpeedNotAbs);
        if (scrollSpeed > 0.5) {
            isScrollingFast = YES;
            //NSLog(@"Fast");
            [UIView animateWithDuration:0.5 animations:^{
                self.button.alpha = 0;
                [self.button removeFromSuperview];
                self.backTopBtn.alpha = 0;
                [self.backTopBtn removeFromSuperview];
            }];
        } else {
            isScrollingFast = NO;
            [self showBtn];
        }
        
        lastOffset = currentOffset;
        lastOffsetCapture = currentTime;
        
        if(currentOffset.y>=754){
            isShow = YES;
        }else{
            isShow = NO;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //NSLog(@"scrollViewDidEndDecelerating");
    CGPoint currentOffset = scrollView.contentOffset;
    if(currentOffset.y>=754){
        isShow = YES;
    }else{
        isShow = NO;
    }
    [self showBtn];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //NSLog(@"scrollViewDidEndDragging");
    CGPoint currentOffset = scrollView.contentOffset;
    if(currentOffset.y>=754){
        isShow = YES;
    }else{
        isShow = NO;
    }
    [self showBtn];
}

-(void)showBtn{
    [UIView animateWithDuration:0.5 animations:^{
        self.button.alpha = 1;
        [self.view addSubview:self.button];
        if(isShow){
            self.backTopBtn.alpha = 0.5;
            [self.view addSubview:self.backTopBtn];
        }else{
            self.backTopBtn.alpha = 0;
            [self.backTopBtn removeFromSuperview];
        }
    }];
}

-(void)gotoTop{
    [self.tableView setContentOffset:CGPointMake(0, 114) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        isShow = NO;
        [self showBtn];
    });
}

-(void)gotofiltrate{
    NSLog(@"筛选");
    [[SliderViewController sharedSliderController] rightItemClick];
}

-(void)gotoList{
    NSLog(@"列表");
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate popView];
}

-(void)addPhoto{
    NSLog(@"拍照");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"手机相册", nil];
    [actionSheet showInView:self.tableView.superview];
}

-(void)gotoLeftView{
    [[SliderViewController sharedSliderController] leftItemClick];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
    }
    //呼出的菜单按钮点击后的响应
    switch (buttonIndex)
    {
        case 0:  //打开照相机拍照
            [self takePhoto];
            break;
        case 1:  //打开本地相册
            [self LocalPhoto];
            break;
    }
}

//开始拍照
-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

//打开本地相册
-(void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self.view.window.rootViewController presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
    
    NSString* imageStr = [[NSString alloc] initWithData:[GTMBase64 encodeData:imageData] encoding:NSUTF8StringEncoding];
    [self gotoAddImage:imageStr image:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)gotoAddImage:(NSString *)imageStr image:(UIImage *)image{
    ReleaseViewController *releaseView = [[ReleaseViewController alloc] init];
    releaseView.image = image;
    releaseView.imageStr = imageStr;
    releaseView.delegate = self;
    [self.navigationController pushViewController:releaseView animated:YES];
}

-(void)releaseSucess{
    [self reloadList];
}

-(void)reloadList{
    [[AppDelegate instance]._locService startUserLocationService];
    if (![ConnectionAvailable isConnectionAvailable]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.removeFromSuperViewOnHide =YES;
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"当前网络不可用，请检查网络连接！";
        hud.labelFont = [UIFont fontWithName:nil size:14];
        hud.minSize = CGSizeMake(132.f, 108.0f);
        [hud hide:YES afterDelay:3];
    }else{
        startIndex = 0;
        [MuchApi GetListWithBlock:^(NSMutableArray *posts, NSError *error) {
            if(!error){
                //NSLog(@"posts ==> %@",posts);
                showArr = posts;
                [self.tableView reloadData];
                [self.tableView headerEndRefreshing];
                [self.tableView footerEndRefreshing];
                [self.tableView setContentOffset:CGPointMake(0, 114) animated:NO];
            }
        }start:startIndex indexSize:7 log:[NSString stringWithFormat:@"%f",[AppDelegate instance].coor.longitude] lat:[NSString stringWithFormat:@"%f",[AppDelegate instance].coor.latitude] range:range from:from];
    }
}

-(void)filtrateData:(NSNotification *)notification{
    NSLog(@"%@",notification.userInfo);
    range = notification.userInfo[@"range"];
    from = notification.userInfo[@"from"];
    [self reloadList];
}
@end
