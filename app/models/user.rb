class User < ApplicationRecord
  # Devise のモジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :items
  
  # -----------------------------
  # 独自バリデーション
  # -----------------------------
  # ニックネーム
  validates :nickname, presence: true

  # お名前（全角）
  validates :last_name,  presence: true, format: { with: /\A[ぁ-んァ-ン一-龥ヶヵ]+\z/, message: "は全角で入力してください" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥ヶヵ]+\z/, message: "は全角で入力してください" }

  # お名前カナ（全角カタカナ）
  validates :last_name_kana,  presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナで入力してください" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナで入力してください" }

  # 生年月日
  validates :birth_date, presence: true

  # パスワード（Deviseのvalidatableで必須チェック済み）
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: "は半角英数字混合で入力してください" },
            if: -> { password.present? }
end
