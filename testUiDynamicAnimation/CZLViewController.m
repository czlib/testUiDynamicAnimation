//
//  CZLViewController.m
//  testUiDynamicAnimation
//
//  Created by c on 14-4-1.
//  Copyright (c) 2014年 czl. All rights reserved.
//

#import "CZLViewController.h"

@interface CZLViewController ()

@end

@implementation CZLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *aniView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    aniView.backgroundColor = [UIColor purpleColor];
    aniView.transform = CGAffineTransformRotate(aniView.transform, 45);
    [self.view addSubview:aniView];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    [aniView addGestureRecognizer:pan];
    
    UIDynamicAnimator *animation = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *behavor = [[UIGravityBehavior alloc] initWithItems:@[aniView]];
    [animation addBehavior:behavor];
    
    UICollisionBehavior *collosionBehavior = [[UICollisionBehavior alloc] initWithItems:@[aniView]];
    collosionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [animation addBehavior:collosionBehavior];
    
    self.animator = animation;
    
}

- (void)onPan:(UIPanGestureRecognizer*)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        CGPoint squraPoint = CGPointMake(pan.view.center.x, pan.view.center.y-20);
        UIAttachmentBehavior *attachBe = [[UIAttachmentBehavior alloc] initWithItem:pan.view attachedToAnchor:squraPoint];
        self.attachBehavior  = attachBe;
        [self.animator addBehavior:attachBe];
    }
    else if (pan.state == UIGestureRecognizerStateChanged)
    {
        [self.attachBehavior setAnchorPoint:[pan locationInView:self.view]];
    }
    else if (pan.state == UIGestureRecognizerStateEnded)
    {
        [self.animator removeBehavior:self.attachBehavior];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
