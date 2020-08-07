cookies = null

sleep = (time) -> new Promise (res) -> setTimeout res, time

getText = (element, page) -> await page.evaluate ((e) -> e.innerText), element
getDataDid = (element, page) -> await page.evaluate ((e) -> e.getAttribute 'data-did'), element
scroll = (page) -> await page.evaluate -> window.scroll 0, document.body.clientHeight

getDynamicUrl = (user, browser) ->
  page = await browser.newPage()
  await page.goto "https://space.bilibili.com/#{user}/dynamic"
  await sleep 2000
  first = (await page.$x '//*[@id="page-dynamic"]/div[1]/div/div/div[1]')[0]
  if !first then return null
  if (await getText first, page) == '置顶'
    first = (await page.$x '//*[@id="page-dynamic"]/div[1]/div/div/div[3]')[0]
    if !first then return null
  id = await getDataDid first, page
  await page.close()
  "https://t.bilibili.com/#{id}"

comment = (text, user, browser) ->
  url = await getDynamicUrl user, browser
  page = await browser.newPage()
  await page.setCookie each for each in cookies
  page.goto url
  await sleep 5000
  await scroll page
  await sleep 3000
  textarea = await page.$ 'textarea'
  submit = await page.$ '.comment-submit'
  await textarea.type text
  await submit.click()
  await sleep 3000
  await page.close()

module.exports = (tCookies) ->
  cookies = tCookies
  comment