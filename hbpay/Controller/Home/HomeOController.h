#import <UIKit/UIKit.h>

@interface HomeOController : UIViewController<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *scrollView;
@property (strong,nonatomic)NSMutableArray *slideImages;
@property (strong,nonatomic)UIPageControl *pageControl;
@property (strong, nonatomic)UITextField *text;
@end
