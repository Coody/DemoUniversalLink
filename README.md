# DemoUniversalLink

測試、並記錄 universal link 用法

# 參考資料來源

- [yohunl.com(主要)](https://yohunl.com/ios-universal-links-tong-yong-lian-jie/)
- [Michael Barshinger(主要)](https://medium.com/@barsh/my-first-date-with-ios-universal-links-90dfabc88bb8#.qu6q9qwd0)
- [raywenderlich(參考)](https://www.raywenderlich.com/84174/ios-8-handoff-tutorial)

# Web 端 
- 在 root 建立 .well-known 資料夾，請使用檔案名稱 .well-known__.__   （ <---請注意最後的__.__ ）
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
- paths 的 * 的意思是可以串在你 link root 網址的後面格式，假設你的 link 為 ```www.abc.com``` ，那麼 * 指 ```www.abc.com/(如果有安裝此app_那麼任意加都可連結到你的app)```，但是如果沒有安裝此 app ，則會直接連接到該網址。


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

- 
