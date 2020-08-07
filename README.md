# pili-comment  

通过puppeteer模拟发送bilibili评论  
自动往第一条动态发送评论  

使用方法：  
1. `yarn add pili-comment #或 npm i pili-comment`  
2. `comment = require('pili-comment')(cookies)`  
3. `comment('wwww', uid, browser)`  

> 注：我习惯使用coffeescript，以下为coffeescript的示范  

```coffeescript
cookies = [{ # 在SESSDATA和bili_jct填入自己的cookie
  name: 'SESSDATA'
  value: 'SESSDATA'
  domain: '.bilibili.com'
}, {
  name: 'bili_jct'
  value: 'bili_jct'
  domain: '.bilibili.com'
}, {
  name: 'dy_spec_agreed'
  value: '1'
  domain: '.bilibili.com'
}]

puppeteer = require 'puppeteer'
comment = (require 'pili-comment') cookies

browserOptions =
  args: [
    '--no-sandbox'
    '--disable-setuid-sandbox'
    '--user-agent=="Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101 Firefox/68.0"'
  ]
  headless: true
  ignoreHTTPSErrors: true

do ->
  try
    browser = await puppeteer.launch browserOptions
    await comment 'www', 233333, browser # 233333这里填uid
    await browser.close()
  catch e
    console.log e
```