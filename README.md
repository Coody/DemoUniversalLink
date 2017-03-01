# DemoUniversalLink

測試、並記錄 universal link 用法

# 參考資料來源

- [yohunl.com(主要)](https://yohunl.com/ios-universal-links-tong-yong-lian-jie/)
- [Michael Barshinger(主要)](https://medium.com/@barsh/my-first-date-with-ios-universal-links-90dfabc88bb8#.qu6q9qwd0)
- [raywenderlich(參考)](https://www.raywenderlich.com/84174/ios-8-handoff-tutorial)

# Web 端 
- 在 root 建立 .well-known 資料夾，請使用檔案名稱 .well-known.   （ <---請注意最後的 __.__ ）
- 建立 apple-known/apple-app-site-association 檔案（此為 json 檔案，但__請不要__加上附檔名 .json ）
- 必須支援 https
- Json 格式內容

    ```
    {
        "applinks": {
            "apps": [],
            "details": [
                {
                    "appID": "TeamID1.App bundle id",
                    "paths": [ "*"]
                },
                {
                    "appID": "TeamID2.App bundle id",
                    "paths": [ "*" ]
                } 
            ]
            }
    }
    ```
- appID 的 value 請上[Apple WWDC](https://developer.apple.com/account/)上面看，格式前面為 TeamID ，接後面為 App Bundle ID
- paths 的 * 的意思是可以串在你 link root 網址的後面格式，假設你的 link 為 ```www.abc.com``` ，那麼 * 是指 ```www.abc.com/123abc(任意加都可連結到你的app)```，這是如果你有安裝此 app 的話；如果沒有安裝此 app ，則會直接連接到 ```www.abc.com/123abc``` 該網址。


# Server 端
- 在 server 端的 root 資料夾下，應該有 web.config ，在 web.config 中，加入：

    ```
    <configuration>
        <system.webserver>
            <staticContent>
                <mimeMap fileEventsion="." mimeType="application/json" />
            </staticContent>
        </system.webserver>
    </configuration>
    ```
    PS: 看出來了嗎？之前說的資料夾建立請用 .well-known. ，資料夾的名稱看起來是 .well-known ，所以 mimeMap 要把 ```.``` 這個加入開啟格式為 json 即可！


# Client 端

- 到專案面板，選擇 App -> Tergat -> Capabilities -> Associated Domains 開成 on (會產生 (Target名稱).entitlements 檔案，請自行拉到適當的資料夾)
- 在 Capabilities 那裡要點擊 + 加入想要支持 universal link 的 domain（域名）
    - 如： applinks:www.ooxx.com
- 去[Apple WWDC](https://developer.apple.com/account/)看自己 App 的 Associated Domains 是否為綠燈，如果沒有，請編輯該 App 讓他變成綠燈，且要重新產生所有的 Provision Profile ！（更改並不會影響已經上線的 App ，請放心修改）
- 請下載此專案、或是直接在記事本貼上網址，來測試看看是否能成功喚醒 App（記得去修改該 App 的 scheme 讓他 build and run 之後等待喚醒）
- 測試成功後，請在 AppDelegate 中實現方法：
    
    ```
    static NSString *const kUniversalLinkHostURL = @"www.ooxx.com.tw";
    
    -(BOOL)application:(UIApplication *)application 
    continueUserActivity:(NSUserActivity *)userActivity 
    restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
    {
        if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
            NSURL *webpageURL = userActivity.webpageURL;
            NSString *host = webpageURL.host;
            if ([host isEqualToString:kUniversalLinkHostURL]) {
                
                // 由 universal link 進入
                
            }
            else {
                
                [[UIApplication sharedApplication]openURL:webpageURL];
                
            }
            
        }
        return YES;
    }

    ```
    
# 補充
- universal link 無法傳遞 data ，如果要傳遞資料可以加在 universal link 的網址後方，如： https://www.ooxx.com.tw/test?foo=bar
- 傳遞資料看起來還是要用 Custom URL Scheme，詳細請看 [Share data between two or more iPhone applications](http://stackoverflow.com/questions/9425706/share-data-between-two-or-more-iphone-applications)
- 參考 [Is there any way to add userInfo for iOS's universal links?](http://stackoverflow.com/questions/37388095/is-there-any-way-to-add-userinfo-for-ioss-universal-links)
- 第三方跨平台解決方案 [branch.io](https://branch.io)
