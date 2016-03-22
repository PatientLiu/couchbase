//
//  ViewController.m
//  couchbase
//
//  Created by 刘璞峰 on 16/3/21.
//  Copyright © 2016年 patient. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "couchbasePro.h"
#import <CouchbaseLite/CouchbaseLite.h>
#import "ReactiveCocoa.h"
#import "couchDemo.h"
#import "RCTRootView.h"

@interface ViewController ()
{
    NSURL *remoteSyncurl;
    CBLReplication *_pull;
    
    CBLReplication *_push;
    NSError *_syncError;
}
@property (strong, nonatomic) IBOutlet UITextField *subtitle;
@property (strong, nonatomic) NSString *strid;
@property (strong, nonatomic) CBLDatabase *datebase;
@end

@implementation ViewController
RCT_EXPORT_MODULE(CouchBase);

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(couchdemo:) name:kCBLDocumentChangeNotification object:nil];
    
//    [self initRNView];

    //dsad
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    NSLog(@"%@",docDir);
    
    // Do any additional setup after loading the view, typically from a nib.
}
//-(void)initRNView {
//    NSURL *jsCodeLocation;
//    jsCodeLocation = [NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
//    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
//                                                        moduleName:@"EmbedRNMeituan"
//                                                 initialProperties:nil
//                                                     launchOptions:nil];
//    //注意，这里是 @"EmbedRNMeituan"
//    rootView.frame = CGRectMake(0, 64, 300, 300);
//    [self.view addSubview:rootView];
//}
-(void)couchdemo:(NSNotification *)sender
{
    NSLog(@"xxxxxxxxxx %@",((CBLDocument *)sender.object).properties);
}

- (IBAction)add:(id)sender {
    [(id<couchbasePro>)[((AppDelegate *)[UIApplication sharedApplication].delegate).dict objectForKey:NSStringFromProtocol(@protocol(couchbasePro))] CreateDoga:self.subtitle.text callbackyes:^(NSString *str,CBLDatabase *datebase) {
        self.strid = str;
        self.datebase = datebase;
//        CBLDocument *document = [self.datebase documentWithID:self.strid];
//        NSLog(@"%@",document.properties);
//        [RACObserve(document, properties) subscribeNext:^(id x) {
//            NSLog(@"数据已改变或删除  :  %@",x);
//        }];
    }];
}
- (IBAction)search:(id)sender {
    [(id<couchbasePro>)[((AppDelegate *)[UIApplication sharedApplication].delegate).dict objectForKey:NSStringFromProtocol(@protocol(couchbasePro))] query:self.datebase documentId:self.strid];
}


- (IBAction)adddata:(id)sender {
    [(id<couchbasePro>)[((AppDelegate *)[UIApplication sharedApplication].delegate).dict objectForKey:NSStringFromProtocol(@protocol(couchbasePro))] addAttachment:self.datebase str:self.subtitle.text documentId:self.strid callback:^(BOOL  boolresult) {

    }];
}
- (IBAction)updata:(id)sender {
    [(id<couchbasePro>)[((AppDelegate *)[UIApplication sharedApplication].delegate).dict objectForKey:NSStringFromProtocol(@protocol(couchbasePro))] updateDocument:self.datebase documentId:self.strid];
}
- (IBAction)delete:(id)sender {
    [(id<couchbasePro>)[((AppDelegate *)[UIApplication sharedApplication].delegate).dict objectForKey:NSStringFromProtocol(@protocol(couchbasePro))] deleteDocument:self.datebase documentId:self.strid];
}

RCT_EXPORT_METHOD(addCreate)
{
    [self add:nil];
    
}
RCT_EXPORT_METHOD(adddatas:(NSString *)dataid)
{
    NSLog(@"Launching Couchbase Lite...");
    CBLManager* dbmgr = [CBLManager sharedInstance];
    //    CBLRegisterJSViewCompiler();
    
//    CBLListener* listener = [[CBLListener alloc] initWithManager:dbmgr port:port];
//    [listener setPasswords:@{username: password}];
    
    [self add:nil];
    [[NSNotificationCenter defaultCenter] addObserverForName:kCBLDatabaseChangeNotification object:@"push" queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        //数据改动synchronization
        
    }];
}
RCT_EXPORT_METHOD(updata)
{
    [self updata:nil];
}
RCT_EXPORT_METHOD(search)
{
    [self search:nil];
}

-(void)replictionpro:(NSNotificationCenter *)sender{
    unsigned completed = _pull.completedChangesCount + _push.completedChangesCount;
    unsigned total = _pull.changesCount + _push.changesCount;
    [self showSyncStatus:(completed / (float)MAX(total, 1u))];
}
-(void)showSyncStatus:(float)doubles
{
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
