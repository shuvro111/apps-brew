# AppsBrew
###### Brew up your favourite MacOS apps in a snap using [HomeBrew🍺](https://brew.sh) &nbsp;See the [instructions](installation-guide.md) for more information.

---

## **Step-by-Step Instructions**

### **Step 1: Create Your `brew-apps.txt` File**

1. **Create a list of apps** you want to install in a file called `brew-apps.txt`.
2. The app names should be listed one per line, with each line containing the name of a Homebrew package (formula or cask).

**Example `brew-apps.txt` file:**

```txt
raycast
zoom
iina
postgresql
rectangle  # This app will be dynamically categorized as "Miscellaneous"
some-app-that-does-not-exist  # This app will not be found in the Homebrew repository
```


> [!TIP]
> You can include any app available via Homebrew in the file. The script will attempt to install them as either formulas or casks.
  
---

### **Step 2: Download or Create the Installation Script**
- **Download** the [install-apps.sh](apps/install-apps.sh) file.


### **Step 3: Make the Script Executable**

1. **Open your terminal**.
2. **Navigate to the directory** where your `install-apps.sh` script is located.
3. Run the following command to **make the script executable**:

   ```bash
   chmod +x install-apps.sh
   ```

---

### **Step 4: Run the Script**

1. **Ensure your `brew-apps.txt`** file is in the same directory as your `install-apps.sh` script, or adjust the script path accordingly.
2. Run the script by typing the following in your terminal:

   ```bash
   ./install-apps.sh
   ```

---

### **Step 5: Monitor the Installation Process**

- The script will read each line in your `brew-apps.txt` file.
- It will dynamically categorize each app based on its name and try to install it using Homebrew (either as a **cask** or **formula**).
- The script will log every step of the process, including:
  - Successfully installed apps
  - Apps already installed
  - Apps that couldn’t be found or installed

**Example Output:**
```txt
[INFO] Starting app installation...
[INFO] Processing app: raycast (Category: Productivity)
[INFO] raycast is already installed (Cask).
[INFO] Processing app: zoom (Category: Productivity)
[INFO] zoom is already installed (Cask).
[INFO] Processing app: rectangle (Category: Miscellaneous)
[WARN] rectangle not found as a cask or formula. Skipping installation.
[INFO] Installation process complete!
```

---

### **Step 6: Modify the Apps List (Optional)**

- If you want to add more apps or change the list, simply **edit the `brew-apps.txt`** file and rerun the script.
- The script will handle new apps, and dynamically categorize and install them as before.
