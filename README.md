## **Guide to Build and Run App**

This guide provides step-by-step instructions on running and debugging your Roku app using two methods:

1. [Using BrightScript Extension in VS Code](#1-running-through-brightscript-extension-vs-code)
2. [Sideloading a Packaged ZIP File](#2-sideloading-a-roku-app-using-a-zip-file)

---

## **Prerequisites**
Ensure the following before proceeding:

- Download or Clone this repo
- Roku device connected to the same network as your computer.

---

## **1. Running Through BrightScript Extension (VS Code)**

Ensure to have Visual Studio Code installed on your computer

### **Step 1: Enable Developer Mode on Roku**
1. Press the following sequence on your Roku remote:

   ```
   Home x3 → Up x2 → Right → Left → Right → Left → Right
   ```
2. Enable **Developer Mode** and take note of the:
   - **Roku IP Address**
   - **Developer Mode Password**

---

### **Step 2: Install Required Tools**
- Open **VS Code**.
- Install the **BrightScript** extension:
   - Press `Ctrl + Shift + X` (Windows) or `Shift + Command + X` (Mac) (or click on Extensions).
   - Search for **BrightScript Language** and install it.

---

### **Step 3: Configure the included `launch.json`**
1. Open `launch.json` file inside `.vscode`
2. Replace `XXXXX` in `host` with your Roku device IP Address
3. Replace `XXXXX` in `password` with your Developer Mode Password

---

### **Step 4: Run and Debug**
- Press `F5` or `Run → Start Debugging` to run the app
- The app should load on your Roku device.
- Select `OK` on the remote control to open Home View

---

## **2. Sideloading a Roku App Using a Zip File**

This method is useful for manually installing the app on a Roku device.

### **Step 1: Locate the `roku-deploy.zip`** file

### **Step 2: Enable Developer Mode on Roku**
1. Press the following sequence on your Roku remote:

   ```
   Home x3 → Up x2 → Right → Left → Right → Left → Right
   ```
2. Enable **Developer Mode** and take note of the:
   - **Roku IP Address**
   - **Developer Mode Password**

---

### **Step 3: Upload ZIP File**
1. Open a browser and navigate to:

```
http://<ROKU_IP_ADDRESS>
```
2. Log in using:
   - **Username:** `rokudev`
   - **Password:** Developer mode password.
3. Click `Upload` and select the `roku-deploy.zip` file.
4. Click `Install with zip` to sideload the app.

---

### **Step 4: Run the App**
- After uploading, the app should run automatically.
- If it doesn’t, press `Home` and select the Roku Developers app.
- Select `OK` on the remote control to open Home View
