//
//  AuthenViewController.m
//  minglongyongche
//
//  Created by jiamanu on 2018/4/18.
//  Copyright © 2018年 minglongkeji. All rights reserved.
//

#import "AuthenViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "UIViewController+Blur.h"
#import "UIViewController+ImagePicker.h"

#import "AuthenConfirmView.h"

#import "AuthenItem.h"
#import "AuthenPhotoItem.h"
#import "AuthenChooseItem.h"
#import "SeperateItem.h"
#import "BaseItem.h"

#import "UIViewController+DismissKeyboard.h"

#import "AuthenModel.h"

@interface AuthenViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UITableView *authenTableView;
@property (nonatomic,strong) AuthenConfirmView *authenConfirmView;
@property (nonatomic,strong) RETableViewManager *manager;

@property (nonatomic,strong) NSMutableDictionary *authenDic;
@property (nonatomic,copy) NSString *picType;  //显示是正面还是反面

@property (nonatomic,strong) NSData *frontData;
@property (nonatomic,strong) NSData *sideData;

@end

@implementation AuthenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    
    self.navigationItem.leftBarButtonItem = self.leftBarItem;
    
    [self.view addSubview:self.authenTableView];
    [self.view addSubview:self.authenConfirmView];
    
    [self.view setNeedsUpdateConstraints];
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.authenTableView];
    
    self.manager[@"AuthenItem"] = @"AuthenCell";
    self.manager[@"AuthenPhotoItem"] = @"AuthenPhotoCell";
    self.manager[@"AuthenChooseItem"] = @"AuthenChooseCell";
    self.manager[@"SeperateItem"] = @"SeperateCell";
    self.manager[@"BaseItem"] = @"AuthenRemindCell";
    
    [self setupAuthenTableView];
    
    [self setupForDismissKeyboard];
}

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        [self.authenTableView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.authenTableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.authenConfirmView];
        
        [self.authenConfirmView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeTop];
        [self.authenConfirmView autoSetDimension:ALDimensionHeight toSize:60];
    }
    [super updateViewConstraints];
}

- (UITableView *)authenTableView {
    if (!_authenTableView) {
        _authenTableView = [UITableView newAutoLayoutView];
        _authenTableView.tableFooterView = [UIView newAutoLayoutView];
        _authenTableView.backgroundColor = MLBackGroundColor;
    }
    return _authenTableView;
}

- (AuthenConfirmView *)authenConfirmView {
    if (!_authenConfirmView) {
        _authenConfirmView = [AuthenConfirmView newAutoLayoutView];
        
        MLWeakSelf;
        [_authenConfirmView.commitButton addAction:^(UIButton *btn) {
            [weakself toAuthentyMessage];
        }];
    }
    return _authenConfirmView;
}

- (void) setupAuthenTableView {
    RETableViewSection *section = [RETableViewSection section];
    section.headerHeight = 0;
    section.footerHeight = 0;
    [self.manager addSection:section];
    
    MLWeakSelf;
    for (NSInteger i=0; i<2; i++) {
        NSArray *dsisidi = @[@"姓  名：",@"身份证："];
        NSArray *pla = @[@"请输入真实姓名",@"请填写你的身份证号"];
        AuthenItem *item0 = [[AuthenItem alloc] initWithLeftName:dsisidi[i] placeholder:pla[i]];
        item0.selectionStyle = UITableViewCellSelectionStyleNone;
        [section addItem:item0];
        
        //参数
        NSArray *paArr = @[@"realname",@"idcard"];
        item0.didEndEditingText = ^(NSString *text) {
        [weakself.authenDic setValue:text forKey:paArr[i]];
        };
    }
    
    SeperateItem *item22 = [[SeperateItem alloc] init];
    item22.selectionStyle = UITableViewCellSelectionStyleNone;
    item22.cellHeight = smallSpacing;
    [section addItem:item22];
    
    AuthenChooseItem *item3 = [[AuthenChooseItem alloc] init];
    item3.dateString = @"请选择身份证有效期开始时间";
    item3.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(item3);
    item3.didSelectedBtn = ^(NSInteger tag) {
        [weakself showDatePickerViewInView:weakself.view finishBlock:^(NSString *dateStr, NSDate *date) {
            @strongify(item3);
            item3.dateString = [dateStr substringWithRange:NSMakeRange(0, 10)];
            [self.authenDic setValue:item3.dateString forKey:@"startime"];
        }];
    };
    [section addItem:item3];
    
    SeperateItem *item33 = [[SeperateItem alloc] init];
    item33.selectionStyle = UITableViewCellSelectionStyleNone;
    item33.cellHeight = smallSpacing;
    [section addItem:item33];
    
    AuthenChooseItem *item4 = [[AuthenChooseItem alloc] init];
    item4.dateString = @"请选择身份证有效期结束时间";
    item4.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(item4);
    item4.didSelectedBtn = ^(NSInteger tag) {
        [weakself showDatePickerViewInView:weakself.view finishBlock:^(NSString *dateStr, NSDate *date) {
            @strongify(item4);
            item4.dateString = [dateStr substringWithRange:NSMakeRange(0, 10)];
            [self.authenDic setValue:item4.dateString forKey:@"endtime"];

        }];
    };
    [section addItem:item4];
    
    SeperateItem *item44 = [[SeperateItem alloc] init];
    item44.selectionStyle = UITableViewCellSelectionStyleNone;
    item44.cellHeight = smallSpacing;
    [section addItem:item44];
    
    
    //正反照片
    AuthenPhotoItem *item5 = [[AuthenPhotoItem alloc] init];
    item5.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(item5);
    item5.didSelectedBtn = ^(NSInteger tag) {
        @strongify(item5);
        weakself.picType = [NSString stringWithFormat:@"%ld",tag-455];
        
        [weakself showAlertOfImageChoiceWith:^(UIImage *img) {
            [weakself uploadImageWithImage:img withSide:weakself.picType];
            if (tag == 456) {//正面
                item5.frontImage = img;
            }else{//反面
                item5.sideImage = img;
            }
        }];
        
    };
    [section addItem:item5];
    
    
    BaseItem *item7 = [[BaseItem alloc] init];
    item7.selectionStyle = UITableViewCellSelectionStyleNone;
    [section addItem:item7];
}

