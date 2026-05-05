# WLAN Ch.04 ‧ 802.11 省電機制 ‧ 我獨自升級副本

互動式複習網站，使用「我獨自升級」風格 UI，涵蓋 4 個主副本與 1 個特訓區（5 種題型）。

## 部署到 GitHub Pages 步驟

### Step 1 ‧ 下載圖片（一次就好）

雙擊本資料夾下的 **`download-images.bat`**。

執行完應在 `images/` 看到 12 張 .jpg 檔（`fig-3-2.jpg`、`fig-3-12.jpg`、`fig-3-18.jpg`、`fig-4-1.jpg` ~ `fig-4-10.jpg` 中相對應的數張）。

> 為何要這步？  
> HTML 中的圖原本是吃 MinerU 的暫存 CDN，會過期。下載到本地後就永遠不會壞。

### Step 2 ‧ 建 GitHub Repo

到 [github.com](https://github.com) 登入 → 右上 `+` → `New repository`：

- Repository name：`wlan-ch04`（或你喜歡的名字）
- Public（私人 repo 沒辦法用免費版 Pages）
- 勾選 `Add a README file`
- Create

### Step 3 ‧ 上傳檔案

進入剛建好的 repo → `Add file` → `Upload files` → 把整個 `github-page` 資料夾**裡的內容**（不含資料夾本身）拖進去：

```
index.html
images/
  ├── fig-3-2.jpg
  ├── fig-3-12.jpg
  └── … 共 12 張
```

> ⚠ 不要上傳 `download-images.bat` 也沒關係，它對網站本身沒有影響。

填 commit 訊息（例：`init site`）→ `Commit changes`。

### Step 4 ‧ 啟用 Pages

repo 頁面 → `Settings`（右上角，不是 profile 的 Settings）→ 左側 `Pages`：

- Source：`Deploy from a branch`
- Branch：`main` ‧ Folder：`/ (root)`
- `Save`

等 1～2 分鐘後重新整理該頁，最上方會出現綠色提示：

```
✦ Your site is live at https://你的帳號.github.io/wlan-ch04/
```

點進去就能看到副本了。

## 之後要改內容怎麼辦？

最簡單：到 repo 直接編 `index.html`（GitHub 網頁就有編輯器），存檔後 1 分鐘內 Pages 自動重新部署。

---

**檔案結構**

```
github-page/
├── index.html              主網頁（已改成相對路徑）
├── images/                 圖片資料夾（執行 .bat 後產生）
├── download-images.bat     一鍵下載圖片
├── .gitignore              （可選）
└── README.md               本檔
```
