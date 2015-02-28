//
//  SliderViewController.m
//  LeftRightSlider
//
//  Created by heroims on 13-11-27.
//  Copyright (c) 2013年 heroims. All rights reserved.
//

#import "SliderViewController.h"
#import "WeiboSDK.h"
static CGFloat kBlackCoverMaxAlpha = 0.6f;

typedef NS_ENUM(NSInteger, RMoveDirection) {
    RMoveDirectionLeft = 0,
    RMoveDirectionRight
};

@interface SliderViewController ()<UIGestureRecognizerDelegate>{
    UIView *_mainContentView;
    UIView *_leftSideView;
    UIView *_rightSideView;
    
    UIView *_blackCoverView;
    
    NSMutableDictionary *_controllersDict;
    
    UITapGestureRecognizer *_tapGestureRec;
    UIPanGestureRecognizer *_panGestureRec;
    UIPanGestureRecognizer *_panOnBlackCoverViewGestureRec;
}

@end

@implementation SliderViewController

#if __has_feature(objc_arc)
#else
-(void)dealloc{
    [_mainContentView release];
    [_leftSideView release];
    [_rightSideView release];
    
    [_controllersDict release];
    [_blackCoverView release];
    [_tapGestureRec release];
    [_panGestureRec release];
    
    [_leftVC release];
    [_rightVC release];
    [_MainVC release];
    [super dealloc];
}
#endif

+ (SliderViewController*)sharedSliderController
{
    static SliderViewController *sharedSVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSVC = [[self alloc] init];
    });
    
    return sharedSVC;
}

- (id)init{
    if (self = [super init]){
        _LeftSContentOffset=160;
        _RightSContentOffset=160;
        _LeftSContentScale=0.85;
        _RightSContentScale=0.85;
        _LeftSJudgeOffset=100;
        _RightSJudgeOffset=100;
        _LeftSOpenDuration=0.4;
        _RightSOpenDuration=0.4;
        _LeftSCloseDuration=0.3;
        _RightSCloseDuration=0.3;
        _canMoveWithGesture = YES;
        _canRightMoveWithGesture = YES;
        _LeftStartX=0;
        _RightStartX=0;
    }
        
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=YES;

    _controllersDict = [NSMutableDictionary dictionary];
    
    [self initSubviews];
    
    [self initChildControllers:_LeftVC rightVC:_RightVC];
    
    [self showContentControllerWithModel:@"MainViewController"];
    
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    _tapGestureRec.delegate=self;
    //[self.view addGestureRecognizer:_tapGestureRec];
    [_blackCoverView addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    
    _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_mainContentView addGestureRecognizer:_panGestureRec];
    
    _panOnBlackCoverViewGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_blackCoverView addGestureRecognizer:_panOnBlackCoverViewGestureRec];
}

-(void)ddd{
    WBAuthorizeRequest* request=[WBAuthorizeRequest request];
    request.redirectURI=kSinaRedirectURI;
    request.scope=@"all";
    [WeiboSDK sendRequest:request];
}

#pragma mark - Init

- (void)initSubviews
{
    _rightSideView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_rightSideView];

    _leftSideView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_leftSideView];
    
    _mainContentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mainContentView];
    
    _blackCoverView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_blackCoverView];
    _blackCoverView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:1.0f];
    _blackCoverView.hidden = YES;

}

- (void)initChildControllers:(UIViewController*)leftVC rightVC:(UIViewController*)rightVC
{
    [self addChildViewController:leftVC];
    leftVC.view.frame=CGRectMake(0, 0, leftVC.view.frame.size.width, leftVC.view.frame.size.height);
    [_leftSideView addSubview:leftVC.view];
    
    [self addChildViewController:rightVC];
    rightVC.view.frame=CGRectMake(0, 0, rightVC.view.frame.size.width, rightVC.view.frame.size.height);
    [_rightSideView addSubview:rightVC.view];
}

#pragma mark - Actions