- (NSMutableDictionary *)authenDic {
    if (!_authenDic) {
        _authenDic = [NSMutableDictionary dictionary];
    }
    return _authenDic;
}

#pragma mark - 认证
- (void) toAuthentyMessage {
    NSString *authentyStr = [NSString stringWithFormat:@"%@%@%@",MLBaseUrl,MLAuthenty,TOKEN];

    if (!self.authenDic[@"front"]) {
            [self.authenDic setValue:@"" forKey:@"front"];
    }
    
    if (!self.authenDic[@"side"]) {
        [self.authenDic setValue:@"" forKey:@"side"];
    }
    
    MLWeakSelf;
    [self requestDataPostWithString:authentyStr params:self.authenDic successBlock:^(id responseObject) {
        BaseModel *momo = [BaseModel mj_objectWithKeyValues:responseObject];
        [weakself showHint:momo.info];

        if ([momo.status isEqualToString:@"200"]) {
            [[NSUserDefaults standardUserDefaults] setValue:momo.status forKey:@"authen"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    } andFailBlock:^(NSError *error) {

    }];
}



#pragma mark - take photos
//- (void) showAlertOfImageChoice {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择照片来源" message:nil preferredStyle:0];
//    
//    MLWeakSelf;
//    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"照相机" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//            UIImagePickerController *imageController = [[UIImagePickerController alloc]init];
//            imageController.delegate = weakself;
//            imageController.allowsEditing = YES;
//            imageController.sourceType = UIImagePickerControllerSourceTypeCamera;
//            [self presentViewController:imageController animated:YES completion:nil];
//        }else{
//            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"相机" message:@"相机不可用" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//            [alertView show];
//            
//            return;
//        }
//    }];
//    [alertController addAction:action0];
//    
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从相册选择" style:0 handler:^(UIAlertAction * _Nonnull action) {
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        picker.delegate = weakself;
//        //设置选择后的图片可被编辑
//        picker.allowsEditing = YES;
//        [weakself presentViewController:picker animated:YES completion:nil];
//    }];
//    [alertController addAction:action1];
//    
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
//    [alertController addAction:action2];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
//}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//
//    NSLog( @" info is   %@",info);
//    [picker dismissViewControllerAnimated:YES completion:^{
//
//    }];
//    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
//    NSString *filePath = [self getFilePathToSaveUnUpdatedImage];
//    [UIImageJPEGRepresentation(image, 0.7) writeToFile:filePath atomically:YES];
//
//
////    NSData *imgData = [NSData dataWithContentsOfFile:filePath];
////    NSString *imgStr = [NSString stringWithFormat:@"%@",imgData];
//
////    [self.authenDic setValue:imgStr forKey:self.picType];
//
//    if ([self.picType integerValue] == 1)   {//正面
//
//    }else {//反面
//    }
//
//    [self uploadImageWithImage:image withSide:self.picType];
//}
//
//- (NSString *)getFilePathToSaveUnUpdatedImage {
//    NSString *filePath = [[self getImagesFilePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"Image_%@.jpg", [NSString stringWithFormat:@"%.0f",[[NSDate new] timeIntervalSince1970] * 1000]]];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
//        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//    }
//    return filePath;
//}
//
//- (NSString *)getImagesFilePath {
//    NSString *path = [NSString stringWithFormat:@"%@/images",NSTemporaryDirectory()];
//    BOOL dictionary;
//    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&dictionary]) {
//        //如果该目录不存在 则创建该目录
//        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    return path;
//}


- (void) uploadImageWithImage:(UIImage *)image withSide:(NSString *)side  {
    
//    [self showHudInView:self.view hint:@"正在上传图片"];
    [self showSuitHint:@"正在上传"];

    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //设置超时时间
    [session.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    session.requestSerializer.timeoutInterval = 5.f;
    [session.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                              @"text/html",
                                                              @"image/jpeg",
                                                              @"image/png",
                                                              @"application/octet-stream",
                                                              @"text/json",
                                                              nil];
    
    NSString *opop = [NSString stringWithFormat:@"%@%@%@/%@",MLBaseUrl,MLUploadImage,TOKEN,side];
    
    MLWeakSelf;
    [session POST:opop parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *imageData =UIImageJPEGRepresentation(image,1);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat =@"yyyy-MM-dd H:mm:ss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:imageData
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakself hideHud];

        AuthenModel *model = [AuthenModel mj_objectWithKeyValues:responseObject];
        [weakself showHint:model.info];
        
        if ([model.status isEqualToString:@"200"]) {
            if ([weakself.picType integerValue] == 1) {
                [weakself.authenDic setValue:model.src forKey:@"front"];
            }else if ([weakself.picType integerValue] == 2){
                [weakself.authenDic setValue:model.src forKey:@"side"];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakself showHint:@"上传失败"];
        [weakself hideHud];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
