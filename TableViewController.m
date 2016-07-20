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
#import "TableViewCell.h"
#import "CellModel.h"
#import "BaseTableViewCell.h"

@interface TableViewController ()
@property (nonatomic,strong) NSArray<CellModel *> * news;
@end
@implementation TableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.delegate =self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"xibTextCell"];
    self.news = @[ [CellModel modelWithHeight:100.0f identifier:@"NewsCell" image:[UIImage imageNamed:@"Image"]text:@"В  УЛГТУ  все  хорошо !!" stateColor:[UIColor whiteColor]],
                   [CellModel modelWithHeight:150.0f identifier:@"xibTextCell" image:nil text:@"If you are using Auto Layout, you may be surprised that we are modifying the frame property of the layout attributes directly rather than working with constraints, but that is how UICollectionViewLayout works. Although you would use Auto Layout to define the collection view’s frame and the internal layout of each cell, the frames of the cells have to be computed the old-fashioned way.Similarly, the methods layoutAttributesForSupplementaryViewOfKind:atIndexPath: and layoutAttributesForDecorationViewOfKind:atIndexPath: should do the same for supplementary and decoration views, respectively. Implementing these two methods is only required if your layout includes such views. UICollectionViewLayoutAttributes contains two more factory methods," stateColor:[UIColor whiteColor]],
                   [CellModel modelWithHeight:100.0f identifier:@"NewsCell" image:[UIImage imageNamed:@"Image"]text:@"В  УЛГТУ  все  хорошо !!" stateColor:[UIColor whiteColor]],
                   [CellModel modelWithHeight:100.0f identifier:@"NewsCell" image:[UIImage imageNamed:@"Image"]text:@"В  УЛГТУ  все  хорошо !!" stateColor:[UIColor whiteColor]],
                   [CellModel modelWithHeight:100.0f identifier:@"NewsCell" image:[UIImage imageNamed:@"Image"]text:@"В  УЛГТУ  все  хорошо !!" stateColor:[UIColor whiteColor]],
                   [CellModel modelWithHeight:150.0f identifier:@"xibTextCell" image:nil text:@"В  УЛГТУ  все  хорошо !!" stateColor:[UIColor whiteColor]],
                   [CellModel modelWithHeight:100.0f identifier:@"NewsCell" image:[UIImage imageNamed:@"Image"]text:@"В  УЛГТУ  все  хорошо !!" stateColor:[UIColor whiteColor]],
                   [CellModel modelWithHeight:100.0f identifier:@"NewsCell" image:[UIImage imageNamed:@"Image"]text:@"В  УЛГТУ  все  хорошо !!" stateColor:[UIColor whiteColor]]
                  
                  ];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.news.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ;
    
    CellModel * model = self.news[indexPath.row];
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: model.identifier forIndexPath:indexPath];
    cell.model=model;
    
//        
//    if(indexPath.row==1){
//      TableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"xibTextCell" forIndexPath:indexPath];
//        cell.newsText.text = self.news[indexPath.row].text;
//        
//        return  cell;
//    }
//       NewsTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
//        cell.previewImageView.image =[UIImage imageNamed:@"Image"];
//        cell.newsShortText.text = self.news[indexPath.row].text;
//        return  cell;
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.row==1){
//        NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:17.0f]};
//        NSString *news = self.news[indexPath.row];
//        CGRect frame =[news boundingRectWithSize:CGSizeMake(self.view.frame.size.width, CGFLOAT_MAX)
//                                         options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
//        return frame.size.height +10.0f;
//    }
//    return 100.0f;
    CellModel * news = self.news[indexPath.row];
    return news.height;
}
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellModel * model  = self.news[indexPath.row];
                model.stateColor =[UIColor redColor];
    [tableView reloadData];
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellModel * model  = self.news[indexPath.row];
    model.stateColor =[UIColor whiteColor];
    [tableView reloadData];

}
@end
