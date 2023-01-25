
# E-Wallet CLone

An E-Wallet Clone, built using **Ruby on Rails**.

## Description

#### Roles
- Admin
- User

#### User Functionalities
- Can Login/Signup
- Can Add Payee
- Can Create Transactions
- Can View Transactions
- Can View it's Wallet Balance

#### Admin Functionalities
- Can Login
- Can do what a user can do
- Can Load Balance into a Users account by creating a Transaction

## Prerequisites

The following are the dependencies used by the Project

- RVM 1.29
- Ruby [3.0](https://www.ruby-lang.org/en/news/2020/12/25/ruby-3-0-0-released/)
- Rails [7.0.4](https://guides.rubyonrails.org/7_0_release_notes.html)
- PostgreSql

## Setup

#### Clone:

```bash
  git@github.com:Hunzala-Malik/wallet-clone.git
```

#### Gems Installation:

```bash
  bundle
```
#### Database:
-  Edit your `credentials.yml.enc`, so that it is according to  the `database.yml` file configuration for Development.
```bash
 postgres:
    username: "your postgres username"
    password: "your postgres password"
```
- Setup Database
```bash
  rails db:create
  rails db:migrate
```
- To load seeding data
```bash
  rails db:seed
```

#### Run Server:

```bash
  ./bin/dev
```

## Authors

- [@hunzala-malik](https://github.com/Hunzala-Malik)

