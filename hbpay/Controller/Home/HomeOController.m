//
//  testScrollViewViewControllerViewController.m
//  testScrollViewViewController
//
//  Created by imac  on 13-7-10.
//  Copyright (c) 2013年 imac . All rights reserved.
//

#import "HomeOController.h"
#import "UIImageView+WebCache.h"
@interface HomeOController (){
    BOOL _isTimeUp;
}



@end

@implementation HomeOController

@synthesize scrollView, slideImages;
@synthesize text;
@synthesize pageControl;
static CGFloat const chageImageTime = 3.0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //
    
    
    
    
    // 定时器 循环
    [NSTimer scheduledTimerWithTimeInterval:chageImageTime target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    _isTimeUp = NO;

    // 初始化 scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)];
    scrollView.bounces = YES;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
   
    slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"Expression_1"];
    [slideImages addObject:@"Expression_2"];
    [slideImages addObject:@"Expression_3"];
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(120,110,100,18)]; // 初始化mypagecontrol
    
    pageControl.numberOfPages = [self.slideImages count];
    pageControl.currentPage = 0;
    [pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self.view addSubview:pageControl];
    // 创建四个图片 imageview
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((320 * i) + 320, 0, 320, 130);
        imageView.contentMode =  UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        imageView.clipsToBounds  = YES;
        [scrollView addSubview:imageView]; // 首页是第0页,默认从第1页开始的。所以+320。。。
    }
    
    
    /*UIImageView * image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    
    NSString *imageUrl=@"http://115.29.178.117/water/QQ.jpg";
    
 
    
    [image sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage  imageNamed:@"placeholder.png"]];*/

    
    
    // 取数组最后一张图片 放在第0页
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:([slideImages count]-1)]]];
    imageView.frame = CGRectMake(0, 0, 320, 130); // 添加最后1页在首页 循环
    [scrollView addSubview:imageView];
    // 取数组第一张图片 放在最后1页
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake((320 * ([slideImages count] + 1)) , 0, 320, 130); // 添加第1页在最后 循环
    [scrollView addSubview:imageView];
    
    [scrollView setContentSize:CGSizeMake(320 * ([slideImages count] + 2), 130)]; //  +上第1页和第4页  原理：4-[1-2-3-4]-1
    [scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,130) animated:NO];
    NSLog(@"%f",self.scrollView.bounds.origin.y);
    
}
// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pagewidth/([slideImages count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
}
// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pagewidth = self.scrollView.frame.size.width;
    int currentPage = floor((self.scrollView.contentOffset.x - pagewidth/ ([slideImages count]+2)) / pagewidth) + 1;
  
    if (currentPage==0)
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320 * [slideImages count],0,320,130) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage==([slideImages count]+1))
    {
        [self.scrollView scrollRectToVisible:CGRectMake(320,0,320,130) animated:NO]; // 最后+1,循环第1页
    }
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    long page = pageControl.currentPage; // 获取当前的page
    [self.scrollView scrollRectToVisible:CGRectMake(320*(page+1),0,320,130) animated:NO];
    // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    long page = pageControl.currentPage; // 获取当前的page
    page++;
    page = page >= [self.slideImages count] ? 0 : page ;
    pageControl.currentPage = page;
    [self turnPage];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
