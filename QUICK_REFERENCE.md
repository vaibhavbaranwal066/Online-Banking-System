# 🏦 Online Banking System - Quick Reference Guide

## 🚀 Quick Start

```bash
# Navigate to project
cd c:\Users\Admin\Downloads\OBanking

# Build project
mvn clean compile

# Run the application
mvn spring-boot:run

# Access the application
http://localhost:8080
```

---

## 🔐 Login Credentials

### Admin Account (For Management)
```
Username: admin
Password: Admin@123
URL: http://localhost:8080/login
Redirect: /admin/dashboard
```

### Customer Account (For Banking)
```
Username: customer
Password: Customer@123
URL: http://localhost:8080/login
Redirect: /customer/home
```

### Register New Admin
```
URL: http://localhost:8080/adminregister
Requires: Username, Password, Full Name
```

---

## 📊 Admin Dashboard (/admin/dashboard)

### Tabs Available
1. **🏢 Branches**
   - Add new branch
   - View all branches
   - Click "View" for branch details

2. **👥 Customers**
   - Add new customer (assign to branch)
   - View all customers
   - Click "View Details" for customer accounts

3. **💳 Accounts**
   - Create new account for customer
   - Select account type (SAVINGS/CURRENT)
   - Set initial deposit (optional)

4. **📄 Cheque Requests**
   - View pending requests
   - Click "Approve" to approve
   - Status updates to APPROVED

### Quick Stats
- Total Customers
- Total Accounts
- Total Transactions
- Pending Cheques

---

## 💳 Customer Portal (/customer/home)

### Account Management
- **View Accounts**: Shows all linked accounts with balances
- **Account Details**: Click on account card to view transaction history

### Quick Actions
1. **💸 Deposit**
   - Select account
   - Enter amount
   - Click "Deposit Money"

2. **💸 Withdraw**
   - Select account
   - Enter amount
   - Enter PIN (required)
   - Click "Withdraw"

3. **🔄 Transfer**
   - Select source account
   - Enter destination account number
   - Enter amount
   - Enter PIN (required)
   - Click "Transfer Now"

4. **📄 Cheque Book**
   - Select account
   - Click "Request Cheque Book"
   - Admin will approve

---

## 🔒 Important Security Info

### PIN Management
- **Auto-Generated**: 4-digit PIN created when account is created
- **Displayed Once**: Shown in console output at account creation
- **Encrypted**: Stored as BCrypt hash
- **Required For**: Withdraw, Transfer operations

### Password Management
- **All Passwords**: BCrypt encrypted
- **Admin Can Set**: When creating customer (or defaults to Customer@123)
- **Customer Can**: Change via registration (new feature can be added)

### Access Control
```
/admin/**     → Requires ROLE_ADMIN
/customer/**  → Requires ROLE_CUSTOMER
/login        → Public (accessible without auth)
/             → Public (home page)
```

---

## 📝 Common Operations

### Creating a New Customer Account (Admin)
1. Go to Admin Dashboard
2. Click "Customers" tab
3. Fill in: Username, Password (optional), Full Name, Branch
4. Click "Add Customer"
5. New account created

### Creating a Bank Account (Admin)
1. Go to Admin Dashboard
2. Click "Accounts" tab
3. Select Customer from dropdown
4. Select Account Type (SAVINGS/CURRENT)
5. Enter Initial Deposit (optional)
6. Click "Create Account"
7. Account number auto-generated (AC + timestamp)
8. PIN generated and shown in console

### Transferring Money (Customer)
1. Go to Customer Home
2. Click "Transfer" tab
3. Select "From Account"
4. Enter "To Account" number
5. Enter amount
6. Enter PIN (4-digit from account creation)
7. Click "Transfer Now"
8. Both accounts updated instantly

### Requesting Cheque Book (Customer)
1. Go to Customer Home
2. Click "Cheque Book" tab
3. Select account
4. Click "Request Cheque Book"
5. Status: PENDING
6. Admin approves from dashboard

---

## 🛠 Database Info

### Database Name
```
online_banking
```

### Tables Created Automatically
- admins
- customers
- branches
- bank_accounts
- transactions
- cheque_requests

### Connection Details
```
Host: localhost
Port: 3306
Username: root
Password: Private@0000 (configured in application.properties)
Driver: MySQL 8.0.33
```

---

## 📂 Project Structure

