//
//  NTViewController.m
//  UITableViewFiddle
//
//  Created by Tom Elliott on 13/12/2013.
//
//

#import "NTViewController.h"

#import "NTURLConnection.h"

NSString *const kCellReuseIdentifierOne = @"NT_CELL_TYPE_ONE";

@interface NTViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation NTViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit
{
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _tableView = [[UITableView alloc] init];
  _tableView.translatesAutoresizingMaskIntoConstraints = NO;
  _tableView.dataSource = self;
  _tableView.delegate = self;
  [self.view addSubview:_tableView];
  
  id topGuide = [self topLayoutGuide];
  NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_tableView, topGuide);

  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary]];
  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide][_tableView]|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:viewsDictionary]];
  
  [_tableView setAllowsSelection:YES];
  [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)setSubtitle:(NSString*)subtitle forCellAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [_tableView cellForRowAtIndexPath:indexPath];
  if (cell) {
    cell.detailTextLabel.text = subtitle;
  }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return (section+1) * 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellReuseIdentifierOne];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellReuseIdentifierOne];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  
  NSInteger section = [indexPath section];
  NSInteger row = [indexPath row];
  
  NSString *imageName = (row % 2 == 0) ? @"bird" : @"frog";
  cell.textLabel.text = [NSString stringWithFormat:@"Section %d, row %d", section, row];

  NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpeg"];
  UIImage *theImage = [UIImage imageWithContentsOfFile:path];
  cell.imageView.image = theImage;
  return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 5;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  return [NSString stringWithFormat:@"Header for section %d", section];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
  return [NSString stringWithFormat:@"Footer for section %d", section];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
  UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
  if (newCell.accessoryType == UITableViewCellAccessoryNone) {
    newCell.accessoryType = UITableViewCellAccessoryCheckmark;
    newCell.detailTextLabel.text = @"Loading...";

    int comicId = 100 * [indexPath section] + [indexPath row];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://iheartxkcd.com/search?q=%d", comicId]]];
    NTURLConnection *conn = [[NTURLConnection alloc] initWithRequest:urlRequest delegate:self startImmediately:NO];
    __weak NTURLConnection *weak_conn = conn;
    conn.onComplete = ^{
      NTURLConnection *block_conn = weak_conn;
      NSError *error;
      NSData *data = ((NTURLConnection *)block_conn).data;
      NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];

      if (error != nil) {
        [self setSubtitle:@"Error!" forCellAtIndexPath:indexPath];
      }
      else {
        NSString *subtitle = [jsonArray valueForKey:@"safe_title"][0];
        if (!subtitle) {
          subtitle = @"Unknown Title";
        }
        [self setSubtitle:subtitle forCellAtIndexPath:indexPath];
      }      
    };
    conn.onError = ^(NSError *error){
      [self setSubtitle:[NSString stringWithFormat:@"Error. %@", [error localizedDescription]] forCellAtIndexPath:indexPath];
    };
    [conn start];
    
  } else if (newCell.accessoryType == UITableViewCellAccessoryCheckmark) {
    newCell.accessoryType = UITableViewCellAccessoryNone;
    newCell.detailTextLabel.text = @"";
  }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//  if (indexPath.row % 2 == 0) {
//    UIColor *altColor = [UIColor colorWithWhite:0.8 alpha:0.1];
//    cell.backgroundColor = altColor;
//  } else {
//    cell.backgroundColor = [UIColor whiteColor];
//  }
//}

#pragma mark NSURLConnection Delegate Methods

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
  return nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
  ((NTURLConnection *)connection).data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
  [((NTURLConnection *)connection).data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
  ((NTURLConnection *)connection).onComplete();
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
  ((NTURLConnection *)connection).onError(error);
}

@end
