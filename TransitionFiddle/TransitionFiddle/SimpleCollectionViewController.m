//
//  SimpleCollectionViewController.m
//  TransitionFiddle
//
//  Created by Tom Elliott on 30/06/2015.
//  Copyright © 2015 telliott. All rights reserved.
//

#import "SimpleCollectionViewController.h"

#import "TETransitioningDelegate.h"
#import "TECityMapperTransition.h"

static NSUInteger const kNavBarHeight = 60;

@interface SimpleCollectionViewController ()

@property (nonatomic, strong, readonly) UIView *navigationBarShadowView;
@property (nonatomic, assign, readonly) NSUInteger index;
@property (nonatomic, strong, readonly) id<UIViewControllerTransitioningDelegate> transitioningDelegateForChildVCs;

@end

@implementation SimpleCollectionViewController

- (nonnull instancetype)initWithCollectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
  return [self initWithCollectionViewLayout:layout index:0];
}

- (nonnull instancetype)initWithCollectionViewLayout:(nonnull UICollectionViewLayout *)layout index:(NSUInteger)index
{
  if (self = [super initWithCollectionViewLayout:layout]) {
    _isRootViewController = YES;
    _index = index;
    _navigationTitle = [NSString stringWithFormat:@"View #%lu", (unsigned long)_index];

    TETransition *transition = [[TECityMapperTransition alloc] init];
    _transitioningDelegateForChildVCs = [[TETransitioningDelegate alloc] initWithRootViewController:self transition:transition];
  }
  return self;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
  [super viewDidLoad];
  
  _navigationBarShadowView = [[UIView alloc] init];
  [_navigationBarShadowView setBackgroundColor:[UIColor colorWithRed:0.3f green:0.3f blue:0.3f alpha:0.2f]];
  _navigationBarShadowView.frame = CGRectMake(0, kNavBarHeight, self.view.bounds.size.width, 0);
  [self.view addSubview:_navigationBarShadowView];
  
  NSUInteger color = arc4random_uniform(4);
  UIColor *backgroundColor;
  
  switch (color) {
    case 0:
      backgroundColor = [UIColor redColor];
      break;
    case 1:
      backgroundColor = [UIColor blueColor];
      break;
    case 2:
      backgroundColor = [UIColor purpleColor];
      break;
    case 3:
      backgroundColor = [UIColor greenColor];
      break;
      
    default:
      backgroundColor = [UIColor yellowColor];
      break;
  }
  self.view.backgroundColor = backgroundColor;
  self.collectionView.backgroundColor = backgroundColor;
  
  // Uncomment the following line to preserve selection between presentations
  // self.clearsSelectionOnViewWillAppear = NO;
  
  // Register cell classes
  [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
  
  // Do any additional setup after loading the view.
}

- (void)loadView
{
  [super loadView];
  
  UIView *fakeNavBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, kNavBarHeight)];
  UILabel *titleLabel = [[UILabel alloc] init];
  titleLabel.text = _navigationTitle;
  [titleLabel sizeToFit];
  [fakeNavBar addSubview:titleLabel];
  titleLabel.center = fakeNavBar.center;
  
  if (!_isRootViewController) {
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(10, 30, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"Previous"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(_backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [fakeNavBar addSubview:backButton];
  }
  
  [self.view addSubview:fakeNavBar];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
  self.collectionView.frame = CGRectMake(0, kNavBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - kNavBarHeight);
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Actions

- (void)_backButtonPressed:(id)sender
{
  [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Private instance methods

- (void)_updateSplitterForOffset:(NSInteger)offset
{
  NSInteger splitterSize = MAX(0, MIN(5, offset));
  
  CGRect newRect = _navigationBarShadowView.frame;
  newRect.size.height = splitterSize;
  _navigationBarShadowView.frame = newRect;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  cell.backgroundColor = [UIColor whiteColor];
  
  // Configure the cell
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40.0f)];
  label.text = [NSString stringWithFormat:@"This is a row with id %ld. W00piedo.", (long)indexPath.row];
  label.backgroundColor = [UIColor whiteColor];
  [label sizeToFit];
  
  for(UIView *view in cell.contentView.subviews) {
    [view removeFromSuperview];
  }
  [cell.contentView addSubview:label];
  
  return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  SimpleCollectionViewController *nextVC = [[SimpleCollectionViewController alloc] initWithCollectionViewLayout:self.collectionViewLayout index:_index+1];
  nextVC.isRootViewController = NO;
  nextVC.transitioningDelegate = _transitioningDelegateForChildVCs;

  [self.navigationController pushViewController:nextVC animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  [self _updateSplitterForOffset:scrollView.contentOffset.y];
}

#pragma mark - Others

- (NSString *)debugDescription
{
  return [NSString stringWithFormat:@"%@: %@", _navigationTitle, [super debugDescription]];
}

@end
