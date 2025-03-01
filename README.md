# CampusLeave

CampusLeave is a **Flutter-based** leave approval application designed for students faculty advisors and warden. The app streamlines the leave request process by allowing students to send requests via email, while faculty can approve or decline them with a single click.

## 📌 Features

### **For Students:**

- **User Authentication**: Sign in using institute email (`.iitj.ac.in`).
- **Leave Request Submission**: Send leave requests to the faculty advisor and warden via email.
- **Recent Activity Drawer**: View sent emails categorized under faculty and warden.
- **Email Details Page**: See details of sent requests.

### **For Faculty and Warden:**

- **View Requests**: A dedicated home screen to see all received requests.
- **Accept/Decline Requests**: Faculty and Warden can approve or reject requests directly from the email details page.
- **Accepted & Declined Emails Page**: View categorized leave requests.

## 🖥️ Tech Stack

- **Flutter** - Cross-platform app development
- **Firebase Authentication** - User login system
- **EmailJS** - For handling email requests
- **Provider (Riverpod)** - State management

---

## 📸 Screenshots

### **Login Screen**

![Login](screenshots/login-screen.jpg)

### **Signup Screen**

![Signup](screenshots/signup-screen.jpg)

### **Student Home Screen**

![Student Home](screenshots/feed.jpg)

### **Faculty Home Screen**

![Faculty Home](screenshots/feed-dark.jpg)

### **Student Recent Activity Drawer**

![Recent Activity](screenshots/post-options.jpg)

### **Email Details Page for Student**

![Email Details](screenshots/post-text.jpg)

### **Accept/Decline Email Page for Faculty**

![Faculty Email Actions](screenshots/post-link.jpg)

### **Accepted Emails Page**

![Accepted Emails](screenshots/user-profile.jpg)

### **Declined Emails Page**

![Declined Emails](screenshots/community-profile.jpg)

### **Mail Composing Page for Student**

![Compose Mail](screenshots/post-image.jpg)

---

## 🚀 How to Run the App

### **1. Clone the Repository**

```sh
git clone https://github.com/your-username/CampusLeave.git
cd CampusLeave
```

### **2. Install Dependencies**

```sh
flutter pub get
```

### **3. Run the Application**

```sh
flutter run
```

### **4. Build APK (Optional)**

To generate an APK:

```sh
flutter build apk --release
```

---

🔗 **GitHub Repository:** [CampusLeave](https://github.com/your-username/CampusLeave)
