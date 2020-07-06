//
//  HomeController.m
//  app
//
//  Created by GasparChu on 2020/5/28.
//  Copyright © 2020 GasparChu. All rights reserved.
//

#import "HomeController.h"
#import "LogHeader.h"
#import "BaseMacro.h"
#import "QuickStartCell.h"
#import "OtherMoudleCell.h"
#import "UICollectionViewCell+JLYRegister.h"
#import "Interfaces.h"
#import "FeedbackController.h"
#import "NSBundle+Language.h"
#import "Utils.h"
#import "ThunderManager.h"
#import "CrossChannelController.h"
#import "ModulesDataManager.h"

@interface HomeController ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, QuickStartCellDelegate>

@property (weak, nonatomic) IBOutlet UILabel *topDesLabel;
@property (weak, nonatomic) IBOutlet UIButton *documentBtn;
@property (weak, nonatomic) IBOutlet UIButton *feedbackBtn;
@property (weak, nonatomic) IBOutlet UIButton *languageSwitchBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;                 
@property (nonatomic, copy) NSArray *imageArr;
@property (nonatomic, copy) NSArray *titleArr;
@property (nonatomic, copy) NSArray *desArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *logoTopConstraint;


@end

@implementation HomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [ModulesDataManager sharedManager].firstCreateData = YES;
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.logoTopConstraint.constant = kStatusBarHeight + 17;
    self.languageSwitchBtn.selected = [NSBundle jly_currentLanguageIsEn];
    [QuickStartCell jly_registerCellWithCollectionView:self.collectionView];
    [OtherMoudleCell jly_registerCellWithCollectionView:self.collectionView];
    
    _imageArr = @[@"home_rvideo", @"home_raudio", @"home_rts", @"home_mpublish"];
    _titleArr = @[@"实时视频进阶功能", @"实时音频进阶功能", @"实时消息服务", @"混画推流服务"];
    _desArr = @[@"横竖屏开播与缩放、屏幕共享、次要媒体信息等更多功能",
                @"变声、伴奏、混响、录制、实时返听等更多功能",
                @"公屏消息、信令消息、聊天室管理等功能",
                @"推流、拉流、混画布局等功能"];
    [self setPlaceholderString];
}

- (void)setPlaceholderString
{
    self.topDesLabel.text = [NSBundle jly_localizedStringWithKey:@"聚联云实时音视频专家"];
    self.desLabel.text = [NSString stringWithFormat:@"Rays V%@ Build%@ 2020-06-10 TB%@ HMR0  \n%@ ", [Utils appVersion], [Utils appBuildVersion], [ThunderManager getVersion],[NSBundle jly_localizedStringWithKey:@"本APP用于展示聚联云实时音视频的各类功能"]];
    self.desLabel.numberOfLines = 0;
}

#pragma mark - Action
- (IBAction)clickDocumentBtn:(UIButton *)sender
{
    
}

- (IBAction)clickFeedbackBtn:(UIButton *)sender
{
    JLYLogInfo(@"clickFeedbackBtn");
    FeedbackController *con = [FeedbackController new];
    [self.navigationController pushViewController:con animated:YES];
}

- (IBAction)clickLanguageBtn:(UIButton *)sender
{
    if (sender.isSelected) {
        [NSBundle jly_switchLanguageToHans];
    } else {
        [NSBundle jly_switchLanguageToEn];
    }
    sender.selected = !sender.isSelected;
    [self setPlaceholderString];
    [self.collectionView reloadData];
}

#pragma mark - QuickStartCellDelegate
- (void)clickCrossChannel
{
    JLYLogClear
    CrossChannelController *con = [CrossChannelController new];
    [self.navigationController pushViewController:con animated:YES];
}

- (void)clickSameChannel
{
    [Interfaces goToSameChannel];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger itemCount = (0 == section ? 1 : 4);
    return itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        QuickStartCell *cell = [QuickStartCell jly_cellWithCollectionView:collectionView indexPath:indexPath];
        cell.delegate = self;
        [cell refreshView];
        return cell;
    } else {
        OtherMoudleCell *cell = [OtherMoudleCell jly_cellWithCollectionView:collectionView indexPath:indexPath];
        cell.imgView.image = [UIImage imageNamed:self.imageArr[indexPath.item]];
        cell.titleLabel.text = [NSBundle jly_localizedStringWithKey:self.titleArr[indexPath.item]];
        cell.desLabel.text = [NSBundle jly_localizedStringWithKey:self.desArr[indexPath.item]];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = (0 == indexPath.section ? (CGSize){kScreenWidth - 30, 160} : (CGSize){kScreenWidth - 30, 78});
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = (0 == section ? (UIEdgeInsets){0, 15, 0, 15} : (UIEdgeInsets){8, 15, 0, 15});
    return insets;
}

@end
