//
//  TableViewController.m
//  secondDay
//
//  Created by alex on 13.07.16.
//  Copyright © 2016 alex. All rights reserved.
//

#import "TableViewController.h"
#import "NewsTableViewCell.h"
#import  "TextTableViewCell.h"

@interface TableViewController ()
@property (nonatomic,strong) NSArray * news;
@end
@implementation TableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate =self;
    self.tableView.dataSource=self;
    self.news = @[
                  @"в  УЛГТУ  все  хорошо",
                  @"В  политехе Тарелка посыпалась  и  это  не  есть  хорошо  так как  Пинков  обидется ",
                  @"В мире  все хорошо",
                  @"в  УЛГТУ  все  хорошо",
                  @"В  политехе Тарелка повыпалась",
                  @"В мире  все хорошо",
                  @"в  УЛГТУ  все  хорошо",
                  @"В  политехе Тарелка повыпалась",
                  @"В мире  все хорошо"];
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.news.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ;
    if(indexPath.row==1){
      TextTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"TextCell" forIndexPath:indexPath];
        cell.newsText.text = self.news[indexPath.row];
        return  cell;
    }
       NewsTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
        cell.previewImageView.image =[UIImage imageNamed:@"Image"];
        cell.newsShortText.text = self.news[indexPath.row];
        return  cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==1){
        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0f]};
        NSString *news = self.news[indexPath.row];
        CGRect frame =[news boundingRectWithSize:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return frame.size.height +10.0f;
    }
    return 100.0f;
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
@end