- (void)showContentControllerWithModel:(NSString *)className
{
    [self closeSideBar];
    
    UIViewController *controller = _controllersDict[className];
    if (!controller)
    {
        Class c = NSClassFromString(className);
        
#if __has_feature(objc_arc)
        controller = [[c alloc] init];
#else
        controller = [[[c alloc] init] autorelease];
#endif
        [_controllersDict setObject:controller forKey:className];
    }
    
    if (_mainContentView.subviews.count > 0)
    {
        UIView *view = [_mainContentView.subviews firstObject];
        [view removeFromSuperview];
    }
    
    controller.view.frame = _mainContentView.frame;
    self.nav = [[UINavigationController alloc] initWithRootViewController:controller];
    //nav.navigationBarHidden = YES;
    //NavigationBar设置背景图
    self.nav.navigationBar.barTintColor = RGBCOLOR(255,228,19);
    [_mainContentView addSubview:self.nav.view];
    self.MainVC=self.nav;
}

- (void)leftItemClick
{
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
    
    [self.view sendSubviewToBack:_rightSideView];
    [self configureViewShadowWithDirection:RMoveDirectionRight];
    _leftSideView.frame=CGRectMake(_LeftStartX, 0, _leftSideView.frame.size.width, _leftSideView.frame.size.height);
    [UIView animateWithDuration:_LeftSOpenDuration
                     animations:^{
                         _leftSideView.frame=CGRectMake(0, 0, _leftSideView.frame.size.width, _leftSideView.frame.size.height);
                         _mainContentView.transform = conT;
                         _blackCoverView.hidden = NO;
                         _blackCoverView.alpha = kBlackCoverMaxAlpha;
                         _blackCoverView.frame = _mainContentView.frame;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                     }];
}

- (void)rightItemClick
{
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
    
    [self.view sendSubviewToBack:_leftSideView];
    [self configureViewShadowWithDirection:RMoveDirectionLeft];
    _rightSideView.frame=CGRectMake(_RightStartX, 0, _rightSideView.frame.size.width, _rightSideView.frame.size.height);
    [UIView animateWithDuration:_RightSOpenDuration
                     animations:^{
                         _rightSideView.frame=CGRectMake(0, 0, _rightSideView.frame.size.width, _rightSideView.frame.size.height);
                         _mainContentView.transform = conT;
                         _blackCoverView.hidden = NO;
                         _blackCoverView.alpha = kBlackCoverMaxAlpha;
                         _blackCoverView.frame = _mainContentView.frame;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = YES;
                     }];
}

- (void)closeSideBar
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    [UIView animateWithDuration:_mainContentView.transform.tx==_LeftSContentOffset?_LeftSCloseDuration:_RightSCloseDuration
                     animations:^{
                         _leftSideView.frame=CGRectMake(_LeftStartX, 0, _leftSideView.frame.size.width, _leftSideView.frame.size.height);
                         _rightSideView.frame=CGRectMake(_RightStartX, 0, _leftSideView.frame.size.width, _leftSideView.frame.size.height);
                         _mainContentView.transform = oriT;
                         _blackCoverView.alpha = 0.0f;
                         _blackCoverView.frame = _mainContentView.frame;
                     }
                     completion:^(BOOL finished) {
                         _tapGestureRec.enabled = NO;
                         _blackCoverView.hidden = YES;
                     }];
}

- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    if (!_canMoveWithGesture)
    {
        return;
    }else{}
    
    static CGFloat currentTranslateX;
    if (panGes.state == UIGestureRecognizerStateBegan)
    {
        currentTranslateX = _mainContentView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged)
    {
        CGFloat transX = [panGes translationInView:_mainContentView].x;
        transX = transX + currentTranslateX;
        
        CGFloat sca;
        BOOL isTransformView = NO;
        CGFloat blackCoverAlpha = 0.0f;
        if ((transX > 0) )
        {
            [self.view sendSubviewToBack:_rightSideView];
            [self configureViewShadowWithDirection:RMoveDirectionRight];
            _rightSideView.frame=CGRectMake(_RightStartX, 0, _rightSideView.frame.size.width, _rightSideView.frame.size.height);
            if (_mainContentView.frame.origin.x < _LeftSContentOffset)
            {
                sca = 1 - (_mainContentView.frame.origin.x/_LeftSContentOffset) * (1-_LeftSContentScale);
            }
            else
            {
                sca = _LeftSContentScale;
            }
            if (_LeftStartX!=0) {
                _leftSideView.frame=CGRectMake((_LeftStartX+transX)>=0?0:(_LeftStartX+transX), 0, _leftSideView.frame.size.width, _leftSideView.frame.size.height);
            }
            blackCoverAlpha = MIN((transX/_LeftSContentOffset * kBlackCoverMaxAlpha), kBlackCoverMaxAlpha);
            isTransformView = YES;
        }
        else if ((transX < 0))
        {
            if(!_canRightMoveWithGesture){
                return;
            }else{}
            [self.view sendSubviewToBack:_leftSideView];
            [self configureViewShadowWithDirection:RMoveDirectionLeft];
            _leftSideView.frame=CGRectMake(_LeftStartX, 0, _leftSideView.frame.size.width, _leftSideView.frame.size.height);
            if (_mainContentView.frame.origin.x > -_RightSContentOffset)
            {
                sca = 1 - (-_mainContentView.frame.origin.x/_RightSContentOffset) * (1-_RightSContentScale);
            }
            else
            {
                sca = _RightSContentScale;
            }
            if (_RightStartX!=0) {
                _rightSideView.frame=CGRectMake((_RightStartX+transX)>=0?0:(_RightStartX+transX), 0, _rightSideView.frame.size.width, _rightSideView.frame.size.height);
            }
            CGAffineTransform transS = CGAffineTransformMakeScale(sca, sca);
            CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
            
            CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
            _mainContentView.transform = conT;
            blackCoverAlpha = MIN((-transX/_RightSContentOffset * kBlackCoverMaxAlpha), kBlackCoverMaxAlpha);
            isTransformView = YES;
        }
        else
        {
            sca = 0.0f;
            isTransformView = NO;
        }
        
        if (isTransformView)
        {
            CGAffineTransform transS = CGAffineTransformMakeScale(1.0, sca);
            CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
            
            CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
            
            _mainContentView.transform = conT;
            
            _blackCoverView.hidden = NO;
            _blackCoverView.alpha = blackCoverAlpha;
            _blackCoverView.frame = _mainContentView.frame;
        }else{}
    }
    else if (panGes.state == UIGestureRecognizerStateEnded)
    {
        CGFloat panX = [panGes translationInView:_mainContentView].x;
        CGFloat finalX = currentTranslateX + panX;
        if ((finalX > _LeftSJudgeOffset) )
        {
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            
            _blackCoverView.alpha = kBlackCoverMaxAlpha;
            _blackCoverView.frame = _mainContentView.frame;
            
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = YES;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadMyData" object:nil];
            return;
        }
        if ((finalX < -_RightSJudgeOffset) )
        {
            if(!_canRightMoveWithGesture){
                return;
            }else{}
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            
            _blackCoverView.alpha = kBlackCoverMaxAlpha;
            _blackCoverView.frame = _mainContentView.frame;
            
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = YES;
            return;
        }
        else
        {
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = oriT;
            
            [UIView commitAnimations];
            
            _tapGestureRec.enabled = NO;
            _blackCoverView.hidden = YES;
        }
    }
}

#pragma mark -

- (CGAffineTransform)transformWithDirection:(RMoveDirection)direction
{
    CGFloat translateX = 0;
    CGFloat transcale = 0;
    switch (direction) {
        case RMoveDirectionLeft:
            translateX = -_RightSContentOffset;
            transcale = _RightSContentScale;
            break;
        case RMoveDirectionRight:
            translateX = _LeftSContentOffset;
            transcale = _LeftSContentScale;
            break;
        default:
            break;
    }
    
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(1.0, transcale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

- (void)configureViewShadowWithDirection:(RMoveDirection)direction
{
    CGFloat shadowW;
    switch (direction)
    {
        case RMoveDirectionLeft:
            shadowW = 2.0f;
            break;
        case RMoveDirectionRight:
            shadowW = -2.0f;
            break;
        default:
            break;
    }
    
    _mainContentView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    _mainContentView.layer.shadowColor = [UIColor blackColor].CGColor;
    _mainContentView.layer.shadowOpacity = 0.8f;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

@end
