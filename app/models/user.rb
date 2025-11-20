class User < ApplicationRecord
  # Devise のモジュール
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # -----------------------------
  # 独自バリデーション
  # -----------------------------
  # ニックネーム
  validates :nickname, presence: true

  # お名前（全角）
  validates :last_name,  presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: "は全角で入力してください" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: "は全角で入力してください" }

  # お名前カナ（全角カタカナ）
  validates :last_name_kana,  presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナで入力してください" }
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー]+\z/, message: "は全角カタカナで入力してください" }

  # 生年月日
  validates :birth_date, presence: true

  # パスワードはDeviseのvalidatableで必須・6文字以上・確認用との一致はチェック済み
  # 半角英数字混合は追加する場合
  validates :password, format: { with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/, message: "は半角英数字混合で入力してください" }, if: -> { password.present? }
end
