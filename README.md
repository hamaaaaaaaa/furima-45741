# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


---

# 📘 データベース設計（ER 図）

## users テーブル
| Column          | Type     | Options                 |
|-----------------|----------|--------------------------|
| id              | bigint   | PK                       |
| nickname        | string   | null: false              |
| email           | string   | null: false, unique:true |
| encrypted_password | string | null: false             |
| last_name         | string   | null: false            |
| first_name        | string   | null: false            |
| last_name_kana    | string   | null: false            |
| first_name_kana   | string   | null: false            |
| birth_date        | date     | null: false            |

**Association**
- has_many :items  
- has_many :orders

---

## items テーブル
| Column          | Type       | Options                        |
|-----------------|------------|--------------------------------|
| id              | bigint     | PK                             |
|item_name.       | bigint.    | null: false.                   |
| delivery_area_id| integer    | null: false,                   |　
| delivery_day _id| integer    | null: false,                   |　
| description     | text       | null: false                    |
| price           | integer    | null: false                    |
| category_id     | integer    | null: false                    |
| condition_id    | integer    | null: false                    |
| shipping_chages_id| integer  | null: false                    |
| user_id         | bigint     | null: false, foreign_key: true, unique|


**Association**
- belongs_to :user  
- has_one :order

---

## orders テーブル（購入管理）
| Column   | Type       | Options                     　　　　　　|
|----------|------------|-----------------------------　　　　　　|
| id       | bigint     | PK                          　　　　　　|
| user     | references | null: false, foreign_key: true　　　　　|
| item     | references | null: false, foreign_key: true, unique|

**Association**
- belongs_to :user  
- belongs_to :item  
- has_one :address

---

## addresses テーブル（配送先情報）
| Column        | Type       | Options                     |
|---------------|------------|-----------------------------|
| id            | bigint     | PK                          |
| postal_code   | string     | null: false                 |
| prefecture_id | integer    | null: false                 |
| city          | string     | null: false                 |
| building_name | string     |　null: true　　　　           |
| address       | string     | null: false                 |
| phone_number  | string     | null: false                 |
| order_id      | bigint.    | null: false, foreign_key: true, unique     |

**制約条件（バリデーション）**
- postal_code: `3桁-4桁` の半角（例: 123-4567）
- phone_number: 10〜11桁の半角数字のみ（例: 09012345678）

**Association**
- belongs_to :order