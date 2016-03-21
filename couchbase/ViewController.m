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
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *subtitle;
@property (strong, nonatomic) NSString *strid;
@property (strong, nonatomic) CBLDatabase *datebase;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(couchdemo:) name:kCBLDocumentChangeNotification object:nil];



//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    NSLog(@"%@",docDir);
    
    // Do any additional setup after loading the view, typically from a nib.
}
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
- (IBAction)adddata:(id)sender {
    [(id<couchbasePro>)[((AppDelegate *)[UIApplication sharedApplication].delegate).dict objectForKey:NSStringFromProtocol(@protocol(couchbasePro))] addAttachment:self.datebase str:self.subtitle.text documentId:self.strid callback:^(BOOL  boolresult) {

    }];
}
- (IBAction)updata:(id)sender {
//    CBLDocument *document = [self.datebase documentWithID:@"-N3dqQZa-liOrsRRYcxL2Bq"];
//    NSLog(@"%@",document.properties);
    [(id<couchbasePro>)[((AppDelegate *)[UIApplication sharedApplication].delegate).dict objectForKey:NSStringFromProtocol(@protocol(couchbasePro))] updateDocument:self.datebase documentId:self.strid];
}
- (IBAction)delete:(id)sender {
    [(id<couchbasePro>)[((AppDelegate *)[UIApplication sharedApplication].delegate).dict objectForKey:NSStringFromProtocol(@protocol(couchbasePro))] deleteDocument:self.datebase documentId:self.strid];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