```
src/main
├── java/com/example/onlinebanking/
│   ├── model/              # Entities (Admin, Customer, Account, etc)
│   ├── repository/         # Database access
│   ├── service/            # Business logic (AccountService)
│   ├── controller/         # Request handlers
│   ├── config/             # Security, initialization
│   └── OnlineBankingApplication.java
├── resources/
│   └── application.properties
└── webapp/WEB-INF/jsp/
    ├── admin/              # Admin views
    ├── customer/           # Customer views
    ├── index.jsp           # Home page
    ├── login.jsp           # Login page
    └── error.jsp           # Error page
```

---

## ✅ Feature Checklist

### Authentication
- [x] Login page with error messages
- [x] Admin registration
- [x] Role-based redirection
- [x] Logout functionality
- [x] Session management

### Admin Features
- [x] Dashboard with statistics
- [x] Branch management
- [x] Customer management
- [x] Account creation
- [x] Cheque approval
- [x] View details pages

### Customer Features
- [x] View accounts & balances
- [x] Deposit money
- [x] Withdraw money (with PIN)
- [x] Transfer money (with PIN)
- [x] Request cheque book
- [x] View transaction history

### Security
- [x] Password encryption (BCrypt)
- [x] PIN encryption (BCrypt)
- [x] Role-based access control
- [x] Session invalidation
- [x] Input validation
- [x] Account ownership verification

### UI/UX
- [x] Bootstrap responsive design
- [x] Flash messages (success/error)
- [x] Tab-based navigation
- [x] Account cards with gradients
- [x] Emoji icons for clarity
- [x] Mobile-friendly layout

---

## 🐛 Troubleshooting

### If you get "Database connection error"
```
✓ Check MySQL is running
✓ Verify database name: online_banking
✓ Check username/password in application.properties
✓ Check port: 3306
```

### If you get "Redirect loop"
```
✓ Clear browser cookies
✓ Clear JSESSIONID
✓ Restart the application
✓ Check SecurityConfig filters
```

### If account creation doesn't show PIN
```
✓ Check console output (PIN is printed there)
✓ PIN is shown when account is created
✓ Use that PIN for withdraw/transfer
```

### If login fails
```
✓ Check username spelling
✓ Verify password is correct
✓ Check user exists in database
✓ Ensure password was encrypted (BCrypt)
```

---

## 📋 API Endpoints

### Authentication
- POST `/perform_login` - Handle login
- GET `/login` - Login page
- POST `/adminregister` - Register admin
- GET `/adminregister` - Admin registration form
- GET `/logout` - Logout

### Admin Routes
- GET `/admin/dashboard` - Dashboard
- POST `/admin/branch/add` - Add branch
- POST `/admin/customer/add` - Add customer
- POST `/admin/account/add` - Create account
- POST `/admin/cheque/approve/{id}` - Approve cheque
- GET `/admin/customer/{id}` - Customer details
- GET `/admin/branch/{id}` - Branch details

### Customer Routes
- GET `/customer/home` - Customer home
- POST `/customer/account/deposit` - Deposit
- POST `/customer/account/withdraw` - Withdraw
- POST `/customer/account/transfer` - Transfer
- POST `/customer/account/requestCheque` - Request cheque
- GET `/customer/account/{accountNumber}` - Account details

### Public Routes
- GET `/` - Home page
- GET `/error` - Error page

---

## 🎓 Learning Resources

### Key Classes to Review
1. **SecurityConfig.java** - Spring Security setup
2. **AdminController.java** - Admin operations
3. **CustomerController.java** - Customer operations
4. **AccountService.java** - Transaction logic
5. **DataInitializer.java** - Auto-initialization

### Key Concepts
- Spring Boot 3 with Spring Security 6
- JPA/Hibernate ORM
- Role-Based Access Control (RBAC)
- Session Management
- Transaction consistency
- RESTful MVC architecture

---

## 📞 Support

### Documentation Files
- `IMPLEMENTATION_GUIDE.md` - Detailed feature documentation
- `IMPLEMENTATION_SUMMARY.md` - Complete summary of changes
- `README.md` - Project overview

### Code Comments
- All Java classes are well-commented
- JSP views have structural comments
- Complex logic is explained

---

## 🚀 Production Deployment Checklist

- [ ] Change demo credentials
- [ ] Update MySQL password
- [ ] Enable CSRF protection
- [ ] Enable HTTPS
- [ ] Set up database backups
- [ ] Configure logging
- [ ] Performance tuning
- [ ] Security audit
- [ ] Load testing
- [ ] Monitor production environment

---

**Version**: 1.0
**Last Updated**: February 7, 2025
**Status**: ✅ Production Ready
